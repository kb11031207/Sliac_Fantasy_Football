#!/usr/bin/env python3
"""
Quick diagnostic script to check failed fixtures
"""

import json
import requests
from bs4 import BeautifulSoup

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'keep-alive',
}

def check_fixture(fixture_id, box_score_url):
    """
    Check what's actually wrong with a fixture
    """
    print(f"\n{'='*70}")
    print(f"Fixture #{fixture_id}")
    print(f"URL: {box_score_url}")
    print(f"{'='*70}")
    
    try:
        # Try to fetch the page
        response = requests.get(box_score_url, headers=HEADERS, timeout=15)
        response.raise_for_status()
        
        print(f"✅ HTML loaded successfully ({len(response.content)} bytes)")
        
        # Check for PDF link
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Look for print-bar div
        print_bar = soup.find('div', id='print-bar')
        if print_bar:
            print("✅ Found print-bar div")
            
            # Look for PDF link
            pdf_link = print_bar.find('a', href=lambda h: h and 'document.aspx' in h)
            if pdf_link:
                print("✅ Found PDF link!")
                print(f"   Link: {pdf_link.get('href')[:80]}...")
            else:
                print("❌ No PDF link found in print-bar")
                print("   Available links:")
                for link in print_bar.find_all('a'):
                    print(f"   - {link.get('href', 'NO HREF')[:80]}")
        else:
            print("❌ No print-bar div found")
            print("   This page probably doesn't have PDF box scores")
            
            # Check if there's any stats content at all
            if "Box Score" in response.text or "Statistics" in response.text:
                print("   ℹ️  Page has some stats content (HTML only?)")
            else:
                print("   ⚠️  Page might not have any stats")
        
    except requests.exceptions.Timeout:
        print("❌ Request timed out (network issue)")
    except requests.exceptions.HTTPError as e:
        print(f"❌ HTTP Error: {e.response.status_code}")
    except Exception as e:
        print(f"❌ Error: {e}")

def main():
    print("="*70)
    print("SLIAC Failed Fixtures Diagnostic Tool")
    print("="*70)
    
    # Load fixtures
    with open('scraper/fixtures/output/fixtures.json', 'r') as f:
        fixtures = json.load(f)
    
    # Load processing log
    with open('scraper/fixtures/output/processing_log.json', 'r') as f:
        log = json.load(f)
    
    # Find failed fixtures
    failed_ids = [fid for fid, entry in log.items() if entry['status'] == 'failed']
    
    print(f"\nFound {len(failed_ids)} failed fixtures. Checking each one...\n")
    
    for fid in failed_ids:
        fixture = fixtures[int(fid) - 1]
        check_fixture(fid, fixture['box_score_url'])
        
        # Ask if user wants to continue
        if int(fid) < int(failed_ids[-1]):
            response = input("\nPress Enter to check next, or 'q' to quit: ")
            if response.lower() == 'q':
                break
    
    print("\n" + "="*70)
    print("✅ Diagnostic complete!")
    print("="*70)

if __name__ == "__main__":
    main()


