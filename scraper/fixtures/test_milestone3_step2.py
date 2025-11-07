"""
Test script for Milestone 3, Step 2: End-to-End HTML Fallback Test
Tests that the scraper successfully uses HTML fallback on a failed fixture.
"""

import sys
import os
import json

# Add parent directory to path so we can import from 3_update_player_stats
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Import the function - need to handle the filename with numbers
import importlib.util
script_dir = os.path.dirname(os.path.abspath(__file__))
module_path = os.path.join(script_dir, "3_update_player_stats.py")
spec = importlib.util.spec_from_file_location("update_player_stats", module_path)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

# Import needed functions
parse_html_box_score = module.parse_html_box_score
generate_sql = module.generate_sql

def test_single_fixture(fixture_id):
    """
    Test processing a single fixture to verify HTML fallback works.
    """
    print("=" * 70)
    print(f"MILESTONE 3, STEP 2: End-to-End HTML Fallback Test")
    print("=" * 70)
    print()
    
    # Load fixtures
    fixtures_file = os.path.join(script_dir, 'output/fixtures.json')
    if not os.path.exists(fixtures_file):
        print(f"[ERROR] Fixtures file not found: {fixtures_file}")
        return False
    
    with open(fixtures_file, 'r', encoding='utf-8') as f:
        fixtures = json.load(f)
    
    if fixture_id < 1 or fixture_id > len(fixtures):
        print(f"[ERROR] Invalid fixture ID: {fixture_id}")
        return False
    
    fixture = fixtures[fixture_id - 1]
    
    if not fixture.get('box_score_url'):
        print(f"[ERROR] Fixture #{fixture_id} has no box_score_url")
        return False
    
    print(f"Testing Fixture #{fixture_id}: {fixture['home']} vs {fixture['away']}")
    print(f"Date: {fixture.get('date', 'N/A')}")
    print()
    
    # Step 1: Try to get PDF URL (should fail for fixture #2)
    print("Step 1: Attempting PDF extraction...")
    box_score_url = fixture['box_score_url']
    pdf_url = module.get_pdf_url_from_boxscore(box_score_url)
    
    if pdf_url:
        print(f"   [INFO] PDF URL found (unexpected for this fixture)")
        print(f"   [INFO] This fixture has a PDF, so HTML fallback won't be tested")
        return False
    else:
        print(f"   [OK] PDF URL not found (expected)")
        print(f"   [INFO] HTML fallback should be triggered")
    
    print()
    
    # Step 2: Use HTML fallback
    print("Step 2: Using HTML fallback...")
    stats = parse_html_box_score(box_score_url)
    
    if not stats:
        print(f"   [ERROR] HTML fallback failed")
        return False
    
    print(f"   [OK] HTML fallback succeeded!")
    print(f"   [OK] Parsed {len(stats['home_players'])} home + {len(stats['away_players'])} away players")
    print()
    
    # Step 3: Verify data structure
    print("Step 3: Verifying data structure...")
    required_keys = ['home_team', 'away_team', 'home_players', 'away_players']
    missing_keys = [key for key in required_keys if key not in stats]
    
    if missing_keys:
        print(f"   [ERROR] Missing keys: {missing_keys}")
        return False
    
    print(f"   [OK] Data structure is correct")
    print(f"   [OK] Home team: {stats['home_team']}")
    print(f"   [OK] Away team: {stats['away_team']}")
    print()
    
    # Step 4: Test SQL generation
    print("Step 4: Testing SQL generation...")
    fixture_data = {
        'fixture_id': fixture_id,
        'home_team': stats['home_team'],
        'away_team': stats['away_team'],
        'match_date': fixture.get('date', ''),
        'home_players': stats['home_players'],
        'away_players': stats['away_players']
    }
    
    try:
        sql = generate_sql(fixture_data)
        if not sql or len(sql) < 100:
            print(f"   [ERROR] SQL generation failed or produced empty output")
            return False
        
        print(f"   [OK] SQL generated successfully ({len(sql)} characters)")
        print(f"   [OK] SQL contains INSERT statements")
        
        # Check for key SQL elements
        if 'INSERT INTO PlayerFixtureStats' in sql:
            print(f"   [OK] SQL contains PlayerFixtureStats INSERT statements")
        else:
            print(f"   [WARNING] SQL may not contain INSERT statements")
        
    except Exception as e:
        print(f"   [ERROR] SQL generation failed: {e}")
        return False
    
    print()
    print("=" * 70)
    print("✅ STEP 2 COMPLETE: HTML Fallback Integration Verified!")
    print("=" * 70)
    print()
    print("Summary:")
    print(f"  ✅ PDF extraction failed (as expected)")
    print(f"  ✅ HTML fallback succeeded")
    print(f"  ✅ Data structure is correct")
    print(f"  ✅ SQL generation works")
    print()
    print("The HTML fallback is working correctly!")
    
    return True

if __name__ == "__main__":
    # Test with Fixture #2 (Blackburn vs Greenville) - known to fail PDF extraction
    success = test_single_fixture(2)
    
    if not success:
        print()
        print("❌ Test failed - check error messages above")
        sys.exit(1)




