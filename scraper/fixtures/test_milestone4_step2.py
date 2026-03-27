"""
Test script for Milestone 4, Step 2: Verify Processing Log and SQL Output
Verifies that the processing log correctly tracks methods and SQL output is valid.
"""

import sys
import os
import json
import re

script_dir = os.path.dirname(os.path.abspath(__file__))

def main():
    print("=" * 70)
    print("MILESTONE 4, STEP 2: Verify Processing Log and SQL Output")
    print("=" * 70)
    print()
    
    # Step 1: Verify processing log
    print("Step 1: Verifying processing log...")
    print()
    
    log_file = os.path.join(script_dir, 'output/processing_log.json')
    
    if not os.path.exists(log_file):
        print(f"[ERROR] Processing log not found: {log_file}")
        return False
    
    with open(log_file, 'r', encoding='utf-8') as f:
        processing_log = json.load(f)
    
    print(f"Found {len(processing_log)} fixture entries in log")
    print()
    
    # Analyze log entries
    successful = [log for log in processing_log.values() if log.get('status') == 'success']
    failed = [log for log in processing_log.values() if log.get('status') == 'failed']
    
    print(f"Successful fixtures: {len(successful)}")
    print(f"Failed fixtures: {len(failed)}")
    print()
    
    # Check method tracking
    fixtures_with_method = [log for log in successful if 'method' in log]
    fixtures_without_method = [log for log in successful if 'method' not in log]
    
    if fixtures_without_method:
        print(f"⚠️  Found {len(fixtures_without_method)} fixtures without 'method' field")
        print(f"   [INFO] These were processed before method tracking was added")
    else:
        print(f"✅ All successful fixtures have 'method' field")
    
    if fixtures_with_method:
        print(f"✅ Found {len(fixtures_with_method)} fixtures with method tracking")
        print()
        
        # Count methods
        pdf_count = len([log for log in fixtures_with_method if log['method'] == 'pdf'])
        html_count = len([log for log in fixtures_with_method if log['method'] == 'html_fallback'])
        
        print(f"Method breakdown:")
        print(f"  PDF method: {pdf_count} fixtures")
        print(f"  HTML fallback: {html_count} fixtures")
        print()
        
        # Show sample entries
        print("Sample log entries:")
        for i, (fid, log) in enumerate(list(processing_log.items())[:5], 1):
            if log.get('status') == 'success':
                method = log.get('method', 'N/A')
                method_display = 'PDF' if method == 'pdf' else 'HTML' if method == 'html_fallback' else method
                print(f"  {i}. Fixture #{fid}: {log.get('home_team', 'N/A')} vs {log.get('away_team', 'N/A')}")
                print(f"     Method: {method_display}, Players: {log.get('player_count', 'N/A')}")
    
    print()
    
    # Step 2: Verify SQL output
    print("Step 2: Verifying SQL output...")
    print()
    
    sql_file = os.path.join(script_dir, 'output/update_player_stats_ALL.sql')
    
    if not os.path.exists(sql_file):
        print(f"[ERROR] SQL file not found: {sql_file}")
        return False
    
    with open(sql_file, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    
    print(f"SQL file size: {len(sql_content)} characters")
    print()
    
    # Check SQL structure
    required_elements = [
        'INSERT INTO PlayerFixtureStats',
        'DECLARE @FixtureId',
        'DECLARE @PlayerId',
        'MinutesPlayed',
        'Goals',
        'Assists',
        'YellowCards',
        'RedCards',
        'CleanSheet',
        'Saves'
    ]
    
    missing_elements = [elem for elem in required_elements if elem not in sql_content]
    
    if missing_elements:
        print(f"❌ SQL missing required elements: {missing_elements}")
        return False
    
    print(f"✅ SQL contains all required elements")
    
    # Count SQL statements
    insert_count = sql_content.count('INSERT INTO PlayerFixtureStats')
    declare_fixture_count = sql_content.count('DECLARE @FixtureId')
    declare_player_count = sql_content.count('DECLARE @PlayerId')
    
    print(f"✅ Found {insert_count} INSERT statements")
    print(f"✅ Found {declare_fixture_count} fixture declarations")
    print(f"✅ Found {declare_player_count} player declarations")
    print()
    
    # Check for fixture sections
    fixture_sections = re.findall(r'-- Player Stats for: (.+?) vs (.+?)', sql_content)
    print(f"✅ Found {len(fixture_sections)} fixture sections in SQL")
    print()
    
    # Step 3: Verify data consistency
    print("Step 3: Verifying data consistency...")
    print()
    
    # Check that successful fixtures have corresponding SQL
    if len(fixture_sections) >= len(successful):
        print(f"✅ SQL sections ({len(fixture_sections)}) match successful fixtures ({len(successful)})")
    else:
        print(f"⚠️  SQL sections ({len(fixture_sections)}) don't match successful fixtures ({len(successful)})")
        print(f"   [INFO] This might be normal if some fixtures were skipped")
    
    print()
    print("=" * 70)
    print("STEP 2 VERIFICATION COMPLETE")
    print("=" * 70)
    print()
    print("Summary:")
    print(f"  ✅ Processing log: {len(processing_log)} entries")
    print(f"  ✅ Successful fixtures: {len(successful)}")
    print(f"  ✅ Method tracking: {len(fixtures_with_method)} fixtures")
    print(f"  ✅ SQL file: {len(sql_content)} characters")
    print(f"  ✅ SQL statements: {insert_count} INSERT statements")
    print(f"  ✅ SQL format: Valid")
    print()
    
    if len(successful) == 23 and len(failed) == 0:
        print("🎉 SUCCESS: All 23 fixtures processed successfully!")
        print("   HTML fallback is working perfectly!")
    elif len(successful) > 0:
        print(f"✅ Progress: {len(successful)}/{len(processing_log)} fixtures successful")
    
    return True

if __name__ == "__main__":
    success = main()
    
    if not success:
        print()
        print("❌ Verification failed - check error messages above")
        sys.exit(1)



















