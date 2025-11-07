"""
SLIAC Results Updater - LIVE SCRAPER (Overall Results Table)
=============================================================
Scrapes LIVE match results from the SLIAC stats page "Overall Results" table.

The table format is simple:
- Date | Location | Result
- Result format: "* HomeTeam <b>Score1 - Score2</b> AwayTeam"
- Each result has a box score URL

This is the cleanest and most reliable way to get match data!

Run this whenever you want fresh results.
"""

import requests
from bs4 import BeautifulSoup
import re
from datetime import datetime

def get_team_abbreviation(team_name):
    """
    Clean and standardize team names to match your database
    """
    team_name = team_name.strip()
    
    # Remove asterisks (conference game indicator)
    team_name = team_name.replace('*', '').strip()
    
    mapping = {
        'Blackburn College': 'Blackburn',
        'Blackburn': 'Blackburn',
        'Eureka College': 'Eureka',
        'Eureka': 'Eureka',
        'Greenville University': 'Greenville',
        'Greenville': 'Greenville',
        'Lyon College': 'Lyon',
        'Lyon': 'Lyon',
        'Mississippi University for Women': 'MUW',
        'MUW': 'MUW',
        'Principia College': 'Principia',
        'Principia': 'Principia',
        'Spalding University': 'Spalding',
        'Spalding University (Ky.)': 'Spalding',
        'Spalding': 'Spalding',
        'Webster University': 'Webster',
        'Webster': 'Webster',
        'Westminster College': 'Westminster',
        'Westminster': 'Westminster'
    }
    
    return mapping.get(team_name, team_name)

def parse_result_cell(result_cell):
    """
    Parse the result cell to extract home team, away team, and scores.
    
    Format: "* HomeTeam <b>HomeScore - AwayScore</b> AwayTeam"
    Example: "* Westminster <b>5 - 0</b> MUW"
    
    Returns: dict with home, away, home_score, away_score, box_score_url
    """
    # Get the link (contains box score URL)
    link = result_cell.find('a')
    if not link:
        return None
    
    # Extract box score URL
    box_score_href = link.get('href', '')
    if box_score_href:
        # Make it a full URL
        box_score_url = f"https://sliac.org/{box_score_href}" if not box_score_href.startswith('http') else box_score_href
    else:
        box_score_url = None
    
    # Get the full text content
    full_text = link.get_text(separator=' ', strip=True)
    
    # Remove asterisk and extra spaces
    full_text = full_text.replace('*', '').strip()
    
    # Find the score in bold tags
    bold = link.find('b')
    if not bold:
        return None
    
    score_text = bold.get_text(strip=True)
    
    # Parse score (format: "5 - 0")
    score_match = re.match(r'(\d+)\s*-\s*(\d+)', score_text)
    if not score_match:
        return None
    
    home_score = int(score_match.group(1))
    away_score = int(score_match.group(2))
    
    # Extract team names by splitting on the score
    # The format is: "HomeTeam Score AwayTeam"
    # Remove the score text to get the teams
    teams_text = full_text.replace(score_text, '|').strip()
    parts = teams_text.split('|')
    
    if len(parts) != 2:
        return None
    
    home_team = get_team_abbreviation(parts[0].strip())
    away_team = get_team_abbreviation(parts[1].strip())
    
    return {
        'home': home_team,
        'away': away_team,
        'home_score': home_score,
        'away_score': away_score,
        'box_score_url': box_score_url
    }

def scrape_overall_results():
    """
    Scrape the "Overall Results" table from SLIAC stats page
    """
    url = 'https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true'
    print(f"🌐 Fetching LIVE data from: {url}")
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    }
    
    try:
        response = requests.get(url, headers=headers, timeout=15)
        response.raise_for_status()
        print("✅ Page fetched successfully")
    except requests.exceptions.RequestException as e:
        print(f"❌ Error: {e}")
        return []
    
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find the "Overall Results" section
    overall_section = soup.find('section', id='res_overall')
    if not overall_section:
        print("❌ Could not find 'Overall Results' section")
        return []
    
    print("✅ Found 'Overall Results' section")
    
    # Find the results table
    table = overall_section.find('table', class_='sidearm-table')
    if not table:
        print("❌ Could not find results table")
        return []
    
    print("✅ Found results table")
    
    # Parse table rows
    rows = table.find_all('tr')
    games = []
    
    for row in rows[1:]:  # Skip header row
        cells = row.find_all('td')
        if len(cells) < 3:
            continue
        
        # Extract date (first column)
        date_text = cells[0].get_text(strip=True)
        try:
            date_obj = datetime.strptime(date_text, '%m/%d/%Y')
            date_str = date_obj.strftime('%Y-%m-%d')
        except:
            continue
        
        # Parse result cell (third column)
        result_data = parse_result_cell(cells[2])
        if not result_data:
            continue
        
        # Add date to result
        result_data['date'] = date_str
        games.append(result_data)
    
    print(f"🎯 Found {len(games)} completed games")
    
    return games

def generate_update_sql(completed_games):
    """
    Generate SQL to insert/update fixture results
    Uses MERGE to handle both new results and updates
    Handles rescheduled games by matching within a 7-day window
    """
    if not completed_games:
        return "-- No completed games found!\n", 0
    
    sql = []
    sql.append("-- Insert/Update Fixture Results (LIVE DATA from Overall Results)")
    sql.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    sql.append(f"-- Scraped from: https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true")
    sql.append("-- Inserts results into FixtureResults table")
    sql.append("-- Updates Fixtures.Kickoff to actual date played (handles reschedules)")
    sql.append("-- Note: Matches games within 7-day window to handle reschedules")
    sql.append("")
    
    for game in completed_games:
        home = game['home'].replace("'", "''")
        away = game['away'].replace("'", "''")
        home_score = game['home_score']
        away_score = game['away_score']
        date = game['date']
        
        sql.append(f"""-- {home} {home_score} - {away_score} {away} ({date})
DECLARE @FixtureId INT;
DECLARE @IsSwapped BIT = 0;

-- Try to find fixture with correct home/away (within 7-day window)
SELECT @FixtureId = Id
FROM Fixtures
WHERE HomeTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = '{home}')
  AND AwayTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = '{away}')
  AND ABS(DATEDIFF(day, CAST(Kickoff AS DATE), '{date}')) <= 7;

-- If not found, try swapped home/away (some games might be recorded differently)
IF @FixtureId IS NULL
BEGIN
    SELECT @FixtureId = Id
    FROM Fixtures
    WHERE HomeTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = '{away}')
      AND AwayTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = '{home}')
      AND ABS(DATEDIFF(day, CAST(Kickoff AS DATE), '{date}')) <= 7;
    
    IF @FixtureId IS NOT NULL
        SET @IsSwapped = 1;
END

IF @FixtureId IS NOT NULL
BEGIN
    -- Update fixture kickoff date (preserve original time)
    UPDATE Fixtures
    SET Kickoff = CAST(CAST('{date}' AS DATETIME) + CAST(CAST(Kickoff AS TIME) AS DATETIME) AS DATETIME)
    WHERE Id = @FixtureId;
    
    -- Insert or update result (swap scores if teams were swapped)
    IF EXISTS (SELECT 1 FROM FixtureResults WHERE FixtureId = @FixtureId)
    BEGIN
        IF @IsSwapped = 1
            UPDATE FixtureResults
            SET HomeScore = {away_score}, AwayScore = {home_score}
            WHERE FixtureId = @FixtureId;
        ELSE
            UPDATE FixtureResults
            SET HomeScore = {home_score}, AwayScore = {away_score}
            WHERE FixtureId = @FixtureId;
    END
    ELSE
    BEGIN
        IF @IsSwapped = 1
            INSERT INTO FixtureResults (FixtureId, HomeScore, AwayScore)
            VALUES (@FixtureId, {away_score}, {home_score});
        ELSE
            INSERT INTO FixtureResults (FixtureId, HomeScore, AwayScore)
            VALUES (@FixtureId, {home_score}, {away_score});
    END
END
ELSE
BEGIN
    PRINT 'Warning: Could not find fixture for {home} vs {away} on {date}';
END
GO

""")
    
    return '\n'.join(sql), len(completed_games)

def save_games_json(games):
    """
    Save games to JSON for reference
    """
    output_file = 'output/latest_results.json'
    import json
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(games, f, indent=2)
    print(f"💾 Saved JSON to: {output_file}")

def main():
    print("=" * 70)
    print("SLIAC Results Updater - LIVE SCRAPER")
    print("Using: Overall Results Table (cleanest method)")
    print("=" * 70)
    print()
    
    # Scrape live results
    completed_games = scrape_overall_results()
    
    if not completed_games:
        print("\n❌ No games found!")
        return
    
    # Save JSON for reference
    save_games_json(completed_games)
    
    # Generate UPDATE SQL
    update_sql, count = generate_update_sql(completed_games)
    
    # Save SQL
    output_file = 'output/update_results.sql'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(update_sql)
    
    print(f"💾 Saved SQL to: {output_file}")
    print(f"✅ Successfully extracted {count} completed games with FRESH data!")
    print("\n" + "=" * 70)
    print("📝 Next steps:")
    print("  1. Review: output/latest_results.json")
    print("  2. Run SQL: output/update_results.sql")
    print("  3. All scores are now up-to-date including today's games!")
    print("\n💡 Tip: Run this script after each gameweek to stay current")

if __name__ == "__main__":
    main()
