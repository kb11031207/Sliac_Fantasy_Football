"""
SLIAC Teams Scraper - Version 2
Extracts conference team data based on the web search results provided
"""

import json

def get_teams_from_standings():
    """
    Based on the SLIAC standings page, extract team information
    From: https://sliac.org/standings.aspx?standings=234
    """
    teams = [
        {
            'team': 'Greenville',
            'logo_url': 'https://sliac.org/images/logos/Greenville_200x200.png'
        },
        {
            'team': 'Lyon',
            'logo_url': 'https://sliac.org/images/2025/8/20/lc.png'
        },
        {
            'team': 'Webster',
            'logo_url': 'https://sliac.org/images/2025/8/20/wu.png'
        },
        {
            'team': 'Westminster',
            'logo_url': 'https://sliac.org/images/2025/8/20/wc.png'
        },
        {
            'team': 'Principia',
            'logo_url': 'https://sliac.org/images/2025/10/16/pc25a.png'
        },
        {
            'team': 'Spalding',
            'logo_url': 'https://sliac.org/images/2025/8/20/su.png'
        },
        {
            'team': 'Eureka',
            'logo_url': 'https://sliac.org/images/2025/8/20/ec.png'
        },
        {
            'team': 'MUW',
            'logo_url': 'https://sliac.org/images/2025/8/20/muw.png'
        },
        {
            'team': 'Blackburn',
            'logo_url': 'https://sliac.org/images/2025/8/20/bc.png'
        }
    ]
    return teams

def get_school_names():
    """
    Based on the SLIAC members page, map abbreviated names to full school names
    From: https://sliac.org/sports/2023/7/11/GEN_0711232207.aspx
    """
    school_mapping = {
        'Blackburn': 'Blackburn College',
        'Eureka': 'Eureka College',
        'Greenville': 'Greenville University',
        'Lyon': 'Lyon College',
        'MUW': 'Mississippi University for Women',
        'Principia': 'Principia College',
        'Spalding': 'Spalding University',
        'Webster': 'Webster University',
        'Westminster': 'Westminster College'
    }
    return school_mapping

def combine_data(teams, school_mapping):
    """
    Combine team data with full school names
    """
    combined = []
    
    for team in teams:
        team_name = team['team']
        full_name = school_mapping.get(team_name, team_name)
        
        combined.append({
            'team': team_name,
            'school': full_name,
            'logo_url': team['logo_url']
        })
    
    return combined

def generate_sql(teams):
    """
    Generate SQL INSERT statements for the teams
    """
    sql_statements = []
    sql_statements.append("-- SQL INSERT statements for Conference Teams")
    sql_statements.append("-- Generated from SLIAC website data")
    sql_statements.append("-- Source: https://sliac.org/standings.aspx?standings=234")
    sql_statements.append("-- Source: https://sliac.org/sports/2023/7/11/GEN_0711232207.aspx")
    sql_statements.append("")
    
    for team in teams:
        logo_url = team['logo_url'] if team['logo_url'] else 'NULL'
        if logo_url != 'NULL':
            logo_url = f"'{logo_url}'"
        
        # Escape single quotes in names
        team_name = team['team'].replace("'", "''")
        school_name = team['school'].replace("'", "''")
        
        sql = f"INSERT INTO ConferenceTeams (Team, School, LogoUrl) VALUES ('{team_name}', '{school_name}', {logo_url});"
        sql_statements.append(sql)
    
    return '\n'.join(sql_statements)

def main():
    print("SLIAC Conference Teams Data Extractor")
    print("=" * 60)
    
    print("\n1. Getting team data from standings...")
    teams = get_teams_from_standings()
    print(f"   Found {len(teams)} teams")
    
    print("\n2. Getting full school names...")
    school_mapping = get_school_names()
    print(f"   Found {len(school_mapping)} school name mappings")
    
    print("\n3. Combining data...")
    combined_data = combine_data(teams, school_mapping)
    
    print("\n4. Conference Teams:")
    print("-" * 60)
    for team in combined_data:
        print(f"  Team:   {team['team']}")
        print(f"  School: {team['school']}")
        print(f"  Logo:   {team['logo_url']}")
        print()
    
    # Save as JSON
    json_file = 'output/conference_teams.json'
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(combined_data, f, indent=2)
    print(f"[OK] Saved JSON to: {json_file}")
    
    # Generate and save SQL
    sql = generate_sql(combined_data)
    sql_file = 'output/conference_teams.sql'
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write(sql)
    print(f"[OK] Saved SQL to: {sql_file}")
    
    print("\n" + "=" * 60)
    print("Data extraction completed successfully!")
    print(f"\nNext steps:")
    print(f"  1. Review {json_file} to verify the data")
    print(f"  2. Run {sql_file} against your database to insert the teams")

if __name__ == "__main__":
    main()

