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

def parse_html_box_score(box_score_url, fixture_home_team=None, fixture_away_team=None):
    """
    Fallback parser for when PDF is not available.
    Parses player stats directly from HTML tables.
    
    Args:
        box_score_url: URL to the box score page
        fixture_home_team: Home team name from fixtures.json (for verification/override)
        fixture_away_team: Away team name from fixtures.json (for verification/override)
    
    Returns:
        stats dict (same format as parse_pdf_stats) or None
    """
    print(f"   [HTML] Fetching box score HTML page...")
    
    # Step 1: Fetch the HTML page
    try:
        response = requests.get(box_score_url, headers=HEADERS, timeout=30)
        response.raise_for_status()
        print(f"   [HTML] Successfully fetched HTML ({len(response.content)} bytes)")
    except requests.exceptions.RequestException as e:
        print(f"   [HTML ERROR] Failed to fetch HTML: {e}")
        return None
    
    # Step 2: Parse HTML with BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Step 3: Identify home and away teams from HTML structure
    # Look for divs with class containing "team away" and "team home"
    # Note: BeautifulSoup's class_ parameter matches if any class matches
    away_team_div = soup.find('div', class_=lambda x: x and 'team' in x and 'away' in x)
    home_team_div = soup.find('div', class_=lambda x: x and 'team' in x and 'home' in x)
    
    html_home_team = None
    html_away_team = None
    
    if home_team_div:
        img = home_team_div.find('img', class_='MainLogo')
        if img and img.get('alt'):
            html_home_team = img.get('alt').strip()
            print(f"   [HTML] Found home team from HTML: {html_home_team}")
    
    if away_team_div:
        img = away_team_div.find('img', class_='MainLogo')
        if img and img.get('alt'):
            html_away_team = img.get('alt').strip()
            print(f"   [HTML] Found away team from HTML: {html_away_team}")
    
    # Step 4: Use fixture data as source of truth, but verify against HTML
    # Fixture data is reliable (from fixtures.json), HTML is usually correct too
    home_team = fixture_home_team if fixture_home_team else html_home_team
    away_team = fixture_away_team if fixture_away_team else html_away_team
    
    # Verify if both available
    if fixture_home_team and html_home_team and html_home_team != fixture_home_team:
        print(f"   [HTML WARNING] HTML home team '{html_home_team}' differs from fixture '{fixture_home_team}', using fixture")
    if fixture_away_team and html_away_team and html_away_team != fixture_away_team:
        print(f"   [HTML WARNING] HTML away team '{html_away_team}' differs from fixture '{fixture_away_team}', using fixture")
    
    if not home_team or not away_team:
        print(f"   [HTML ERROR] Could not identify teams (HTML: {html_home_team}/{html_away_team}, Fixture: {fixture_home_team}/{fixture_away_team})")
        return None
    
    # Initialize stats structure (same format as parse_pdf_stats)
    stats = {
        'home_team': home_team,
        'away_team': away_team,
        'home_players': [],
        'away_players': [],
        'home_gk': None,
        'away_gk': None
    }
    
    print(f"   [HTML] Teams identified: {away_team} (away) vs {home_team} (home)")
    
    # Step 4: Find and parse player stats tables
    # Look for tables with captions containing "Player Stats"
    all_tables = soup.find_all('table', class_='sidearm-table')
    print(f"   [HTML] Found {len(all_tables)} tables with sidearm-table class")
    
    # Find player stats tables by caption
    player_stats_tables = []
    for table in all_tables:
        caption = table.find('caption')
        if caption and 'Player Stats' in caption.get_text():
            caption_text = caption.get_text().strip()
            print(f"   [HTML] Found player stats table: {caption_text}")
            player_stats_tables.append((table, caption_text))
    
    if not player_stats_tables:
        print(f"   [HTML ERROR] Could not find player stats tables")
        return None
    
    # Step 5: Match tables to teams and parse both
    # Tables have captions like "GRE - Player Stats" or "BLA - Player Stats"
    # We need to match the abbreviation to the team name
    print(f"   [HTML] Matching tables to teams...")
    
    # Try to find team abbreviations from the HTML
    # Look for team abbreviations in scoring summary or other tables
    team_abbrevs = {}
    
    # Check scoring summary table for team abbreviations
    scoring_table = soup.find('table', class_='sidearm-table')
    if scoring_table:
        # Look for team abbreviations (GRE, BLA, etc.) in the table
        for row in scoring_table.find_all('tr'):
            team_cell = row.find('td', class_='text-center')
            if team_cell:
                abbrev = team_cell.get_text(strip=True)
                if len(abbrev) == 3:  # Typical abbreviation length
                    # Try to match to team names
                    if away_team and away_team[:3].upper() == abbrev[:3]:
                        team_abbrevs[abbrev] = away_team
                    elif home_team and home_team[:3].upper() == abbrev[:3]:
                        team_abbrevs[abbrev] = home_team
    
    # Match each player stats table to a team
    away_table = None
    home_table = None
    
    for table, caption_text in player_stats_tables:
        # Extract abbreviation from caption (e.g., "GRE - Player Stats" -> "GRE")
        abbrev_match = re.search(r'^([A-Z]+)\s*-\s*Player Stats', caption_text)
        if abbrev_match:
            abbrev = abbrev_match.group(1)
            print(f"   [HTML] Found table with abbreviation: {abbrev}")
            
            # Try to match to team names
            # Check if abbreviation matches team name start
            if away_team and (abbrev in away_team.upper()[:4] or away_team.upper()[:3] == abbrev[:3]):
                away_table = (table, away_team)
                print(f"   [HTML] Matched {abbrev} to away team: {away_team}")
            elif home_team and (abbrev in home_team.upper()[:4] or home_team.upper()[:3] == abbrev[:3]):
                home_table = (table, home_team)
                print(f"   [HTML] Matched {abbrev} to home team: {home_team}")
    
    # Fallback: If we couldn't match, use order (first = away, second = home)
    if not away_table and len(player_stats_tables) >= 1:
        away_table = (player_stats_tables[0][0], away_team)
        print(f"   [HTML] Using fallback: First table = away team")
    if not home_table and len(player_stats_tables) >= 2:
        home_table = (player_stats_tables[1][0], home_team)
        print(f"   [HTML] Using fallback: Second table = home team")
    
    # Parse away team table
    if away_table:
        print(f"   [HTML] Parsing away team player stats table...")
        away_players = parse_player_stats_table(away_table[0], away_table[1])
        stats['away_players'] = away_players
        print(f"   [HTML] Parsed {len(away_players)} away team players")
    else:
        print(f"   [HTML WARNING] Could not find away team table")
    
    # Parse home team table
    if home_table:
        print(f"   [HTML] Parsing home team player stats table...")
        home_players = parse_player_stats_table(home_table[0], home_table[1])
        stats['home_players'] = home_players
        print(f"   [HTML] Parsed {len(home_players)} home team players")
    else:
        print(f"   [HTML WARNING] Could not find home team table")
    
    # Step 6: Find and parse goalkeeper stats tables
    print(f"   [HTML] Finding goalkeeper stats tables...")
    gk_stats_tables = []
    for table in all_tables:
        caption = table.find('caption')
        if caption:
            caption_text = caption.get_text().strip()
            if 'Goalie Statistics' in caption_text or 'Goalkeeper Statistics' in caption_text:
                print(f"   [HTML] Found goalkeeper stats table: {caption_text}")
                gk_stats_tables.append((table, caption_text))
    
    # Match goalkeeper tables to teams and parse
    if gk_stats_tables:
        for table, caption_text in gk_stats_tables:
            # Extract team name from caption (e.g., "Greenville - Goalie Statistics")
            # Or match by abbreviation like we did for player stats
            team_for_table = None
            
            # Try to match by team name in caption
            if away_team and away_team in caption_text:
                team_for_table = away_team
                print(f"   [HTML] Matched GK table to away team: {away_team}")
            elif home_team and home_team in caption_text:
                team_for_table = home_team
                print(f"   [HTML] Matched GK table to home team: {home_team}")
            
            if team_for_table:
                # Parse goalkeeper stats
                gk_stats = parse_goalkeeper_stats_table(table, team_for_table)
                
                # Update player records with goalkeeper stats
                if team_for_table == away_team:
                    update_players_with_gk_stats(stats['away_players'], gk_stats)
                    print(f"   [HTML] Updated {len(gk_stats)} away team goalkeepers")
                elif team_for_table == home_team:
                    update_players_with_gk_stats(stats['home_players'], gk_stats)
                    print(f"   [HTML] Updated {len(gk_stats)} home team goalkeepers")
    
    # Step 7: Find and parse cards (Cautions and Ejections table)
    print(f"   [HTML] Finding cards table...")
    cards_table = None
    for table in all_tables:
        caption = table.find('caption')
        if caption:
            caption_text = caption.get_text().strip()
            if 'Cautions and Ejections' in caption_text or 'Cautions' in caption_text:
                print(f"   [HTML] Found cards table: {caption_text}")
                cards_table = table
                break
    
    if cards_table:
        # Parse cards and update player records
        cards_data = parse_cards_table(cards_table, away_team, home_team)
        print(f"   [HTML] Found {len(cards_data)} card entries")
        
        # Update player records with cards
        update_players_with_cards(stats['away_players'], cards_data, away_team)
        update_players_with_cards(stats['home_players'], cards_data, home_team)
        
        # Count cards by type for logging
        yellow_count = sum(1 for c in cards_data if c['type'] == 'yellow')
        red_count = sum(1 for c in cards_data if c['type'] == 'red')
        print(f"   [HTML] Updated cards: {yellow_count} yellow, {red_count} red")
    else:
        print(f"   [HTML WARNING] Could not find cards table")
    
    # Step 8: Calculate clean sheets (same logic as PDF parser)
    print(f"   [HTML] Calculating clean sheets...")
    home_gks = [p for p in stats['home_players'] if p['pos'] == 'GK']
    away_gks = [p for p in stats['away_players'] if p['pos'] == 'GK']
    
    # Total goals conceded by each team
    home_goals_conceded = sum(gk.get('goals_against', 0) for gk in home_gks)
    away_goals_conceded = sum(gk.get('goals_against', 0) for gk in away_gks)
    
    # Assign clean sheets to GKs and Defenders (must play at least 60 minutes)
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
    
    print(f"   [HTML] Clean sheets: Home={1 if home_goals_conceded == 0 else 0}, Away={1 if away_goals_conceded == 0 else 0}")
    
    return stats

def parse_player_stats_table(table, team_name):
    """
    Parse a player stats table and extract player data.
    
    Args:
        table: BeautifulSoup table element
        team_name: Name of the team (for logging)
    
    Returns:
        List of player dicts with stats
    """
    players = []
    
    # Find all rows in tbody (skip header rows)
    tbody = table.find('tbody')
    if not tbody:
        print(f"   [HTML ERROR] No tbody found in table")
        return players
    
    rows = tbody.find_all('tr')
    
    for row in rows:
        # Skip header-group rows (like "Starters", "Substitutes", "Totals")
        header_group = row.find('th', class_='header-group')
        if header_group:
            continue
        
        # Extract player data from row
        # Structure: <td>Pos</td> <td>#</td> <th>Player Name</th> <td>SH</td> <td>SOG</td> <td>G</td> <td>A</td>
        cells = row.find_all(['td', 'th'])
        if len(cells) < 7:
            continue  # Skip rows that don't have enough cells
        
        try:
            # Position (first td, might be empty for some players)
            pos_cell = cells[0]
            pos = pos_cell.get_text(strip=True).upper() if pos_cell.name == 'td' else ''
            if pos:
                # Normalize position codes
                pos_map = {'DEF': 'DEF', 'MID': 'MID', 'FWD': 'FWD', 'GK': 'GK'}
                pos = pos_map.get(pos, pos)
            
            # Jersey number (second td)
            jersey_cell = cells[1]
            jersey_text = jersey_cell.get_text(strip=True)
            # Skip "TM" (Team) entries
            if jersey_text == 'TM' or not jersey_text.isdigit():
                continue
            jersey = int(jersey_text)
            
            # Player name (third cell, th element)
            name_cell = cells[2]
            # Get text but exclude spans with jersey numbers
            # The structure is: <th><span class="mobile-jersey-number">3 </span>Ziesecke, Carlos</th>
            name_parts = []
            for element in name_cell.children:
                if hasattr(element, 'get_text'):
                    text = element.get_text(strip=True)
                    # Skip spans that contain only numbers (jersey numbers)
                    if text and not (text.isdigit() or text.strip() == ''):
                        name_parts.append(text)
            name = ' '.join(name_parts).strip()
            
            # If we couldn't extract properly, fall back to get_text
            if not name:
                name = name_cell.get_text(strip=True)
                # Remove jersey number if it appears at the start
                name = re.sub(r'^\d+\s+', '', name)
            
            # Clean name (convert "Last, First" to "First Last")
            name = clean_player_name(name)
            
            # Stats: SH, SOG, G, A (cells 3-6)
            shots = int(cells[3].get_text(strip=True) or 0)
            sog = int(cells[4].get_text(strip=True) or 0)
            goals = int(cells[5].get_text(strip=True) or 0)
            assists = int(cells[6].get_text(strip=True) or 0)
            
            # Create player dict (same format as PDF parser)
            player = {
                'name': name,
                'pos': pos if pos else 'UNK',  # Default to UNK if position not found
                'jersey': jersey,
                'minutes': 0,  # Not available in player stats table
                'goals': goals,
                'assists': assists,
                'shots': shots,
                'sog': sog,
                'saves': 0,  # Will be updated from GK table if applicable
                'goals_against': 0,  # Will be updated from GK table if applicable
                'clean_sheet': 0,  # Will be calculated later
                'yellow_cards': 0,  # Will be extracted from cards table
                'red_cards': 0  # Will be extracted from cards table
            }
            
            players.append(player)
            
        except (ValueError, IndexError) as e:
            # Skip rows that can't be parsed
            continue
    
    return players

def parse_goalkeeper_stats_table(table, team_name):
    """
    Parse a goalkeeper stats table and extract goalkeeper data.
    
    Args:
        table: BeautifulSoup table element
        team_name: Name of the team (for logging)
    
    Returns:
        List of goalkeeper dicts with stats: {jersey, name, minutes, goals_against, saves}
    """
    goalkeepers = []
    
    # Find all rows in tbody
    tbody = table.find('tbody')
    if not tbody:
        print(f"   [HTML ERROR] No tbody found in goalkeeper table")
        return goalkeepers
    
    rows = tbody.find_all('tr')
    
    for row in rows:
        # Skip header-group rows
        header_group = row.find('th', class_='header-group')
        if header_group:
            continue
        
        # Extract goalkeeper data from row
        # Structure: <td>GK</td> <td>#</td> <th>Goalie Name</th> <td>Minutes</td> <td>GA</td> <td>Saves</td>
        cells = row.find_all(['td', 'th'])
        if len(cells) < 6:
            continue  # Skip rows that don't have enough cells
        
        try:
            # Position (first td, should be GK)
            pos_cell = cells[0]
            pos = pos_cell.get_text(strip=True).upper() if pos_cell.name == 'td' else ''
            if pos != 'GK':
                continue  # Skip non-GK rows
            
            # Jersey number (second td)
            jersey_cell = cells[1]
            jersey_text = jersey_cell.get_text(strip=True)
            if not jersey_text.isdigit():
                continue
            jersey = int(jersey_text)
            
            # Goalkeeper name (third cell, th element)
            name_cell = cells[2]
            # Get text but exclude spans with extra info (like "- 7S")
            name_parts = []
            for element in name_cell.children:
                if hasattr(element, 'get_text'):
                    text = element.get_text(strip=True)
                    # Skip spans that contain stats info (like "- 7S")
                    if text and not text.startswith('-') and not text.isdigit():
                        name_parts.append(text)
            name = ' '.join(name_parts).strip()
            
            # If we couldn't extract properly, fall back to get_text
            if not name:
                name = name_cell.get_text(strip=True)
                # Remove stats info like "- 7S"
                name = re.sub(r'\s*-\s*\d+S\s*', '', name)
                # Remove jersey number if it appears at the start
                name = re.sub(r'^\d+\s+', '', name)
            
            # Clean name (convert "Last, First" to "First Last")
            name = clean_player_name(name)
            
            # Stats: Minutes, GA, Saves (cells 3-5)
            minutes_str = cells[3].get_text(strip=True)  # Format: "90:00"
            goals_against = int(cells[4].get_text(strip=True) or 0)
            saves = int(cells[5].get_text(strip=True) or 0)
            
            # Convert minutes from "90:00" format to integer
            minutes = 0
            if ':' in minutes_str:
                try:
                    mins, secs = minutes_str.split(':')
                    minutes = int(mins)  # Just use the minute part
                except ValueError:
                    minutes = 0
            else:
                try:
                    minutes = int(minutes_str)
                except ValueError:
                    minutes = 0
            
            # Create goalkeeper dict
            gk = {
                'jersey': jersey,
                'name': name,
                'minutes': minutes,
                'goals_against': goals_against,
                'saves': saves
            }
            
            goalkeepers.append(gk)
            
        except (ValueError, IndexError) as e:
            # Skip rows that can't be parsed
            continue
    
    return goalkeepers

def update_players_with_gk_stats(players, gk_stats):
    """
    Update player records with goalkeeper stats.
    Matches goalkeepers by jersey number and updates their stats.
    
    Args:
        players: List of player dicts
        gk_stats: List of goalkeeper stat dicts
    """
    # Create a lookup by jersey number
    gk_lookup = {gk['jersey']: gk for gk in gk_stats}
    
    for player in players:
        # If player is a goalkeeper and we have stats for them
        if player['jersey'] in gk_lookup:
            gk = gk_lookup[player['jersey']]
            # Update player stats with goalkeeper data
            player['minutes'] = gk['minutes']
            player['saves'] = gk['saves']
            player['goals_against'] = gk['goals_against']
            # Update position to GK if not already set
            if player['pos'] == 'UNK' or not player['pos']:
                player['pos'] = 'GK'

def parse_cards_table(table, away_team, home_team):
    """
    Parse the Cautions and Ejections table to extract card information.
    
    Args:
        table: BeautifulSoup table element
        away_team: Name of away team
        home_team: Name of home team
    
    Returns:
        List of card dicts: {jersey, team, type: 'yellow'|'red'}
    """
    cards = []
    
    # Find all rows in tbody
    tbody = table.find('tbody')
    if not tbody:
        print(f"   [HTML ERROR] No tbody found in cards table")
        return cards
    
    rows = tbody.find_all('tr')
    
    for row in rows:
        cells = row.find_all(['td', 'th'])
        if len(cells) < 4:
            continue  # Skip rows that don't have enough cells
        
        try:
            # First cell: Card type (class="penalty-type yellow" or "penalty-type red")
            card_type_cell = cells[0]
            card_type = None
            
            # Check the class attribute of the cell itself
            cell_classes = card_type_cell.get('class', [])
            cell_class_str = ' '.join(cell_classes) if isinstance(cell_classes, list) else str(cell_classes)
            
            # Check for yellow card
            if 'yellow' in cell_class_str.lower():
                card_type = 'yellow'
            # Check for red card
            elif 'red' in cell_class_str.lower():
                card_type = 'red'
            
            if not card_type:
                continue  # Skip rows without a card type
            
            # Second cell: Time (not needed for stats)
            # Third cell: Team abbreviation (GRE, BLA, etc.)
            team_abbrev = cells[2].get_text(strip=True)
            
            # Determine which team this card belongs to
            team = None
            if away_team and (team_abbrev in away_team.upper()[:4] or away_team.upper()[:3] == team_abbrev[:3]):
                team = away_team
            elif home_team and (team_abbrev in home_team.upper()[:4] or home_team.upper()[:3] == team_abbrev[:3]):
                team = home_team
            
            if not team:
                # Try to match by checking if abbreviation appears in team name
                if away_team and team_abbrev in away_team.upper():
                    team = away_team
                elif home_team and team_abbrev in home_team.upper():
                    team = home_team
            
            # Fourth cell: Player info in format "#N PlayerName"
            player_cell = cells[3].get_text(strip=True)
            
            # Extract jersey number from "#N PlayerName" format
            jersey_match = re.search(r'#(\d+)', player_cell)
            if jersey_match:
                jersey = int(jersey_match.group(1))
                
                card = {
                    'jersey': jersey,
                    'team': team,
                    'type': card_type
                }
                cards.append(card)
            
        except (ValueError, IndexError, AttributeError) as e:
            # Skip rows that can't be parsed
            continue
    
    return cards

def update_players_with_cards(players, cards_data, team_name):
    """
    Update player records with card information.
    Matches cards to players by jersey number and team.
    
    Args:
        players: List of player dicts
        cards_data: List of card dicts
        team_name: Name of the team these players belong to
    """
    # Filter cards for this team
    team_cards = [c for c in cards_data if c['team'] == team_name]
    
    # Count cards by jersey number
    card_counts = {}  # {jersey: {'yellow': count, 'red': count}}
    
    for card in team_cards:
        jersey = card['jersey']
        if jersey not in card_counts:
            card_counts[jersey] = {'yellow': 0, 'red': 0}
        
        if card['type'] == 'yellow':
            card_counts[jersey]['yellow'] += 1
        elif card['type'] == 'red':
            card_counts[jersey]['red'] += 1
    
    # Update player records
    for player in players:
        jersey = player['jersey']
        if jersey in card_counts:
            player['yellow_cards'] = card_counts[jersey]['yellow']
            player['red_cards'] = card_counts[jersey]['red']

def parse_player_stats_hybrid(box_score_url, pdf_path=None, fixture_home_team=None, fixture_away_team=None):
    """
    Parse player stats using HTML as primary source, PDF for minutes only.
    
    This is the hybrid approach that:
    1. Always parses HTML first (more reliable structure, correct team names)
    2. If PDF exists, extracts ONLY minutes from PDF and merges with HTML data
    3. Uses fixture data as source of truth for team names
    
    Args:
        box_score_url: URL to box score page
        pdf_path: Optional path to PDF file (if available)
        fixture_home_team: Home team from fixtures.json (source of truth)
        fixture_away_team: Away team from fixtures.json (source of truth)
    
    Returns:
        stats dict with complete player data (same format as parse_pdf_stats)
    """
    print(f"   [HYBRID] Starting hybrid parsing (HTML + PDF minutes)...")
    
    # Step 1: Parse HTML to get all player data
    # HTML has: team names, player names, jersey, position, goals, assists, shots, SOG, cards
    # HTML is missing: minutes for field players (only has minutes for GKs)
    html_stats = parse_html_box_score(box_score_url, fixture_home_team, fixture_away_team)
    
    if not html_stats:
        print(f"   [HYBRID ERROR] HTML parsing failed")
        return None
    
    print(f"   [HYBRID] HTML parsing successful: {len(html_stats['home_players'])} home + {len(html_stats['away_players'])} away players")
    
    # Step 2: If PDF exists, extract minutes for field players
    if pdf_path and os.path.exists(pdf_path):
        print(f"   [HYBRID] PDF found, extracting minutes for field players...")
        # Extract minutes from PDF
        pdf_minutes = extract_minutes_from_pdf(pdf_path, html_stats, fixture_home_team, fixture_away_team)
        
        # Merge minutes into HTML stats
        if pdf_minutes:
            merge_minutes_into_stats(html_stats, pdf_minutes)
        else:
            print(f"   [HYBRID WARNING] PDF minutes extraction failed, using HTML-only data")
    else:
        print(f"   [HYBRID] No PDF available, using HTML-only data (field players will have 0 minutes)")
    
    return html_stats

def extract_minutes_from_pdf(pdf_path, html_stats, fixture_home_team=None, fixture_away_team=None):
    """
    Extract only minutes played from PDF, matching players to HTML stats.
    
    This function parses the PDF to extract minutes for field players (HTML already has GK minutes).
    It matches players by jersey number and name to the HTML stats.
    
    Args:
        pdf_path: Path to PDF file
        html_stats: Stats dict from HTML parser (used for matching players)
        fixture_home_team: Home team name from fixtures.json (for team matching)
        fixture_away_team: Away team name from fixtures.json (for team matching)
    
    Returns:
        dict: {team_name: {jersey: minutes, ...}, ...}
        Example: {'MUW': {10: 90, 11: 45, ...}, 'Principia': {5: 90, ...}}
    """
    print(f"   [EXTRACT MINUTES] Extracting minutes from PDF...")
    
    # Use fixture data as source of truth for team names
    home_team = fixture_home_team if fixture_home_team else html_stats.get('home_team')
    away_team = fixture_away_team if fixture_away_team else html_stats.get('away_team')
    
    if not home_team or not away_team:
        print(f"   [EXTRACT MINUTES ERROR] Could not determine teams")
        return {}
    
    # Result structure: {team_name: {jersey: minutes, ...}, ...}
    pdf_minutes = {
        home_team: {},
        away_team: {}
    }
    
    try:
        with pdfplumber.open(pdf_path) as pdf:
            # Extract text from first page
            page = pdf.pages[0]
            text = page.extract_text()
            
            if not text:
                print(f"   [EXTRACT MINUTES ERROR] No text found in PDF")
                return {}
            
            lines = text.split('\n')
            
            # Find player stats sections
            # Looking for lines like: "Pos # Player SH SOG G A MIN"
            in_home_players = False
            in_away_players = False
            current_team = None  # Will be set based on which section we're in
            
            for i, line in enumerate(lines):
                line = line.strip()
                
                # Detect player stats header
                if 'Pos # Player' in line and 'SH SOG G A MIN' in line:
                    # Next section will be player stats
                    # Determine if it's home or away based on context
                    if not in_home_players:
                        in_home_players = True
                        in_away_players = False
                        # First section is away team (based on PDF layout)
                        current_team = away_team
                    else:
                        in_home_players = False
                        in_away_players = True
                        # Second section is home team
                        current_team = home_team
                    continue
                
                # Skip goalkeeper section (HTML already has GK minutes)
                if '# Goalkeepers Minutes GA Saves' in line:
                    in_home_players = False
                    in_away_players = False
                    current_team = None
                    continue
                
                # Parse player stats to extract minutes
                if in_home_players or in_away_players:
                    # Skip header lines
                    if line in ['Starters', 'Substitutes', 'Totals'] or not line:
                        continue
                    
                    # PDF has two columns side-by-side. Need to split the line
                    parts = line.split()
                    if len(parts) < 7:
                        continue
                    
                    # Find the midpoint - look for duplicate position codes
                    pos_indices = [i for i, p in enumerate(parts) if p in ['GK', 'DEF', 'MID', 'FWD']]
                    
                    midpoint = None
                    if len(pos_indices) >= 2:
                        # We have at least 2 position codes, likely two columns
                        for idx in pos_indices[1:]:
                            try:
                                if idx + 6 < len(parts):
                                    int(parts[idx + 1])
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
                        # Left column is away, right column is home
                        lines_to_parse = [(left_half, away_team), (right_half, home_team)]
                    else:
                        # Single column, use current team
                        lines_to_parse = [(line, current_team)] if current_team else []
                    
                    for player_line, team_for_player in lines_to_parse:
                        parts = player_line.split()
                        if len(parts) < 7:
                            continue
                        
                        try:
                            pos = parts[0]
                            if pos not in ['GK', 'DEF', 'MID', 'FWD']:
                                continue
                            
                            jersey_num = int(parts[1])
                            
                            # Last part is MIN (minutes)
                            mins = int(parts[-1])
                            
                            # Store minutes for this team and jersey
                            if team_for_player and team_for_player in pdf_minutes:
                                pdf_minutes[team_for_player][jersey_num] = mins
                                print(f"   [EXTRACT MINUTES] Found {team_for_player} #{jersey_num}: {mins} min")
                        
                        except (ValueError, IndexError) as e:
                            continue
            
            # Summary
            home_count = len(pdf_minutes[home_team])
            away_count = len(pdf_minutes[away_team])
            print(f"   [EXTRACT MINUTES] Extracted minutes: {home_team} ({home_count} players), {away_team} ({away_count} players)")
            
    except Exception as e:
        print(f"   [EXTRACT MINUTES ERROR] Error parsing PDF: {e}")
        import traceback
        traceback.print_exc()
        return {}
    
    return pdf_minutes

def merge_minutes_into_stats(html_stats, pdf_minutes):
    """
    Merge PDF minutes into HTML stats.
    
    This function takes minutes extracted from PDF and adds them to HTML stats.
    It matches players by jersey number and team name.
    
    Args:
        html_stats: Stats dict from HTML parser (will be modified in-place)
        pdf_minutes: Dict from extract_minutes_from_pdf(): {team_name: {jersey: minutes, ...}, ...}
    
    Returns:
        None (modifies html_stats in-place)
    """
    print(f"   [MERGE MINUTES] Merging PDF minutes into HTML stats...")
    
    if not pdf_minutes:
        print(f"   [MERGE MINUTES] No PDF minutes to merge")
        return
    
    # Process both home and away players
    for team_type in ['home_players', 'away_players']:
        team_name = html_stats['home_team'] if team_type == 'home_players' else html_stats['away_team']
        team_minutes = pdf_minutes.get(team_name, {})
        
        if not team_minutes:
            print(f"   [MERGE MINUTES] No minutes found for {team_name}")
            continue
        
        updated_count = 0
        for player in html_stats[team_type]:
            jersey = player['jersey']
            
            # Only update minutes for field players (HTML already has GK minutes)
            # Skip if player is a goalkeeper (they already have minutes from HTML)
            if player['pos'] == 'GK':
                continue
            
            # Update minutes if found in PDF
            if jersey in team_minutes:
                old_minutes = player['minutes']
                new_minutes = team_minutes[jersey]
                player['minutes'] = new_minutes
                updated_count += 1
                if old_minutes != new_minutes:
                    print(f"   [MERGE MINUTES] Updated {team_name} #{jersey} ({player['name']}): {old_minutes} -> {new_minutes} min")
        
        print(f"   [MERGE MINUTES] Updated {updated_count} {team_name} field players with PDF minutes")
    
    # Summary
    total_updated = sum(
        len([p for p in html_stats[team_type] if p['pos'] != 'GK' and p['minutes'] > 0])
        for team_type in ['home_players', 'away_players']
    )
    print(f"   [MERGE MINUTES] Complete! Total field players with minutes: {total_updated}")

def parse_pdf_stats(pdf_path, fixture_home_team=None, fixture_away_team=None):
    """
    Extract player stats from PDF using text parsing.
    Uses fixture data as source of truth for team names (PDF may have wrong names like "The W").
    
    Args:
        pdf_path: Path to PDF file
        fixture_home_team: Home team name from fixtures.json (source of truth)
        fixture_away_team: Away team name from fixtures.json (source of truth)
    
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
    
    # Use fixture data as source of truth for team names
    stats = {
        'home_team': fixture_home_team,  # Use fixture data, not PDF
        'away_team': fixture_away_team,  # Use fixture data, not PDF
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
            
            # Extract team names from PDF header for logging/warning (but don't use them)
            # Format: "Principia (3-3-1, 1-0-0) -vs- The W (3-6-0, 0-1-0)"
            header = lines[0]
            pdf_home_team = None
            pdf_away_team = None
            match = re.search(r'(.+?)\s+\([^)]+\)\s+-vs-\s+(.+?)\s+\([^)]+\)', header)
            if match:
                pdf_home_team = match.group(1).strip()
                pdf_away_team = match.group(2).strip()
                print(f"   [PDF] PDF header shows: {pdf_home_team} vs {pdf_away_team}")
            
            # Use fixture data as source of truth (PDF may have wrong names like "The W")
            if fixture_home_team:
                stats['home_team'] = fixture_home_team
            elif pdf_home_team:
                stats['home_team'] = pdf_home_team  # Fallback to PDF if no fixture data
            
            if fixture_away_team:
                stats['away_team'] = fixture_away_team
            elif pdf_away_team:
                stats['away_team'] = pdf_away_team  # Fallback to PDF if no fixture data
            
            # Warn if PDF team names differ from fixture data
            if fixture_home_team and pdf_home_team and pdf_home_team != fixture_home_team:
                print(f"   [WARNING] PDF home team '{pdf_home_team}' differs from fixture '{fixture_home_team}', using fixture")
            if fixture_away_team and pdf_away_team and pdf_away_team != fixture_away_team:
                print(f"   [WARNING] PDF away team '{pdf_away_team}' differs from fixture '{fixture_away_team}', using fixture")
            
            if not stats['home_team'] or not stats['away_team']:
                print(f"   [ERROR] Could not determine teams (PDF: {pdf_home_team}/{pdf_away_team}, Fixture: {fixture_home_team}/{fixture_away_team})")
                return None
            
            print(f"   [OK] Using teams: {stats['home_team']} vs {stats['away_team']}")
            
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
    sql.append("DECLARE @PlayerId INT;  -- Declare once, reuse for all players")
    sql.append("")
    sql.append(f"-- Get team IDs")
    sql.append(f"SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = '{fixture_data['home_team']}';")
    sql.append(f"SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = '{fixture_data['away_team']}';")
    sql.append("")
    sql.append(f"-- Find fixture (checking both home/away combinations)")
    sql.append(f"SELECT TOP 1 @FixtureId = f.Id")
    sql.append(f"FROM fixtures f")
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
        
        # Get raw values first for diagnostic logging
        minutes_raw = player['minutes']
        goals_raw = player['goals']
        assists_raw = player['assists']
        saves_raw = player.get('saves', 0)
        goals_conceded_raw = player.get('goals_against', 0)
        yellow_cards_raw = player.get('yellow_cards', 0)
        red_cards_raw = player.get('red_cards', 0)
        
        # Diagnostic: Log warnings for values exceeding TINYINT max (255)
        # This helps identify which field is causing arithmetic overflow
        if minutes_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - MinutesPlayed={minutes_raw} (exceeds TINYINT max 255)")
            minutes_raw = 90
        if goals_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - Goals={goals_raw} (exceeds TINYINT max 255)")
        if assists_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - Assists={assists_raw} (exceeds TINYINT max 255)")
        if saves_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - Saves={saves_raw} (exceeds TINYINT max 255)")
        if goals_conceded_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - GoalsConceded={goals_conceded_raw} (exceeds TINYINT max 255)")
        if yellow_cards_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - YellowCards={yellow_cards_raw} (exceeds TINYINT max 255)")
        if red_cards_raw > 255:
            print(f"   [OVERFLOW WARNING] {player['name']} ({team}) - RedCards={red_cards_raw} (exceeds TINYINT max 255)")
        
        # Cap values at 255 to prevent arithmetic overflow (TINYINT max value)
        minutes = min(minutes_raw, 255) 
        goals = min(goals_raw, 255)
        assists = min(assists_raw, 255)
        saves = min(saves_raw, 255)
        goals_conceded = min(goals_conceded_raw, 255)
        yellow_cards = min(yellow_cards_raw, 255)
        red_cards = min(red_cards_raw, 255)
        clean_sheet = 1 if player.get('clean_sheet', 0) else 0
        
        # Skip players with 0 minutes (not used)
        if minutes == 0:
            continue
        
        sql.append(f"""-- {name} ({player['pos']}) - {team}
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = '{team}'
  AND p.playerNum = {jersey}
  AND (
    p.name LIKE '%{name.split()[0]}%'  -- Match first name
    OR p.name LIKE '%{name.split()[-1]}%'  -- Match last name
    OR p.name = '{name}'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
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
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, {minutes}, {goals}, {assists}, {yellow_cards}, {red_cards}, {clean_sheet}, {goals_conceded}, 0, {saves});
        PRINT '[OK] Inserted stats for {name}';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: {name} (Jersey #{jersey}, Team: {team})';
END

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
    script_dir = os.path.dirname(os.path.abspath(__file__))
    fixtures_file = os.path.join(script_dir, 'output/fixtures.json')
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
            
            # Use hybrid approach: HTML as primary source, PDF for minutes only
            print(f"   [INFO] Using hybrid approach (HTML + PDF minutes)...")
            
            # Step 1: Try to get PDF URL (for minutes extraction)
            pdf_url = get_pdf_url_from_boxscore(box_score_url)
            pdf_path = None
            method_used = 'hybrid_html_only'  # Default: HTML only
            
            if pdf_url:
                # PDF found - download it for minutes extraction
                print(f"   [INFO] PDF found, will extract minutes from PDF")
                pdf_dir = os.path.join(output_dir, 'pdfs')
                os.makedirs(pdf_dir, exist_ok=True)
                pdf_path = os.path.join(pdf_dir, f'fixture_{fixture_id}.pdf')
                
                if download_pdf(pdf_url, pdf_path):
                    method_used = 'hybrid_html_pdf'  # HTML + PDF minutes
                    print(f"   [INFO] PDF downloaded, will merge minutes into HTML stats")
                else:
                    print(f"   [WARNING] PDF download failed, using HTML-only (field players will have 0 minutes)")
                    pdf_path = None  # PDF download failed, continue with HTML only
            else:
                print(f"   [INFO] No PDF available, using HTML-only (field players will have 0 minutes)")
            
            # Step 2: Use hybrid approach (always parses HTML, merges PDF minutes if available)
            stats = parse_player_stats_hybrid(
                box_score_url,
                pdf_path=pdf_path,
                fixture_home_team=fixture['home'],
                fixture_away_team=fixture['away']
            )
            
            if not stats:
                error_reason = "Hybrid parsing failed (HTML parsing failed)"
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
            
            # Display method used
            if method_used == 'hybrid_html_pdf':
                method_display = 'Hybrid (HTML + PDF minutes)'
            else:
                method_display = 'Hybrid (HTML only)'
            print(f"   [OK] Parsed {len(stats['home_players'])} home + {len(stats['away_players'])} away players (method: {method_display})")
            successful += 1
            
            # Log success with method used
            processing_log[str(fixture_id)] = {
                'status': 'success',
                'method': method_used,  # Track which method was used
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
            # Add GO statements between fixtures to separate batches (prevents variable declaration conflicts)
            f.write('\n\nGO\n\n'.join(all_sql))
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
    
    # Show method statistics
    hybrid_pdf_count = len([log for log in processing_log.values() 
                            if log.get('status') == 'success' and log.get('method') == 'hybrid_html_pdf'])
    hybrid_html_count = len([log for log in processing_log.values() 
                             if log.get('status') == 'success' and log.get('method') == 'hybrid_html_only'])
    # Legacy methods (for backward compatibility with old logs)
    pdf_count = len([log for log in processing_log.values() 
                     if log.get('status') == 'success' and log.get('method') == 'pdf'])
    html_count = len([log for log in processing_log.values() 
                      if log.get('status') == 'success' and log.get('method') == 'html_fallback'])
    
    if hybrid_pdf_count > 0 or hybrid_html_count > 0 or pdf_count > 0 or html_count > 0:
        print(f"\n[INFO] Method Statistics:")
        if hybrid_pdf_count > 0 or hybrid_html_count > 0:
            print(f"  Hybrid (HTML + PDF minutes): {hybrid_pdf_count} fixtures")
            print(f"  Hybrid (HTML only): {hybrid_html_count} fixtures")
        if pdf_count > 0 or html_count > 0:
            print(f"  Legacy PDF method: {pdf_count} fixtures")
            print(f"  Legacy HTML fallback: {html_count} fixtures")
        if total_in_db > 0:
            hybrid_total = hybrid_pdf_count + hybrid_html_count
            if hybrid_total > 0:
                print(f"  Hybrid approach usage: {hybrid_total/total_in_db*100:.1f}%")
    
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
    # Set retry_failed=True to reprocess all fixtures (useful when fixing parsing issues)
    process_all_fixtures_from_json(retry_failed=True)

