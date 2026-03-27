"""
Test script for Milestone 2, Step 5: HTML Parser - Cards Extraction
Tests that we can parse cards (yellow/red) and update player records.
"""

import sys
import os

# Add parent directory to path so we can import from 3_update_player_stats
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Import the function - need to handle the filename with numbers
import importlib.util
script_dir = os.path.dirname(os.path.abspath(__file__))
module_path = os.path.join(script_dir, "3_update_player_stats.py")
spec = importlib.util.spec_from_file_location("update_player_stats", module_path)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
parse_html_box_score = module.parse_html_box_score

def main():
    print("=" * 70)
    print("MILESTONE 2, STEP 5: Test HTML Parser - Cards Extraction")
    print("=" * 70)
    print()
    
    # Use Fixture #2 (Blackburn vs Greenville) - a failed fixture
    test_box_score_url = 'https://sliac.org/boxscore.aspx?id=JcLFfL9RUu0H5ystoOMbjQCbJ%2fC9FElA56FimO5aP%2fe2e1lYZpy3vgN6qpar%2fbq1mZoMlQEkDFerv2jrHZxOaEZXcd2PiipvHa9opiezuOhw7E7SaozeK22iqjGFS%2fTEhICCzEiZMPvcZRUQmhM6Yg%3d%3d&path=msoc'
    
    print(f"Testing with Fixture #2: Blackburn vs Greenville")
    print(f"URL: {test_box_score_url}")
    print()
    
    # Call the function
    result = parse_html_box_score(test_box_score_url)
    
    print()
    print("=" * 70)
    print("RESULTS")
    print("=" * 70)
    
    if result:
        print("✅ Function executed successfully!")
        print()
        print(f"Home Team: {result['home_team']}")
        print(f"Away Team: {result['away_team']}")
        print(f"Home Players: {len(result['home_players'])}")
        print(f"Away Players: {len(result['away_players'])}")
        print()
        
        # Show sample of parsed players
        if result['away_players']:
            print("Sample Away Team Players (first 5):")
            for i, player in enumerate(result['away_players'][:5], 1):
                print(f"  {i}. {player['name']} (#{player['jersey']}, {player['pos']}) - "
                      f"{player['goals']}G, {player['assists']}A, {player['shots']}SH, {player['sog']}SOG")
        else:
            print("⚠️  No away team players parsed")
        
        print()
        if result['home_players']:
            print("Sample Home Team Players (first 5):")
            for i, player in enumerate(result['home_players'][:5], 1):
                print(f"  {i}. {player['name']} (#{player['jersey']}, {player['pos']}) - "
                      f"{player['goals']}G, {player['assists']}A, {player['shots']}SH, {player['sog']}SOG")
        else:
            print("⚠️  No home team players parsed")
        
        # Show goalkeepers with their stats
        print("Goalkeepers with stats:")
        gk_found = False
        for team_name, players in [("Away", result['away_players']), ("Home", result['home_players'])]:
            gks = [p for p in players if p['pos'] == 'GK' and p.get('saves', 0) > 0]
            if gks:
                gk_found = True
                print(f"\n{team_name} Team Goalkeepers:")
                for gk in gks:
                    print(f"  - {gk['name']} (#{gk['jersey']}) - "
                          f"{gk['minutes']}min, {gk['saves']} saves, {gk['goals_against']} GA")
        
        if not gk_found:
            print("  ⚠️  No goalkeepers with stats found")
        
        # Show players with cards
        print("\nPlayers with cards:")
        cards_found = False
        for team_name, players in [("Away", result['away_players']), ("Home", result['home_players'])]:
            players_with_cards = [p for p in players if p.get('yellow_cards', 0) > 0 or p.get('red_cards', 0) > 0]
            if players_with_cards:
                cards_found = True
                print(f"\n{team_name} Team Players with Cards:")
                for player in players_with_cards:
                    cards_str = []
                    if player.get('yellow_cards', 0) > 0:
                        cards_str.append(f"{player['yellow_cards']}Y")
                    if player.get('red_cards', 0) > 0:
                        cards_str.append(f"{player['red_cards']}R")
                    print(f"  - {player['name']} (#{player['jersey']}) - {', '.join(cards_str)}")
        
        if not cards_found:
            print("  ⚠️  No players with cards found")
        
        print()
        if len(result['away_players']) > 0 and len(result['home_players']) > 0:
            if gk_found and cards_found:
                print("✅ Step 5 Complete: All stats parsed successfully!")
            elif gk_found:
                print("⚠️  Step 5 Partial: Teams and GK stats parsed, but cards not found")
            elif cards_found:
                print("⚠️  Step 5 Partial: Teams and cards parsed, but GK stats not found")
            else:
                print("⚠️  Step 5 Partial: Teams parsed, but GK stats and cards not found")
        elif len(result['away_players']) > 0:
            print("⚠️  Step 5 Partial: Away team parsed, but home team not parsed")
        else:
            print("❌ Step 5 Failed: No players parsed from tables")
    else:
        print("❌ Function returned None - check error messages above")
        print()
        print("❌ Step 2 Failed: Need to debug table parsing")
    
    print()
    print("=" * 70)

if __name__ == "__main__":
    main()

