"""
Test script for Milestone 4, Step 1: Test HTML Fallback on Failed Fixtures
Runs the scraper on previously failed fixtures to verify HTML fallback works.
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
process_all_fixtures_from_json = module.process_all_fixtures_from_json

def main():
    print("=" * 70)
    print("MILESTONE 4, STEP 1: Test HTML Fallback on Failed Fixtures")
    print("=" * 70)
    print()
    
    # Load processing log to find failed fixtures
    log_file = os.path.join(script_dir, 'output/processing_log.json')
    
    if not os.path.exists(log_file):
        print(f"[INFO] Processing log not found: {log_file}")
        print(f"[INFO] This means no fixtures have been processed yet")
        print()
        print("Running scraper on all fixtures (will test HTML fallback)...")
    else:
        with open(log_file, 'r', encoding='utf-8') as f:
            processing_log = json.load(f)
        
        # Find failed fixtures
        failed_fixtures = [fid for fid, log in processing_log.items() 
                          if log.get('status') == 'failed']
        
        print(f"Found {len(failed_fixtures)} previously failed fixtures")
        print(f"Failed fixture IDs: {', '.join(failed_fixtures)}")
        print()
        print("Running scraper to retry failed fixtures with HTML fallback...")
        print("(This will process all fixtures, but focus on the failed ones)")
        print()
    
    # Run the scraper
    # By default, it will skip already successful fixtures and retry failed ones
    print("=" * 70)
    print("RUNNING SCRAPER...")
    print("=" * 70)
    print()
    
    try:
        process_all_fixtures_from_json(retry_failed=False)
    except KeyboardInterrupt:
        print("\n[INFO] Scraper interrupted by user")
        return
    except Exception as e:
        print(f"\n[ERROR] Scraper failed: {e}")
        import traceback
        traceback.print_exc()
        return
    
    print()
    print("=" * 70)
    print("STEP 1 VERIFICATION")
    print("=" * 70)
    print()
    
    # Check results
    if os.path.exists(log_file):
        with open(log_file, 'r', encoding='utf-8') as f:
            processing_log = json.load(f)
        
        successful = [log for log in processing_log.values() if log.get('status') == 'success']
        failed = [log for log in processing_log.values() if log.get('status') == 'failed']
        
        print(f"Results:")
        print(f"  Successful: {len(successful)}")
        print(f"  Failed: {len(failed)}")
        print()
        
        # Check for HTML fallback usage
        html_fallback_count = len([log for log in successful 
                                   if log.get('method') == 'html_fallback'])
        pdf_count = len([log for log in successful 
                        if log.get('method') == 'pdf'])
        
        if html_fallback_count > 0:
            print(f"✅ HTML fallback was used: {html_fallback_count} fixtures")
            print(f"   PDF method: {pdf_count} fixtures")
            print()
            print("✅ Step 1 Complete: HTML fallback is working!")
        else:
            print(f"⚠️  No HTML fallback usage detected")
            print(f"   This could mean:")
            print(f"     - All fixtures successfully used PDF method")
            print(f"     - Or HTML fallback wasn't needed")
        
        if failed:
            print()
            print(f"⚠️  Still have {len(failed)} failed fixtures:")
            for fid, log in processing_log.items():
                if log.get('status') == 'failed':
                    print(f"   Fixture #{fid}: {log.get('reason', 'Unknown error')}")

if __name__ == "__main__":
    main()




