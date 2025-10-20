"""
SLIAC Player Stats Scraper - Script #3
Extracts individual player performance from box score PDFs

Usage:
    python scraper/fixtures/3_update_player_stats.py

Requirements:
    pip install requests beautifulsoup4 pdfplumber

Flow:
    1. Finds all completed fixtures (those with results in FixtureResults table)
    2. For each fixture, downloads the box score PDF
    3. Extracts player stats (goals, assists, minutes, cards, saves)
    4. Generates SQL INSERT statements for PlayerFixtureStats table
"""

import requests
from bs4 import BeautifulSoup
import pdfplumber
import json
import os
import re
from datetime import datetime

# Base URL
BASE_URL = 'https://sliac.org'

# Browser headers to avoid 404
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'keep-alive',
}

def get_pdf_url_from_boxscore(boxscore_url):
    """
    Two-step process to get the actual PDF URL:
    1. Scrape box score page -> get document.aspx link
    2. Scrape document viewer page -> get S3 PDF URL from "Open" button
    """
    print(f"   Step 1: Fetching box score page...")
    
    try:
        response = requests.get(boxscore_url, headers=HEADERS, timeout=30)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"   [ERROR] Error fetching box score page: {e}")
        return None
    
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find the PDF link in the print-bar div
    print_bar = soup.find('div', id='print-bar')
    if not print_bar:
        print(f"   [ERROR] Could not find print-bar div")
        return None
    
    pdf_link = print_bar.find('a', href=re.compile(r'/document\.aspx'))
    if not pdf_link:
        print(f"   [ERROR] Could not find PDF link")
        return None
    
    document_path = pdf_link.get('href')
    document_url = BASE_URL + document_path
    print(f"   [OK] Found document viewer URL")
    
    # Step 2: Fetch the document viewer page to get the S3 PDF link
    print(f"   Step 2: Fetching document viewer page...")
    try:
        response = requests.get(document_url, headers=HEADERS, timeout=30)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"   [ERROR] Error fetching document viewer: {e}")
        return None
    
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find the "Open" button which has the direct S3 PDF link
    # <li id="ctl00_cplhMainContent_btnOpen" class="sidearm-document-header-open">
    #     <a href="https://s3.us-east-2.amazonaws.com/.../pdf/xxxxx.pdf">Open</a>
    open_button = soup.find('li', class_='sidearm-document-header-open')
    if not open_button:
        print(f"   [ERROR] Could not find Open button")
        return None
    
    s3_link = open_button.find('a')
    if not s3_link:
        print(f"   [ERROR] Could not find S3 PDF link")
        return None
    
    pdf_url = s3_link.get('href')
    if not pdf_url or 'amazonaws.com' not in pdf_url:
        print(f"   [ERROR] Invalid PDF URL: {pdf_url}")
        return None
    
    print(f"   [OK] Found S3 PDF URL!")
    return pdf_url

def download_pdf(pdf_url, output_path):
    """
    Download PDF file from S3 URL
    """
    print(f"   Downloading PDF from S3...")
    
    try:
        response = requests.get(pdf_url, headers=HEADERS, timeout=30, allow_redirects=True)
        response.raise_for_status()
        
        # Verify it's actually a PDF
        if response.content[:4] != b'%PDF':
            print(f"   [ERROR] Downloaded file is not a PDF!")
            print(f"   Content-Type: {response.headers.get('Content-Type', 'unknown')}")
            return False
        
        with open(output_path, 'wb') as f:
            f.write(response.content)
        
        print(f"   [OK] PDF downloaded ({len(response.content)} bytes)")
        return True
    except requests.exceptions.RequestException as e:
        print(f"   [ERROR] Error downloading PDF: {e}")
        return False

def clean_player_name(name):
    """
    Clean player name (remove jersey numbers, extra spaces, etc.)
    Example: "7  Joya, Effenberg" -> "Effenberg Joya"
    """
    # Remove leading numbers and spaces
    name = re.sub(r'^\d+\s+', '', name)
    
    # If format is "Last, First", convert to "First Last"
    if ',' in name:
        parts = name.split(',')
        if len(parts) == 2:
            last, first = parts
            name = f"{first.strip()} {last.strip()}"
    
    return name.strip()

def parse_pdf_stats(pdf_path):
    """
    Extract player stats from PDF using text parsing
    Returns: {
        'home_team': str,
        'away_team': str,
        'home_players': [{name, pos, min, goals, assists, ...}, ...],
        'away_players': [...],
        'home_gk': {...},
        'away_gk': {...}
    }
    """
    print(f"   Parsing PDF...")
    
    stats = {
        'home_team': None,
        'away_team': None,
        'home_players': [],
        'away_players': [],
        'home_gk': None,
        'away_gk': None
    }
    
    try:
        with pdfplumber.open(pdf_path) as pdf:
            # Extract text from first page
            page = pdf.pages[0]
            text = page.extract_text()
            
            if not text:
                print(f"   [ERROR] No text found in PDF")
                return None
            
            lines = text.split('\n')
            
            # FIRST PASS: Parse cautions and ejections to track cards by jersey number
            card_tracker = {}  # {jersey_num: {'yellow': count, 'red': count}}
            for line in lines:
                line_stripped = line.strip()
                if line_stripped.startswith('Cautions and Ejections:'):
                    # Format: "Cautions and Ejections: TIME (YELLOW/RED), #JERSEY PlayerName (TEAM)"
                    # Can have multiple: "...TIME (YELLOW), #19 Name (TEAM); TIME (YELLOW), #5 Name (TEAM)"
                    cards_text = line_stripped.replace('Cautions and Ejections:', '').strip()
                    
                    # Find all patterns: "(YELLOW/RED), #NUMBER"
                    # Format: "TIME (YELLOW), #19 PlayerName (TEAM)"
                    card_entries = re.findall(r'\((YELLOW|RED)\),\s+#(\d+)', cards_text)
                    for card_type, jersey_str in card_entries:
                        jersey_num = int(jersey_str)
                        if jersey_num not in card_tracker:
                            card_tracker[jersey_num] = {'yellow': 0, 'red': 0}
                        
                        if card_type == 'YELLOW':
                            card_tracker[jersey_num]['yellow'] += 1
                        elif card_type == 'RED':
                            card_tracker[jersey_num]['red'] += 1
                    
                    print(f"   [INFO] Found {len(card_entries)} card(s)")
            
            # Parse header to get team names
            # Format: "Principia (3-3-1, 1-0-0) -vs- The W (3-6-0, 0-1-0)"
            header = lines[0]
            match = re.search(r'(.+?)\s+\([^)]+\)\s+-vs-\s+(.+?)\s+\([^)]+\)', header)
            if match:
                stats['home_team'] = match.group(1).strip()
                stats['away_team'] = match.group(2).strip()
                print(f"   [OK] Teams: {stats['home_team']} vs {stats['away_team']}")
            
            # Find player stats sections
            # Looking for lines like: "Pos # Player SH SOG G A MIN"
            in_home_players = False
            in_away_players = False
            in_goalkeepers = False
            
            for i, line in enumerate(lines):
                line = line.strip()
                
                # Detect player stats header
                if 'Pos # Player' in line and 'SH SOG G A MIN' in line:
                    # Next section will be player stats
                    # Determine if it's home or away based on context
                    if not in_home_players:
                        in_home_players = True
                        in_away_players = False
                    else:
                        in_home_players = False
                        in_away_players = True
                    continue
                
                # Detect goalkeeper section
                if '# Goalkeepers Minutes GA Saves' in line:
                    in_home_players = False
                    in_away_players = False
                    in_goalkeepers = True
                    current_gk_is_away = (len(stats['home_players']) == 0)  # First GK section is away team
                    continue
                
                # Parse goalkeeper stats
                if in_goalkeepers:
                    # Skip "Totals" line
                    if line.startswith('Totals') or not line:
                        continue
                    
                    # GK line format: "# Name MM:SS GA Saves"
                    # Example: "1 Gutierrez, Nick 80:49 5 10"
                    parts = line.split()
                    if len(parts) >= 5:
                        try:
                            jersey_num = int(parts[0])
                            
                            # Last 3 parts are: Minutes GA Saves
                            saves = int(parts[-1])
                            goals_against = int(parts[-2])
                            minutes_str = parts[-3]  # Format: "80:49" or "90:00"
                            
                            # Convert MM:SS to total minutes
                            if ':' in minutes_str:
                                mins, secs = minutes_str.split(':')
                                total_minutes = int(mins)  # We'll just use the minute part
                            else:
                                total_minutes = int(minutes_str)
                            
                            # Everything between jersey and minutes is the name
                            name_parts = parts[1:-3]
                            name = ' '.join(name_parts)
                            name = clean_player_name(name)
                            
                            # Get cards for this player
                            yellow_cards = card_tracker.get(jersey_num, {}).get('yellow', 0)
                            red_cards = card_tracker.get(jersey_num, {}).get('red', 0)
                            
                            gk_stats = {
                                'name': name,
                                'pos': 'GK',
                                'jersey': jersey_num,
                                'minutes': total_minutes,
                                'goals': 0,  # GKs don't score (usually)
                                'assists': 0,
                                'shots': 0,
                                'sog': 0,
                                'saves': saves,
                                'goals_against': goals_against,
                                'clean_sheet': 0,  # Will be calculated after parsing
                                'yellow_cards': yellow_cards,
                                'red_cards': red_cards
                            }
                            
                            # Add to appropriate team (two GK sections: away first, home second)
                            if current_gk_is_away:
                                # Check if we already have GK stats from field player section
                                existing = next((p for p in stats['away_players'] if p['jersey'] == jersey_num and p['pos'] == 'GK'), None)
                                if existing:
                                    existing.update(gk_stats)
                                else:
                                    stats['away_players'].append(gk_stats)
                            else:
                                existing = next((p for p in stats['home_players'] if p['jersey'] == jersey_num and p['pos'] == 'GK'), None)
                                if existing:
                                    existing.update(gk_stats)
                                else:
                                    stats['home_players'].append(gk_stats)
                        except (ValueError, IndexError) as e:
                            continue
                
                # Parse player stats
                if in_home_players or in_away_players:
                    # Skip header lines like "Starters", "Substitutes", "Totals"
                    if line in ['Starters', 'Substitutes', 'Totals'] or not line:
                        continue
                    
                    # PDF has two columns side-by-side. Need to split the line
                    # Look for the pattern where stats from both teams are concatenated
                    # Example: "GK 1 Gutierrez, Nick 0 0 0 0 81 GK 0 Deeken, Hunter 0 0 0 0 90"
                    
                    parts = line.split()
                    if len(parts) < 7:
                        continue
                    
                    # IMPROVED: Find the midpoint - look for duplicate position codes
                    # Strategy: Find all position codes, then validate the second one
                    pos_indices = [i for i, p in enumerate(parts) if p in ['GK', 'DEF', 'MID', 'FWD']]
                    
                    midpoint = None
                    if len(pos_indices) >= 2:
                        # We have at least 2 position codes, likely two columns
                        # The second position code should be followed by a jersey number
                        for idx in pos_indices[1:]:
                            try:
                                # Check if next element is a number (jersey)
                                # And we have enough elements after it (at least 6 more for stats + name)
                                if idx + 6 < len(parts):
                                    int(parts[idx + 1])
                                    # Validate that the last 5 elements before this point are numbers (stats)
                                    if idx >= 5:
                                        test_stats = parts[idx-5:idx]
                                        all_nums = all(p.isdigit() for p in test_stats)
                                        if all_nums:
                                            midpoint = idx
                                            break
                            except (ValueError, IndexError):
                                continue
                    
                    # Split into two halves if midpoint found
                    lines_to_parse = []
                    if midpoint:
                        left_half = ' '.join(parts[:midpoint])
                        right_half = ' '.join(parts[midpoint:])
                        lines_to_parse = [(left_half, True), (right_half, False)]  # (text, is_away)
                    else:
                        # Single column, parse as-is
                        lines_to_parse = [(line, in_away_players)]
                    
                    for player_line, is_away_player in lines_to_parse:
                        parts = player_line.split()
                        if len(parts) < 7:
                            continue
                        
                        try:
                            pos = parts[0]
                            if pos not in ['GK', 'DEF', 'MID', 'FWD']:
                                continue
                            
                            jersey_num = int(parts[1])
                            
                            # Last 5 parts are: SH SOG G A MIN
                            mins = int(parts[-1])
                            assists = int(parts[-2])
                            goals = int(parts[-3])
                            sog = int(parts[-4])
                            shots = int(parts[-5])
                            
                            # Everything between jersey_num and shots is the name
                            name_parts = parts[2:-5]
                            name = ' '.join(name_parts)
                            name = clean_player_name(name)
                            
                            # Get cards for this player
                            yellow_cards = card_tracker.get(jersey_num, {}).get('yellow', 0)
                            red_cards = card_tracker.get(jersey_num, {}).get('red', 0)
                            
                            player = {
                                'name': name,
                                'pos': pos,
                                'jersey': jersey_num,
                                'minutes': mins,
                                'goals': goals,
                                'assists': assists,
                                'shots': shots,
                                'sog': sog,
                                'saves': 0,  # Will be updated from GK section if applicable
                                'goals_against': 0,  # Will be updated from GK section if applicable
                                'clean_sheet': 0,  # Will be calculated after parsing
                                'yellow_cards': yellow_cards,
                                'red_cards': red_cards
                            }
                            
                            # First time seeing players: left column is away, right is home
                            if in_home_players and not in_away_players:
                                # First player section
                                if is_away_player:
                                    stats['away_players'].append(player)
                                else:
                                    stats['home_players'].append(player)
                            else:
                                # Already seen both columns, this shouldn't happen
                                stats['home_players'].append(player)
                        except (ValueError, IndexError) as e:
                            continue
            
            print(f"   [OK] Parsed {len(stats['home_players'])} home players, {len(stats['away_players'])} away players")
            
            # Calculate clean sheets for GKs and Defenders
            # Clean sheet = team conceded 0 goals
            home_gks = [p for p in stats['home_players'] if p['pos'] == 'GK']
            away_gks = [p for p in stats['away_players'] if p['pos'] == 'GK']
            
            # Total goals conceded by each team
            home_goals_conceded = sum(gk.get('goals_against', 0) for gk in home_gks)
            away_goals_conceded = sum(gk.get('goals_against', 0) for gk in away_gks)
            
            # Assign clean sheets to GKs and Defenders
            for player in stats['home_players']:
                if player['pos'] in ['GK', 'DEF'] and player['minutes'] >= 60:
                    player['clean_sheet'] = 1 if home_goals_conceded == 0 else 0
                else:
                    player['clean_sheet'] = 0
            
            for player in stats['away_players']:
                if player['pos'] in ['GK', 'DEF'] and player['minutes'] >= 60:
                    player['clean_sheet'] = 1 if away_goals_conceded == 0 else 0
                else:
                    player['clean_sheet'] = 0
            
            print(f"   [OK] Clean sheets: Home={1 if home_goals_conceded == 0 else 0}, Away={1 if away_goals_conceded == 0 else 0}")
            
    except Exception as e:
        print(f"   [ERROR] Error parsing PDF: {e}")
        import traceback
        traceback.print_exc()
        return None
    
    return stats

def generate_sql(fixture_data):
    """
    Generate SQL INSERT statements for PlayerFixtureStats
    
    Args:
        fixture_data: {
            'fixture_id': int,  # Not used - we'll find fixture dynamically
            'home_team': str,
            'away_team': str,
            'match_date': str,  # Need to add this
            'home_players': [...],
            'away_players': [...]
        }
    """
    sql = []
    sql.append("-- =====================================================")
    sql.append(f"-- Player Stats for: {fixture_data['away_team']} vs {fixture_data['home_team']}")
    sql.append(f"-- Match Date: {fixture_data.get('match_date', 'UNKNOWN')}")
    sql.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    sql.append("-- =====================================================")
    sql.append("")
    
    # First, find the fixture ID dynamically
    sql.append("-- Find fixture ID dynamically based on teams")
    sql.append("DECLARE @FixtureId INT;")
    sql.append("DECLARE @Team1Id INT, @Team2Id INT;")
    sql.append("")
    sql.append(f"-- Get team IDs")
    sql.append(f"SELECT @Team1Id = Id FROM ConferenceTeams WHERE Team = '{fixture_data['home_team']}';")
    sql.append(f"SELECT @Team2Id = Id FROM ConferenceTeams WHERE Team = '{fixture_data['away_team']}';")
    sql.append("")
    sql.append(f"-- Find fixture (checking both home/away combinations)")
    sql.append(f"SELECT TOP 1 @FixtureId = f.Id")
    sql.append(f"FROM Fixtures f")
    sql.append(f"WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)")
    sql.append(f"    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))")
    if 'match_date' in fixture_data and fixture_data['match_date']:
        sql.append(f"  AND ABS(DATEDIFF(day, f.Kickoff, '{fixture_data['match_date']}')) <= 7")
    sql.append(f"ORDER BY ABS(DATEDIFF(day, f.Kickoff, '{fixture_data.get('match_date', '2025-01-01')}'));")
    sql.append("")
    sql.append("IF @FixtureId IS NULL")
    sql.append("BEGIN")
    sql.append(f"    PRINT 'ERROR: Could not find fixture for {fixture_data['away_team']} vs {fixture_data['home_team']}';")
    sql.append("    RETURN;")
    sql.append("END")
    sql.append("")
    sql.append(f"PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));")
    sql.append("")
    
    # Process all players (home and away)
    all_players = []
    for player in fixture_data['away_players']:
        all_players.append((player, fixture_data['away_team']))
    for player in fixture_data['home_players']:
        all_players.append((player, fixture_data['home_team']))
    
    for player, team in all_players:
        name = player['name'].replace("'", "''")  # Escape quotes
        jersey = player['jersey']
        minutes = player['minutes']
        goals = player['goals']
        assists = player['assists']
        saves = player.get('saves', 0)
        goals_conceded = player.get('goals_against', 0)
        clean_sheet = 1 if player.get('clean_sheet', 0) else 0
        yellow_cards = player.get('yellow_cards', 0)
        red_cards = player.get('red_cards', 0)
        
        # Skip players with 0 minutes (not used)
        if minutes == 0:
            continue
        
        sql.append(f"""-- {name} ({player['pos']}) - {team}
DECLARE @PlayerId INT;

-- Find player by name, jersey, and team
SELECT TOP 1 @PlayerId = p.Id
FROM Players p
INNER JOIN ConferenceTeams ct ON p.TeamId = ct.Id
WHERE ct.Team = '{team}'
  AND p.JerseyNumber = {jersey}
  AND (
    p.Name LIKE '%{name.split()[0]}%'  -- Match first name
    OR p.Name LIKE '%{name.split()[-1]}%'  -- Match last name
    OR p.Name = '{name}'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM PlayerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE PlayerFixtureStats
        SET MinutesPlayed = {minutes},
            Goals = {goals},
            Assists = {assists},
            YellowCards = {yellow_cards},
            RedCards = {red_cards},
            CleanSheet = {clean_sheet},
            GoalsConceded = {goals_conceded},
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = {saves}
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for {name}';
    END
    ELSE
    BEGIN
        INSERT INTO PlayerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, {minutes}, {goals}, {assists}, {yellow_cards}, {red_cards}, {clean_sheet}, {goals_conceded}, 0, {saves});
        PRINT '[OK] Inserted stats for {name}';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: {name} (Jersey #{jersey}, Team: {team})';
END
GO

""")
    
    sql.append("-- =====================================================")
    sql.append(f"-- Complete! Processed {len(all_players)} players")
    sql.append("-- =====================================================")
    
    return '\n'.join(sql)

def process_all_fixtures_from_json(retry_failed=False):
    """
    Process all fixtures with box score URLs from fixtures.json
    
    Args:
        retry_failed: If True, retry previously failed fixtures. If False, skip already processed ones.
    """
    print("=" * 70)
    print("SLIAC Player Stats Scraper - BATCH MODE")
    print("Processing ALL fixtures with box scores")
    print("=" * 70)
    
    # Load fixtures from JSON
    fixtures_file = 'output/fixtures.json'
    if not os.path.exists(fixtures_file):
        print(f"\n[ERROR] Fixtures file not found: {fixtures_file}")
        print("   Please run 1_setup_fixtures.py first")
        return
    
    with open(fixtures_file, 'r', encoding='utf-8') as f:
        fixtures = json.load(f)
    
    # Load processing log (track which fixtures have been processed)
    output_dir = 'output'
    log_file = os.path.join(output_dir, 'processing_log.json')
    
    if os.path.exists(log_file):
        with open(log_file, 'r', encoding='utf-8') as f:
            processing_log = json.load(f)
        print(f"\n[INFO] Loaded processing log: {len(processing_log)} previous attempts")
    else:
        processing_log = {}
        print(f"\n[INFO] No previous log found, starting fresh")
    
    # Filter fixtures with box_score_url
    fixtures_with_scores = [(i+1, f) for i, f in enumerate(fixtures) if f.get('box_score_url')]
    
    # Filter based on retry_failed flag
    if not retry_failed:
        # Skip already successfully processed fixtures
        fixtures_to_process = [(fid, f) for fid, f in fixtures_with_scores 
                               if str(fid) not in processing_log or processing_log[str(fid)]['status'] != 'success']
        skipped = len(fixtures_with_scores) - len(fixtures_to_process)
        if skipped > 0:
            print(f"   [SKIP]  Skipping {skipped} already processed fixtures")
    else:
        # Retry everything (including previously failed)
        fixtures_to_process = fixtures_with_scores
        print(f"   [RETRY] Retry mode: Processing all {len(fixtures_to_process)} fixtures")
    
    print(f"\n[INFO] Processing {len(fixtures_to_process)} fixtures")
    
    all_sql = []
    successful = 0
    failed = 0
    
    for fixture_id, fixture in fixtures_to_process:
        error_reason = None
        try:
            box_score_url = fixture['box_score_url']  # Already a complete URL
            print(f"\n[{successful+failed+1}/{len(fixtures_to_process)}] Fixture #{fixture_id}: {fixture['home']} vs {fixture['away']}")
            
            # Get PDF URL
            pdf_url = get_pdf_url_from_boxscore(box_score_url)
            if not pdf_url:
                error_reason = "PDF URL not found (no print-bar or timeout)"
                print(f"   [ERROR] {error_reason}")
                failed += 1
                processing_log[str(fixture_id)] = {
                    'status': 'failed',
                    'reason': error_reason,
                    'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                }
                continue
            
            # Download PDF
            pdf_dir = os.path.join(output_dir, 'pdfs')
            os.makedirs(pdf_dir, exist_ok=True)
            pdf_path = os.path.join(pdf_dir, f'fixture_{fixture_id}.pdf')
            
            if not download_pdf(pdf_url, pdf_path):
                error_reason = "PDF download failed"
                print(f"   [ERROR] {error_reason}")
                failed += 1
                processing_log[str(fixture_id)] = {
                    'status': 'failed',
                    'reason': error_reason,
                    'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                }
                continue
            
            # Parse PDF
            stats = parse_pdf_stats(pdf_path)
            if not stats:
                error_reason = "PDF parsing failed"
                print(f"   [ERROR] {error_reason}")
                failed += 1
                processing_log[str(fixture_id)] = {
                    'status': 'failed',
                    'reason': error_reason,
                    'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                }
                continue
            
            # Generate SQL
            fixture_data = {
                'fixture_id': fixture_id,  # Kept for logging, but not used in SQL
                'home_team': stats['home_team'],
                'away_team': stats['away_team'],
                'match_date': fixture.get('date', ''),  # Add match date
                'home_players': stats['home_players'],
                'away_players': stats['away_players']
            }
            sql = generate_sql(fixture_data)
            all_sql.append(sql)
            
            print(f"   [OK] Parsed {len(stats['home_players'])} home + {len(stats['away_players'])} away players")
            successful += 1
            
            # Log success
            processing_log[str(fixture_id)] = {
                'status': 'success',
                'home_team': stats['home_team'],
                'away_team': stats['away_team'],
                'player_count': len(stats['home_players']) + len(stats['away_players']),
                'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            }
            
        except Exception as e:
            error_reason = f"Exception: {str(e)}"
            print(f"   [ERROR] Error: {e}")
            failed += 1
            processing_log[str(fixture_id)] = {
                'status': 'failed',
                'reason': error_reason,
                'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            }
    
    # Save processing log
    with open(log_file, 'w', encoding='utf-8') as f:
        json.dump(processing_log, f, indent=2)
    print(f"\n[SAVE] Saved processing log to: {log_file}")
    
    # Save combined SQL file
    if all_sql:
        combined_sql_file = os.path.join(output_dir, 'update_player_stats_ALL.sql')
        with open(combined_sql_file, 'w', encoding='utf-8') as f:
            f.write('\n\n'.join(all_sql))
        print(f"[SAVE] Saved combined SQL to: {combined_sql_file}")
    
    print("\n" + "=" * 70)
    print("[OK] BATCH PROCESSING COMPLETE!")
    print("=" * 70)
    print(f"\nResults:")
    print(f"  [OK] Successful: {successful}")
    print(f"  [ERROR] Failed:     {failed}")
    print(f"  [INFO] Total:      {len(fixtures_to_process)}")
    
    # Show detailed failure reasons
    if failed > 0:
        print(f"\n[ERROR] Failed Fixtures:")
        for fid, log in processing_log.items():
            if log['status'] == 'failed':
                fixture = fixtures[int(fid)-1]
                print(f"  #{fid}: {fixture['home']} vs {fixture['away']}")
                print(f"        Reason: {log['reason']}")
    
    # Show summary statistics
    total_in_db = len([log for log in processing_log.values() if log['status'] == 'success'])
    print(f"\n[INFO] Database Status:")
    print(f"  Total fixtures with stats: {total_in_db}/{len(fixtures_with_scores)}")
    print(f"  Coverage: {total_in_db/len(fixtures_with_scores)*100:.1f}%")
    
    print(f"\n💡 Tips:")
    print(f"  - To retry ONLY failed fixtures: Call with retry_failed=False (default)")
    print(f"  - To reprocess ALL fixtures: Call with retry_failed=True")
    print(f"  - For new matches: Just run again, it auto-detects new fixtures!")

def main():
    print("=" * 70)
    print("SLIAC Player Stats Scraper")
    print("Step 3: Extract individual player performance from box scores")
    print("=" * 70)
    
    # For testing, let's use the example box score URL
    test_boxscore_url = 'https://sliac.org/boxscore.aspx?id=7ltyipP022aUJKmSgYVs3wXi7up73ghniwD5ElWyd07J7BNseBaMQePf0fY%2f3yUPHm91vN8%2fxNmX0fZ76O4VgYXfoPIBWaBCbtgxtCYtGJZFZeiZ9jF00raZ%2bZRxwj6NSprG3N6H01a7WcXuOZYPV40jg%2bHqdEKm0ohTyHFR37g%3d&path=msoc'
    
    print(f"\n🎯 Testing with sample box score:")
    print(f"   URL: {test_boxscore_url}")
    
    # Step 1: Get PDF URL from box score page
    pdf_url = get_pdf_url_from_boxscore(test_boxscore_url)
    if not pdf_url:
        print("\n[ERROR] Failed to get PDF URL")
        return
    
    # Step 2: Download PDF
    output_dir = 'scraper/fixtures/output/pdfs'
    os.makedirs(output_dir, exist_ok=True)
    pdf_path = os.path.join(output_dir, 'test_boxscore.pdf')
    
    if not download_pdf(pdf_url, pdf_path):
        print("\n[ERROR] Failed to download PDF")
        return
    
    # Step 3: Parse PDF
    stats = parse_pdf_stats(pdf_path)
    if not stats:
        print("\n[ERROR] Failed to parse PDF")
        return
    
    # Save parsed stats to JSON for review
    output_dir = 'scraper/fixtures/output'
    os.makedirs(output_dir, exist_ok=True)
    stats_file = os.path.join(output_dir, 'test_parsed_stats.json')
    with open(stats_file, 'w', encoding='utf-8') as f:
        json.dump(stats, f, indent=2)
    print(f"   [SAVE] Saved parsed stats to: {stats_file}")
    
    # Step 4: Generate SQL
    print(f"\n   Generating SQL...")
    fixture_data = {
        'fixture_id': 1,  # TODO: Get actual fixture ID from database/command line
        'home_team': stats['home_team'],
        'away_team': stats['away_team'],
        'home_players': stats['home_players'],
        'away_players': stats['away_players']
    }
    sql = generate_sql(fixture_data)
    
    # Save SQL file
    sql_file = os.path.join(output_dir, 'test_player_stats.sql')
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write(sql)
    print(f"   [SAVE] Saved SQL to: {sql_file}")
    
    print("\n" + "=" * 70)
    print("[OK] TEST COMPLETE!")
    print("=" * 70)
    print(f"\nParsed stats:")
    print(f"  Home Team: {stats['home_team']} ({len(stats['home_players'])} players)")
    print(f"  Away Team: {stats['away_team']} ({len(stats['away_players'])} players)")
    print(f"\n  Sample home players:")
    for player in stats['home_players'][:3]:
        print(f"    - {player['name']} ({player['pos']}) - {player['minutes']}min, {player['goals']}G, {player['assists']}A")
    print(f"\nGenerated:")
    print(f"  JSON: {stats_file}")
    print(f"  SQL:  {sql_file}")

if __name__ == "__main__":
    # Single fixture test mode
    # main()
    
    # Batch mode - Process ALL fixtures with box scores
    process_all_fixtures_from_json()

