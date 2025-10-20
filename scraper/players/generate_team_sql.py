"""
Generate SQL for a specific team only
Useful when you've already inserted some teams
"""
import json
import sys

def generate_sql_for_team(team_name):
    # Load all players
    with open('output/players.json', 'r', encoding='utf-8') as f:
        all_players = json.load(f)
    
    # Filter by team
    team_players = [p for p in all_players if p['team'] == team_name]
    
    if not team_players:
        print(f"No players found for team: {team_name}")
        return
    
    # Generate SQL
    sql_lines = []
    sql_lines.append(f"-- SQL INSERT statements for {team_name} Players Only")
    sql_lines.append("-- Generated from SLIAC team roster pages")
    sql_lines.append("")
    sql_lines.append("-- Position codes: 1=GK, 2=DEF, 3=MID, 4=FWD")
    sql_lines.append("")
    
    for player in team_players:
        name = player['name'].replace("'", "''")
        team = player['team'].replace("'", "''")
        picture_url = f"'{player['picture_url']}'" if player['picture_url'] else 'NULL'
        
        sql = (
            f"INSERT INTO Players (Name, PlayerNum, Position, TeamId, Cost, PictureUrl) "
            f"SELECT '{name}', {player['player_num']}, {player['position']}, Id, {player['cost']}, {picture_url} "
            f"FROM ConferenceTeams WHERE Team = '{team}';"
        )
        sql_lines.append(sql)
    
    # Save to file
    filename = f'output/{team_name.lower()}_players.sql'
    with open(filename, 'w', encoding='utf-8') as f:
        f.write('\n'.join(sql_lines))
    
    print(f"Generated SQL for {team_name}: {len(team_players)} players")
    print(f"Saved to: {filename}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        team_name = sys.argv[1]
    else:
        team_name = "Westminster"  # Default
    
    generate_sql_for_team(team_name)






