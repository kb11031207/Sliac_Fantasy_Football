"""
SLIAC Fixtures Setup Script - RUN ONCE
======================================
This script sets up your fixtures database using the already-extracted fixture data.

What it does:
1. Creates gameweeks (1-6) 
2. Inserts all fixtures (completed + future)
3. Sets initial status (IsFinished=0 for all)

You already have the fixture data in output/fixtures.json
This script just loads it into your database.

Run this ONCE to populate your Fixtures table.
After that, use script #2 to update results as games are played.
"""

import json
from datetime import datetime

def load_fixtures_data():
    """
    Load the already-scraped fixture data
    """
    with open('scraper/fixtures/output/fixtures.json', 'r', encoding='utf-8') as f:
        return json.load(f)

def generate_gameweeks_sql():
    """
    Generate SQL to create 6 gameweeks
    Schema: id (identity), startTime (datetime), endTime (datetime), isComplete (bit)
    """
    sql = []
    sql.append("-- Create Gameweeks")
    sql.append("-- Schema: startTime, endTime, isComplete")
    sql.append("")
    
    # Gameweek dates (start of week to end of week)
    gameweek_dates = [
        ("2025-09-27 00:00:00", "2025-09-30 23:59:59"),  # GW1: Sep 27-30
        ("2025-10-01 00:00:00", "2025-10-07 23:59:59"),  # GW2: Oct 1-7
        ("2025-10-08 00:00:00", "2025-10-13 23:59:59"),  # GW3: Oct 8-13
        ("2025-10-14 00:00:00", "2025-10-20 23:59:59"),  # GW4: Oct 14-20
        ("2025-10-21 00:00:00", "2025-10-27 23:59:59"),  # GW5: Oct 21-27
        ("2025-10-28 00:00:00", "2025-11-03 23:59:59"),  # GW6: Oct 28-Nov 3
    ]
    
    for start_time, end_time in gameweek_dates:
        sql.append(f"INSERT INTO Gameweeks (startTime, endTime, isComplete) VALUES ('{start_time}', '{end_time}', 0);")
    
    sql.append("")
    return '\n'.join(sql)

def generate_fixtures_sql(fixtures):
    """
    Generate SQL to insert all fixtures
    Schema: Id (identity), GameweekId, HomeTeamId, AwayTeamId, Kickoff, BoxScoreUrl
    """
    sql = []
    sql.append("-- Insert All Fixtures")
    sql.append("-- Schema: GameweekId, HomeTeamId, AwayTeamId, Kickoff, BoxScoreUrl")
    sql.append("-- Results will be added to FixtureResults table later")
    sql.append("")
    
    for fixture in fixtures:
        home = fixture['home'].replace("'", "''")
        away = fixture['away'].replace("'", "''")
        date = fixture['date']
        gameweek = fixture.get('gameweek_id', 1)
        
        # Default kickoff time if not specified
        kickoff = f"{date} 15:00:00"
        
        # Box score URL if available
        box_score_url = fixture.get('box_score_url')
        if box_score_url:
            box_score_url = box_score_url.replace("'", "''")
            box_score_sql = f"'{box_score_url}'"
        else:
            box_score_sql = "NULL"
        
        sql.append(f"""INSERT INTO Fixtures (GameweekId, HomeTeamId, AwayTeamId, Kickoff, BoxScoreUrl)
SELECT 
    {gameweek},
    (SELECT Id FROM ConferenceTeams WHERE Team = '{home}'),
    (SELECT Id FROM ConferenceTeams WHERE Team = '{away}'),
    '{kickoff}',
    {box_score_sql};""")
        sql.append("")
    
    return '\n'.join(sql)

def main():
    print("SLIAC Fixtures Setup Script")
    print("=" * 70)
    print()
    
    # Load fixture data
    print("Loading fixture data from output/fixtures.json...")
    fixtures = load_fixtures_data()
    print(f"✓ Loaded {len(fixtures)} fixtures")
    
    # Generate gameweeks SQL
    print("\nGenerating gameweeks SQL...")
    gameweeks_sql = generate_gameweeks_sql()
    
    # Generate fixtures SQL
    print("Generating fixtures SQL...")
    fixtures_sql = generate_fixtures_sql(fixtures)
    
    # Combine and save
    full_sql = "-- SLIAC Fixtures Setup\n"
    full_sql += f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
    full_sql += "-- Run this ONCE to set up all fixtures\n\n"
    full_sql += gameweeks_sql + "\n\n"
    full_sql += fixtures_sql
    
    output_file = 'scraper/fixtures/output/setup_fixtures.sql'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(full_sql)
    
    print(f"\n✓ Saved to: {output_file}")
    print("\n" + "=" * 70)
    print("Next steps:")
    print("  1. Run the SQL file against your database")
    print("  2. This will create gameweeks and load all fixtures")
    print("  3. Then use script #2 to update results as games are played")

if __name__ == "__main__":
    main()

