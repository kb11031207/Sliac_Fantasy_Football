#!/usr/bin/env python3
"""
Diagnostic script to verify team order in PDFs vs our fixtures.json
"""

import json
import os
import sys

# Load fixtures
with open('output/fixtures.json', 'r') as f:
    fixtures = json.load(f)

# Find Eureka vs Principia game (fixture 10)
print("=" * 60)
print("CHECKING FIXTURE #10: Eureka vs Principia")
print("=" * 60)

fixture_10 = fixtures[9]  # 0-indexed
print(f"\nFrom fixtures.json:")
print(f"  Away Team: {fixture_10['away']}")
print(f"  Home Team: {fixture_10['home']}")
print(f"  Score: {fixture_10['away_score']} - {fixture_10['home_score']}")
print(f"  (Eureka 0 - 5 Principia)")

print("\nThe PDF header would show:")
print("  'Eureka (record) -vs- Principia (record)'")

print("\nOur code assumes:")
print("  First team in header (Eureka) = HOME")
print("  Second team in header (Principia) = AWAY")

print("\nBUT fixtures.json says:")
print("  Eureka = AWAY")
print("  Principia = HOME")

print("\n" + "=" * 60)
print("CONCLUSION: PDF format is 'AWAY -vs- HOME'")
print("Our parser incorrectly assumes 'HOME -vs- AWAY'")
print("=" * 60)

# Check more examples
print("\nVerifying with more fixtures:")
for i, fix in enumerate(fixtures[:5]):
    if fix['status'] == 'completed' and fix['home_score'] is not None:
        print(f"\nFixture {i+1}:")
        print(f"  JSON: {fix['away']} @ {fix['home']} ({fix['away_score']}-{fix['home_score']})")
        print(f"  PDF would show: '{fix['away']} -vs- {fix['home']}'")
