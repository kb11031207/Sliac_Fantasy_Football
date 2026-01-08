"""
SLIAC Players Scraper
Extracts player roster data from SLIAC conference team websites
"""

import json
import random
import re
import requests
from bs4 import BeautifulSoup

# Team mapping: team name -> (roster_url, team_identifier)
TEAM_ROSTERS = {
    'Principia': {
        'url': 'https://principiaathletics.com/sports/mens-soccer/roster',
        'team': 'Principia'
    }
    # More teams will be added here
}

# Position mapping: roster abbreviation -> database code
POSITION_MAP = {
    'GK': 1,  # Goalkeeper
    'D': 2,   # Defender
    'M': 3,   # Midfielder
    'F': 4    # Forward
}

# Cost ranges by position
COST_RANGES = {
    1: (4.0, 5.0),   # GK: 4.0-5.0
    2: (4.5, 6.0),   # DEF: 4.5-6.0
    3: (5.0, 8.0),   # MID: 5.0-8.0
    4: (6.0, 12.0)   # FWD: 6.0-12.0
}

def round_to_half(value):
    """Round a value to the nearest 0.5"""
    return round(value * 2) / 2

def generate_player_cost(position, is_star=False):
    """
    Generate a random cost for a player based on position
    
    Args:
        position: Position code (1=GK, 2=DEF, 3=MID, 4=FWD)
        is_star: Whether this player should get a premium boost
    
    Returns:
        Decimal cost rounded to nearest 0.5
    """
    min_cost, max_cost = COST_RANGES[position]
    base_cost = random.uniform(min_cost, max_cost)
    
    # Apply star boost
    if is_star:
        base_cost += random.uniform(0.5, 1.0)
        # Cap at max + 2.0
        base_cost = min(base_cost, max_cost + 2.0)
    
    return round_to_half(base_cost)

def parse_jersey_number(jersey_str):
    """
    Parse jersey number, handling special formats like '0/18'
    """
    # Handle integer input
    if isinstance(jersey_str, int):
        return jersey_str
    
    # Handle string input
    jersey_str = str(jersey_str)
    if '/' in jersey_str:
        # Take the first number
        return int(jersey_str.split('/')[0])
    return int(jersey_str)

def scrape_generic_roster(url, base_url):
    """
    Scrape a roster page that uses the sidearm-roster format
    This format is used by most SLIAC teams
    
    Args:
        url: Full URL to the roster page
        base_url: Base URL for resolving relative image paths
    
    Returns:
        List of player dictionaries with jersey, name, position, picture_url
    """
    print(f"   Fetching: {url}")
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    
    players = []
    
    # Find all player entries
    player_items = soup.find_all('li', class_='sidearm-roster-player')
    
    if not player_items:
        print(f"   Warning: No players found using sidearm-roster format")
        return players
    
    for item in player_items:
        try:
            # Extract jersey number
            jersey_elem = item.find('span', class_='sidearm-roster-player-jersey-number')
            jersey = jersey_elem.text.strip() if jersey_elem else '0'
            
            # Extract player name
            name_elem = item.find('h3')
            if name_elem:
                name_link = name_elem.find('a')
                name = name_link.text.strip() if name_link else name_elem.text.strip()
            else:
                continue  # Skip if no name found
            
            # Extract position - try multiple methods
            position = None
            position_text = None
            
            # Method 1: Try the standard position element (for some teams)
            position_elem = item.find('span', class_='sidearm-roster-player-position-long-short')
            if position_elem:
                position_text = position_elem.text.strip().upper()
            
            # Method 2: Try div.sidearm-roster-player-position (for Greenville, Spalding, Westminster)
            if not position_text:
                position_div = item.find('div', class_='sidearm-roster-player-position')
                if position_div:
                    # The position is usually in a span.text-bold inside the div
                    # But the div text might also contain height/weight, so get first text node
                    bold_span = position_div.find('span', class_='text-bold')
                    if bold_span:
                        position_text = bold_span.text.strip().upper()
                    else:
                        # Fallback: get all text and take first word (before height/weight)
                        all_text = position_div.get_text(strip=True)
                        # Position is usually first, followed by height like "GK6'2"185 lbs"
                        # Extract just the position letters (GK, D, M, F, etc.)
                        match = re.match(r'^([A-Z]+(?:\s*/\s*[A-Z]+)?)', all_text)
                        if match:
                            position_text = match.group(1).strip().upper()
            
            # Method 3: Try span.sidearm-roster-player-position as fallback
            if not position_text:
                position_span = item.find('span', class_='sidearm-roster-player-position')
                if position_span:
                    position_text = position_span.text.strip().upper()
            
            # Parse the position text
            if position_text:
                # Handle dual positions (D/M, M/D, M/F) - use the primary (first) position
                if '/' in position_text:
                    position_text = position_text.split('/')[0].strip()
                
                # Clean up: remove any trailing numbers or special chars that might have been included
                # But preserve letters and common position abbreviations
                position_text = re.sub(r'[^A-Z/]', '', position_text)
                # If there's still a slash, take the first part
                if '/' in position_text:
                    position_text = position_text.split('/')[0].strip()
                
                # Map various position formats to our standard codes
                # GK/Goalkeeper -> GK
                if position_text in ['GK', 'GOALKEEPER'] or 'GOALKEEPER' in position_text:
                    position = 'GK'
                # Defender variations: D, DEF, DEFENDER -> D
                elif position_text in ['D', 'DEF', 'DEFENDER'] or 'DEFENSE' in position_text:
                    position = 'D'
                # Midfielder variations: M, MF, MID, MIDFIELDER -> M
                elif position_text in ['M', 'MF', 'MID', 'MIDFIELDER'] or 'MIDFIELD' in position_text:
                    position = 'M'
                # Forward/Attacker variations: F, FW, FORWARD, W, WINGER -> F
                elif position_text in ['F', 'FW', 'FORWARD', 'W', 'WINGER', 'WING'] or 'ATTACK' in position_text:
                    position = 'F'
                else:
                    # Default to midfielder for unknown positions
                    position = 'M'
                    print(f"   Warning: Unknown position '{position_text}' for {name}, defaulting to Midfielder")
            else:
                # No position found - default to midfielder but warn
                position = 'M'
                print(f"   Warning: Could not find position element for {name}, defaulting to Midfielder")
            
            # Extract picture URL
            picture_url = None
            img_elem = item.find('img')
            if img_elem:
                # Try src first, then data-src
                img_src = img_elem.get('src') or img_elem.get('data-src')
                if img_src:
                    # Make it a full URL if it's relative
                    if img_src.startswith('/'):
                        picture_url = base_url + img_src
                    elif not img_src.startswith('http'):
                        picture_url = base_url + '/' + img_src
                    else:
                        picture_url = img_src
            
            players.append({
                'jersey': jersey,
                'name': name,
                'position': position,
                'picture_url': picture_url
            })
            
        except Exception as e:
            print(f"   Warning: Error parsing player: {e}")
            continue
    
    return players

def scrape_blackburn_roster_from_file(html_file, base_url):
    """
    Parse Blackburn roster from saved HTML file (table-based format)
    """
    print(f"   Parsing from file: {html_file}")
    
    with open(html_file, 'r', encoding='utf-8') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
    
    players = []
    
    # Find the roster table
    roster_table = soup.find('table')
    if not roster_table:
        print("   Warning: Could not find roster table")
        return players
    
    # Find all table rows (skip header row)
    rows = roster_table.find_all('tr')[1:]  # Skip header
    
    for row in rows:
        try:
            cells = row.find_all('td')
            if len(cells) < 3:
                continue
            
            # First cell: Jersey number
            jersey_text = cells[0].get_text(strip=True)
            if not jersey_text or jersey_text == '':
                # Skip rows without jersey numbers (like student managers)
                continue
            
            jersey = parse_jersey_number(jersey_text)
            
            # Second cell: Name
            name = cells[1].get_text(strip=True)
            
            if not name or 'Student Manager' in name:
                continue
            
            # Third cell: Position (format: "Pos.: Goalkeeper")
            position_text = cells[2].get_text(strip=True)
            if 'Pos.:' in position_text:
                position_text = position_text.split('Pos.:')[1].strip().upper()
            else:
                position_text = position_text.strip().upper()
            
            # Map position to our standard codes
            if position_text in ['GOALKEEPER', 'GK']:
                position = 'GK'
            elif position_text in ['DEFENDER', 'DEF', 'D']:
                position = 'D'
            elif position_text in ['MIDFIELDER', 'MID', 'M']:
                position = 'M'
            elif position_text in ['FORWARD', 'FWD', 'F']:
                position = 'F'
            else:
                position = 'M'  # Default
                print(f"   Warning: Unknown position '{position_text}' for {name}, defaulting to Midfielder")
            
            # Blackburn roster doesn't show pictures in the table
            picture_url = None
            
            players.append({
                'jersey': jersey,
                'name': name,
                'position': position,
                'picture_url': picture_url
            })
            
        except Exception as e:
            print(f"   Warning: Error parsing row: {e}")
            continue
    
    return players

def scrape_eureka_roster_from_file(html_file, base_url):
    """
    Parse Eureka roster from saved HTML file (site blocks scrapers)
    """
    print(f"   Parsing from file: {html_file}")
    
    with open(html_file, 'r', encoding='utf-8') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
    
    players = []
    
    # Find all player card wrappers
    player_cards = soup.find_all('div', class_='player-card-wrapper')
    
    for card in player_cards:
        try:
            # Get jersey number from the card footer
            jersey_elem = card.find('span', class_='number')
            if not jersey_elem:
                continue
            
            jersey_text = jersey_elem.text.strip()
            # Remove # if present
            jersey = parse_jersey_number(jersey_text.replace('#', ''))
            
            # Get name from the card-back section for more accurate data
            card_back = card.find('div', class_='card-back')
            if card_back:
                firstname_elem = card_back.find('span', class_='firstname')
                lastname_elem = card_back.find('span', class_='lastname')
                
                if firstname_elem and lastname_elem:
                    name = f"{firstname_elem.text.strip()} {lastname_elem.text.strip()}"
                else:
                    continue
            else:
                continue
            
            # Get position from bio-data
            position = None
            # Find the li element that contains "Position:"
            bio_data = card_back.find('div', class_='bio-data')
            if bio_data:
                for li in bio_data.find_all('li'):
                    li_text = li.get_text(strip=True)
                    if 'Position:' in li_text:
                        # Extract position after "Position:"
                        position_text = li_text.split('Position:')[1].strip().upper()
                        
                        # Map various position formats to our standard codes
                        # GK/Goalkeeper -> GK
                        if position_text in ['GK', 'GOALKEEPER'] or 'GOALKEEPER' in position_text:
                            position = 'GK'
                        # Defender variations: D, DEF, DEFENDER -> D
                        elif position_text in ['D', 'DEF', 'DEFENDER'] or 'DEFENSE' in position_text:
                            position = 'D'
                        # Midfielder variations: M, MF, MID, MIDFIELDER -> M
                        elif position_text in ['M', 'MF', 'MID', 'MIDFIELDER'] or 'MIDFIELD' in position_text:
                            position = 'M'
                        # Forward/Attacker variations: F, FW, FORWARD, W, WINGER -> F
                        elif position_text in ['F', 'FW', 'FORWARD', 'W', 'WINGER', 'WING'] or 'ATTACK' in position_text:
                            position = 'F'
                        else:
                            # Default to midfielder for unknown positions
                            position = 'M'
                            print(f"   Warning: Unknown position '{position_text}' for {name}, defaulting to Midfielder")
                        break
            
            if position is None:
                print(f"   Warning: Could not determine position for {name}, skipping")
                continue
            
            # Get picture URL
            picture_url = None
            img_elem = card_back.find('img', alt=lambda x: x and 'bio photo' in x)
            if img_elem and img_elem.get('src'):
                picture_url = base_url + img_elem['src']
            
            players.append({
                'jersey': jersey,
                'name': name,
                'position': position,
                'picture_url': picture_url
            })
            
        except Exception as e:
            print(f"   Warning: Error parsing player: {e}")
            continue
    
    return players

def process_team_roster(team_name, raw_players):
    """
    Process raw player data and add database fields
    
    Args:
        team_name: Name of the team
        raw_players: List of raw player dictionaries
    
    Returns:
        List of processed player dictionaries ready for database
    """
    processed_players = []
    
    # Skip if no players found
    if not raw_players:
        print(f"   Warning: No players found for {team_name}")
        return processed_players
    
    # Pick 1-2 random "star" players for this team
    star_count = random.randint(1, 2)
    star_indices = random.sample(range(len(raw_players)), star_count)
    
    for idx, player in enumerate(raw_players):
        # Parse jersey number
        jersey_num = parse_jersey_number(player['jersey'])
        
        # Map position to database code
        position_code = POSITION_MAP[player['position']]
        
        # Generate cost (with star boost if applicable)
        is_star = idx in star_indices
        cost = generate_player_cost(position_code, is_star)
        
        processed_player = {
            'name': player['name'],
            'player_num': jersey_num,
            'position': position_code,
            'position_name': player['position'],  # For readability
            'team': team_name,
            'cost': cost,
            'is_star': is_star,
            'picture_url': player.get('picture_url')  # Extract from roster page
        }
        
        processed_players.append(processed_player)
    
    return processed_players

def generate_sql(all_players):
    """
    Generate SQL INSERT statements for all players
    Uses subquery to lookup TeamId by team name
    """
    sql_statements = []
    sql_statements.append("-- SQL INSERT statements for Players")
    sql_statements.append("-- Generated from SLIAC team roster pages")
    sql_statements.append("-- Note: Costs are randomly generated within position-appropriate ranges")
    sql_statements.append("")
    sql_statements.append("-- Position codes: 1=GK, 2=DEF, 3=MID, 4=FWD")
    sql_statements.append("")
    
    for player in all_players:
        # Escape single quotes in names
        name = player['name'].replace("'", "''")
        team = player['team'].replace("'", "''")
        
        picture_url = f"'{player['picture_url']}'" if player['picture_url'] else 'NULL'
        
        # Use subquery to get TeamId from ConferenceTeams table
        sql = (
            f"INSERT INTO Players (Name, PlayerNum, Position, TeamId, Cost, PictureUrl) "
            f"SELECT '{name}', {player['player_num']}, {player['position']}, Id, {player['cost']}, {picture_url} "
            f"FROM ConferenceTeams WHERE Team = '{team}';"
        )
        
        sql_statements.append(sql)
    
    return '\n'.join(sql_statements)

def main():
    print("SLIAC Player Roster Scraper")
    print("=" * 70)
    
    all_players = []
    
    # Process Principia roster
    print("\n1. Scraping Principia roster...")
    principia_url = 'https://principiaathletics.com/sports/mens-soccer/roster'
    principia_base = 'https://principiaathletics.com'
    principia_raw = scrape_generic_roster(principia_url, principia_base)
    print(f"   Found {len(principia_raw)} players")
    
    print("\n2. Scraping Westminster roster...")
    westminster_url = 'https://wcbluejays.wcmo.edu/sports/mens-soccer/roster'
    westminster_base = 'https://wcbluejays.wcmo.edu'
    westminster_raw = scrape_generic_roster(westminster_url, westminster_base)
    print(f"   Found {len(westminster_raw)} players")
    
    print("\n3. Scraping Webster roster...")
    webster_url = 'https://websterathletics.com/sports/mens-soccer/roster'
    webster_base = 'https://websterathletics.com'
    webster_raw = scrape_generic_roster(webster_url, webster_base)
    print(f"   Found {len(webster_raw)} players")
    
    print("\n4. Scraping Spalding roster...")
    spalding_url = 'https://spaldingathletics.com/sports/mens-soccer/roster'
    spalding_base = 'https://spaldingathletics.com'
    spalding_raw = scrape_generic_roster(spalding_url, spalding_base)
    print(f"   Found {len(spalding_raw)} players")
    
    print("\n5. Scraping Lyon roster...")
    lyon_url = 'https://lyonscots.com/sports/mens-soccer/roster'
    lyon_base = 'https://lyonscots.com'
    lyon_raw = scrape_generic_roster(lyon_url, lyon_base)
    print(f"   Found {len(lyon_raw)} players")
    
    print("\n6. Scraping Greenville roster...")
    greenville_url = 'https://greenvillepanthers.com/sports/mens-soccer/roster'
    greenville_base = 'https://greenvillepanthers.com'
    greenville_raw = scrape_generic_roster(greenville_url, greenville_base)
    print(f"   Found {len(greenville_raw)} players")
    
    print("\n7. Scraping MUW roster...")
    muw_url = 'https://owlsathletics.com/sports/mens-soccer/roster'
    muw_base = 'https://owlsathletics.com'
    muw_raw = scrape_generic_roster(muw_url, muw_base)
    print(f"   Found {len(muw_raw)} players")
    
    print("\n8. Parsing Eureka roster from saved HTML...")
    eureka_html_file = 'scraper/players/ureka.html'
    eureka_base = 'https://eurekareddevils.com'
    eureka_raw = scrape_eureka_roster_from_file(eureka_html_file, eureka_base)
    print(f"   Found {len(eureka_raw)} players")
    
    print("\n9. Parsing Blackburn roster from saved HTML...")
    blackburn_html_file = 'scraper/players/blackburn.html'
    blackburn_base = 'https://www.blackburnbeavers.com'
    blackburn_raw = scrape_blackburn_roster_from_file(blackburn_html_file, blackburn_base)
    print(f"   Found {len(blackburn_raw)} players")
    
    print("\n10. Processing player data and generating costs...")
    principia_players = process_team_roster('Principia', principia_raw)
    westminster_players = process_team_roster('Westminster', westminster_raw)
    webster_players = process_team_roster('Webster', webster_raw)
    spalding_players = process_team_roster('Spalding', spalding_raw)
    lyon_players = process_team_roster('Lyon', lyon_raw)
    greenville_players = process_team_roster('Greenville', greenville_raw)
    muw_players = process_team_roster('MUW', muw_raw)
    eureka_players = process_team_roster('Eureka', eureka_raw)
    blackburn_players = process_team_roster('Blackburn', blackburn_raw)
    all_players.extend(principia_players)
    all_players.extend(westminster_players)
    all_players.extend(webster_players)
    all_players.extend(spalding_players)
    all_players.extend(lyon_players)
    all_players.extend(greenville_players)
    all_players.extend(muw_players)
    all_players.extend(eureka_players)
    all_players.extend(blackburn_players)
    
    # Show summary by position
    print("\n10. Player Summary:")
    print("-" * 70)
    position_names = {1: 'Goalkeepers', 2: 'Defenders', 3: 'Midfielders', 4: 'Forwards'}
    for pos_code in [1, 2, 3, 4]:
        pos_players = [p for p in all_players if p['position'] == pos_code]
        if pos_players:
            avg_cost = sum(p['cost'] for p in pos_players) / len(pos_players)
            stars = [p for p in pos_players if p['is_star']]
            print(f"  {position_names[pos_code]:12} {len(pos_players):2} players  "
                  f"Avg: ${avg_cost:.1f}  Stars: {len(stars)}")
    
    print(f"\n  Total: {len(all_players)} players")
    print(f"  Total star players: {sum(1 for p in all_players if p['is_star'])}")
    
    # Show some example players
    print("\n11. Sample Players:")
    print("-" * 70)
    print(f"  {'#':3} {'Name':25} {'Pos':3} {'Cost':5} {'Star':4}")
    print("-" * 70)
    for player in all_players[:10]:
        star_marker = "*" if player['is_star'] else ""
        print(f"  {player['player_num']:3} {player['name']:25} "
              f"{player['position_name']:3} ${player['cost']:4.1f} {star_marker:4}")
    if len(all_players) > 10:
        print(f"  ... and {len(all_players) - 10} more players")
    
    # Save as JSON
    json_file = 'scraper/players/output/players.json'
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(all_players, f, indent=2)
    print(f"\n[OK] Saved JSON to: {json_file}")
    
    # Generate and save SQL
    sql = generate_sql(all_players)
    sql_file = 'scraper/players/output/players.sql'
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write(sql)
    print(f"[OK] Saved SQL to: {sql_file}")
    
    # Show team breakdown
    print("\n12. Team Breakdown:")
    print("-" * 70)
    teams_list = list(set(p['team'] for p in all_players))
    for team in sorted(teams_list):
        team_players = [p for p in all_players if p['team'] == team]
        print(f"  {team:15} {len(team_players):2} players")
    
    print("\n" + "=" * 70)
    print("Player data extraction completed successfully!")
    print(f"\nNext steps:")
    print(f"  1. Review {json_file} to verify the data")
    print(f"  2. Run {sql_file} against your database to insert the players")
    if len(teams_list) == 9:
        print(f"  3. All 9 SLIAC teams complete!")
    else:
        print(f"  3. Currently scraping {len(teams_list)} of 9 SLIAC teams")

if __name__ == "__main__":
    main()

