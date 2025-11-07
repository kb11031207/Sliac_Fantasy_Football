"""
Test script for Milestone 3, Step 3: Logging Verification
Tests that the processing log correctly tracks which method was used (PDF vs HTML fallback).
"""

import sys
import os
import json

script_dir = os.path.dirname(os.path.abspath(__file__))

def main():
    print("=" * 70)
    print("MILESTONE 3, STEP 3: Logging Verification")
    print("=" * 70)
    print()
    
    # Check processing log
    log_file = os.path.join(script_dir, 'output/processing_log.json')
    
    if not os.path.exists(log_file):
        print(f"[INFO] Processing log not found: {log_file}")
        print(f"[INFO] This is expected if the scraper hasn't been run yet")
        print()
        print("To test logging:")
        print("  1. Run the scraper: python 3_update_player_stats.py")
        print("  2. Check the processing log for 'method' field")
        return
    
    print(f"Loading processing log: {log_file}")
    print()
    
    with open(log_file, 'r', encoding='utf-8') as f:
        processing_log = json.load(f)
    
    print(f"Found {len(processing_log)} fixture entries in log")
    print()
    
    # Analyze logging
    successful = [log for log in processing_log.values() if log.get('status') == 'success']
    failed = [log for log in processing_log.values() if log.get('status') == 'failed']
    
    print(f"Successful fixtures: {len(successful)}")
    print(f"Failed fixtures: {len(failed)}")
    print()
    
    # Check method tracking
    print("Step 1: Checking method tracking...")
    fixtures_with_method = [log for log in successful if 'method' in log]
    fixtures_without_method = [log for log in successful if 'method' not in log]
    
    if fixtures_without_method:
        print(f"   ⚠️  Found {len(fixtures_without_method)} successful fixtures without 'method' field")
        print(f"   [INFO] These were likely processed before method tracking was added")
    else:
        print(f"   ✅ All successful fixtures have 'method' field")
    
    if fixtures_with_method:
        print(f"   ✅ Found {len(fixtures_with_method)} fixtures with method tracking")
        print()
        
        # Count methods
        pdf_count = len([log for log in fixtures_with_method if log['method'] == 'pdf'])
        html_count = len([log for log in fixtures_with_method if log['method'] == 'html_fallback'])
        
        print(f"Step 2: Method statistics:")
        print(f"   PDF method: {pdf_count} fixtures")
        print(f"   HTML fallback: {html_count} fixtures")
        print()
        
        # Show examples
        print("Step 3: Sample entries...")
        pdf_examples = [log for log in fixtures_with_method if log['method'] == 'pdf'][:2]
        html_examples = [log for log in fixtures_with_method if log['method'] == 'html_fallback'][:2]
        
        if pdf_examples:
            print(f"\n   PDF method examples:")
            for i, log in enumerate(pdf_examples, 1):
                print(f"     {i}. {log.get('home_team', 'N/A')} vs {log.get('away_team', 'N/A')}")
                print(f"        Method: {log['method']}, Players: {log.get('player_count', 'N/A')}")
        
        if html_examples:
            print(f"\n   HTML fallback examples:")
            for i, log in enumerate(html_examples, 1):
                print(f"     {i}. {log.get('home_team', 'N/A')} vs {log.get('away_team', 'N/A')}")
                print(f"        Method: {log['method']}, Players: {log.get('player_count', 'N/A')}")
        else:
            print(f"\n   ⚠️  No HTML fallback examples found")
            print(f"   [INFO] This means either:")
            print(f"     - No fixtures have been processed with HTML fallback yet")
            print(f"     - All fixtures successfully used PDF method")
    
    print()
    print("=" * 70)
    print("STEP 3 VERIFICATION")
    print("=" * 70)
    print()
    
    if fixtures_with_method:
        print("✅ Method tracking is working correctly!")
        print(f"   - {len(fixtures_with_method)} fixtures tracked")
        print(f"   - PDF: {pdf_count}, HTML: {html_count}")
    else:
        print("⚠️  No fixtures with method tracking found")
        print("   - Run the scraper to generate new log entries")
        print("   - Method tracking will be added to new entries")
    
    print()
    print("To test with a failed fixture:")
    print("  1. Run: python 3_update_player_stats.py")
    print("  2. Check processing_log.json for 'method' field")
    print("  3. Failed fixtures should use 'html_fallback' method")

if __name__ == "__main__":
    main()




