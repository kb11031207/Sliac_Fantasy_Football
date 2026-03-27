"""
Test different SLIAC URLs to find the right one
"""

import requests

urls_to_try = [
    'https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true',
    'https://sliac.org/stats.aspx?path=msoc&conf=true',
    'https://sliac.org/stats.aspx?path=msoc',
    'https://sliac.org/calendar.aspx?path=msoc',
    'https://sliac.org/standings.aspx?standings=msoc',
]

print("Testing SLIAC URLs...")
print("=" * 70)

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1'
}

for url in urls_to_try:
    try:
        response = requests.get(url, headers=headers, timeout=10)
        print(f"\n✅ {response.status_code} - {url}")
        if response.status_code == 200:
            print(f"   Content length: {len(response.content)} bytes")
            # Check if it's a JavaScript redirect or real content
            if b'<html' in response.content.lower():
                print(f"   ✓ Contains HTML content")
    except requests.exceptions.RequestException as e:
        print(f"\n❌ FAILED - {url}")
        print(f"   Error: {e}")

print("\n" + "=" * 70)

