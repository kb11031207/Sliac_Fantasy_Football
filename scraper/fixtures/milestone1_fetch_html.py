"""
Milestone 1: Research & Test HTML Structure
Fetches HTML from a failed fixture and saves it for inspection

Usage:
    python scraper/fixtures/milestone1_fetch_html.py
"""

import requests
from bs4 import BeautifulSoup
import json
import os
from datetime import datetime

# Base URL
BASE_URL = 'https://sliac.org'

# Browser headers to avoid 404
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'keep-alive',
}

def fetch_and_analyze_html(box_score_url, fixture_id, fixture_info):
    """
    Fetch HTML from box score page and save for analysis
    
    Args:
        box_score_url: URL to the box score page
        fixture_id: Fixture ID for naming
        fixture_info: Dict with home/away teams for logging
    """
    print("=" * 70)
    print(f"MILESTONE 1: HTML Structure Research")
    print("=" * 70)
    print(f"\nFixture #{fixture_id}: {fixture_info['home']} vs {fixture_info['away']}")
    print(f"URL: {box_score_url}")
    print(f"\nFetching HTML...")
    
    try:
        response = requests.get(box_score_url, headers=HEADERS, timeout=30)
        response.raise_for_status()
        print(f"   [OK] HTTP {response.status_code}")
        print(f"   [OK] Content length: {len(response.content)} bytes")
    except requests.exceptions.RequestException as e:
        print(f"   [ERROR] Failed to fetch: {e}")
        return None
    
    # Parse with BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Basic analysis
    print(f"\n📊 HTML Analysis:")
    print(f"   - Total HTML size: {len(response.content)} bytes")
    print(f"   - Title: {soup.title.string if soup.title else 'N/A'}")
    
    # Check for print-bar (PDF link indicator)
    print_bar = soup.find('div', id='print-bar')
    if print_bar:
        print(f"   - Print-bar div: ✅ FOUND")
    else:
        print(f"   - Print-bar div: ❌ NOT FOUND (this is why PDF extraction fails)")
    
    # Look for stats tables
    print(f"\n📋 Looking for stats tables...")
    
    # Common table classes used by Sidearm (SLIAC's platform)
    table_selectors = [
        ('sidearm-table', 'class'),
        ('table', 'tag'),
        ('stats-table', 'class'),
        ('player-stats', 'class'),
    ]
    
    tables_found = []
    for selector, selector_type in table_selectors:
        if selector_type == 'class':
            tables = soup.find_all('table', class_=lambda x: x and selector in ' '.join(x) if isinstance(x, list) else selector in str(x))
        else:
            tables = soup.find_all('table')
        
        if tables:
            tables_found.append((selector, len(tables)))
            print(f"   - Found {len(tables)} table(s) with '{selector}'")
    
    # Look for specific stat-related elements
    print(f"\n🔍 Looking for stat-related content...")
    
    # Check for player names, jersey numbers, stats
    text_content = soup.get_text()
    
    # Look for common stat keywords
    stat_keywords = ['Goals', 'Assists', 'Shots', 'Saves', 'Minutes', 'Yellow Card', 'Red Card']
    found_keywords = [kw for kw in stat_keywords if kw.lower() in text_content.lower()]
    print(f"   - Stat keywords found: {', '.join(found_keywords) if found_keywords else 'None'}")
    
    # Look for team names
    home_team = fixture_info.get('home', '')
    away_team = fixture_info.get('away', '')
    if home_team in text_content or away_team in text_content:
        print(f"   - Team names: ✅ Found in HTML")
    else:
        print(f"   - Team names: ⚠️  Not clearly found")
    
    # Save HTML to file
    output_dir = 'output'
    os.makedirs(output_dir, exist_ok=True)
    
    html_file = os.path.join(output_dir, f'fixture_{fixture_id}_html_debug.html')
    with open(html_file, 'w', encoding='utf-8') as f:
        f.write(response.text)
    print(f"\n💾 Saved HTML to: {html_file}")
    
    # Save prettified HTML (easier to read)
    prettified_file = os.path.join(output_dir, f'fixture_{fixture_id}_html_prettified.html')
    with open(prettified_file, 'w', encoding='utf-8') as f:
        f.write(soup.prettify())
    print(f"💾 Saved prettified HTML to: {prettified_file}")
    
    # Extract and save just the table structures
    tables_file = os.path.join(output_dir, f'fixture_{fixture_id}_tables_only.html')
    with open(tables_file, 'w', encoding='utf-8') as f:
        f.write('<!DOCTYPE html>\n<html><head><title>Tables Only</title></head><body>\n')
        f.write(f'<h1>Fixture #{fixture_id}: {home_team} vs {away_team}</h1>\n')
        all_tables = soup.find_all('table')
        for i, table in enumerate(all_tables):
            f.write(f'<h2>Table {i+1}</h2>\n')
            f.write(str(table))
            f.write('\n<hr>\n')
        f.write('</body></html>')
    print(f"💾 Saved tables-only HTML to: {tables_file}")
    
    # Create a summary JSON
    summary = {
        'fixture_id': fixture_id,
        'home_team': home_team,
        'away_team': away_team,
        'box_score_url': box_score_url,
        'fetch_timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'html_size_bytes': len(response.content),
        'has_print_bar': print_bar is not None,
        'tables_found': len(soup.find_all('table')),
        'stat_keywords_found': found_keywords,
        'files_saved': {
            'raw_html': html_file,
            'prettified_html': prettified_file,
            'tables_only': tables_file
        }
    }
    
    summary_file = os.path.join(output_dir, f'fixture_{fixture_id}_analysis.json')
    with open(summary_file, 'w', encoding='utf-8') as f:
        json.dump(summary, f, indent=2)
    print(f"💾 Saved analysis summary to: {summary_file}")
    
    print(f"\n✅ Analysis complete!")
    print(f"\n📝 Next steps:")
    print(f"   1. Open {prettified_file} in a browser to inspect structure")
    print(f"   2. Check {tables_file} to see all tables")
    print(f"   3. Review {summary_file} for quick reference")
    
    return summary

def main():
    # Load fixtures to get the failed one
    fixtures_file = 'output/fixtures.json'
    if not os.path.exists(fixtures_file):
        print(f"[ERROR] Fixtures file not found: {fixtures_file}")
        print("   Please run from scraper/fixtures/ directory")
        return
    
    with open(fixtures_file, 'r', encoding='utf-8') as f:
        fixtures = json.load(f)
    
    # Fixture #2: Blackburn vs Greenville (failed fixture)
    fixture_id = 2
    fixture = fixtures[fixture_id - 1]  # 0-indexed
    
    if not fixture.get('box_score_url'):
        print(f"[ERROR] Fixture #{fixture_id} has no box_score_url")
        return
    
    box_score_url = fixture['box_score_url']
    fixture_info = {
        'home': fixture['home'],
        'away': fixture['away'],
        'date': fixture.get('date', ''),
    }
    
    summary = fetch_and_analyze_html(box_score_url, fixture_id, fixture_info)
    
    if summary:
        print(f"\n" + "=" * 70)
        print("MILESTONE 1 COMPLETE!")
        print("=" * 70)
        print(f"\n📋 Findings:")
        print(f"   - HTML successfully fetched: ✅")
        print(f"   - Print-bar present: {'✅' if summary['has_print_bar'] else '❌'}")
        print(f"   - Tables found: {summary['tables_found']}")
        print(f"   - Stat keywords: {len(summary['stat_keywords_found'])} found")
        print(f"\n💡 Review the saved HTML files to identify table structure!")

if __name__ == "__main__":
    main()




