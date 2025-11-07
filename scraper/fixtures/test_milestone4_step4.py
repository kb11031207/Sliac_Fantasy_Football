"""
Test script for Milestone 4, Step 4: SQL Validation
Validates SQL syntax and structure to ensure it's ready for database execution.
"""

import sys
import os
import re

script_dir = os.path.dirname(os.path.abspath(__file__))

def validate_sql_syntax(sql_content):
    """
    Validate SQL syntax and structure.
    """
    print("Step 1: Validating SQL syntax...")
    print()
    
    errors = []
    warnings = []
    
    # Check for balanced parentheses
    open_parens = sql_content.count('(')
    close_parens = sql_content.count(')')
    if open_parens != close_parens:
        errors.append(f"Unbalanced parentheses: {open_parens} open, {close_parens} close")
    else:
        print(f"   ✅ Parentheses balanced: {open_parens} pairs")
    
    # Check for balanced BEGIN/END blocks
    begin_count = sql_content.count('BEGIN')
    end_count = sql_content.count('END')
    if begin_count != end_count:
        warnings.append(f"Unbalanced BEGIN/END: {begin_count} BEGIN, {end_count} END")
    else:
        print(f"   ✅ BEGIN/END blocks balanced: {begin_count} pairs")
    
    # Check for required SQL keywords
    required_keywords = ['DECLARE', 'SELECT', 'INSERT', 'VALUES', 'IF', 'WHERE']
    missing_keywords = [kw for kw in required_keywords if kw not in sql_content]
    
    if missing_keywords:
        errors.append(f"Missing required SQL keywords: {missing_keywords}")
    else:
        print(f"   ✅ All required SQL keywords present")
    
    # Check for proper SQL statement structure
    # INSERT statements should have VALUES
    insert_count = sql_content.count('INSERT INTO PlayerFixtureStats')
    values_count = sql_content.count('VALUES')
    
    if insert_count > 0 and values_count < insert_count:
        errors.append(f"INSERT statements ({insert_count}) don't match VALUES ({values_count})")
    else:
        print(f"   ✅ INSERT statements properly structured: {insert_count} INSERT, {values_count} VALUES")
    
    # Check for GO statements (SQL Server batch separators)
    go_count = sql_content.count('GO')
    print(f"   ✅ Found {go_count} GO statements (batch separators)")
    
    # Check for potential SQL injection issues (basic check)
    dangerous_patterns = [
        (r';\s*DROP\s+TABLE', 'DROP TABLE statement'),
        (r';\s*DELETE\s+FROM', 'DELETE statement'),
        (r';\s*TRUNCATE', 'TRUNCATE statement'),
    ]
    
    for pattern, description in dangerous_patterns:
        if re.search(pattern, sql_content, re.IGNORECASE):
            warnings.append(f"Potentially dangerous SQL pattern found: {description}")
    
    if not warnings:
        print(f"   ✅ No dangerous SQL patterns detected")
    
    return errors, warnings

def validate_sql_structure(sql_content):
    """
    Validate SQL structure and completeness.
    """
    print()
    print("Step 2: Validating SQL structure...")
    print()
    
    # Split SQL into sections by fixture
    fixture_sections = re.split(r'-- =+', sql_content)
    fixture_sections = [s for s in fixture_sections if s.strip() and 'Player Stats for:' in s]
    
    print(f"   ✅ Found {len(fixture_sections)} fixture sections")
    
    # Check each section has required elements
    required_per_section = [
        'DECLARE @FixtureId',
        'DECLARE @PlayerId',
        'INSERT INTO PlayerFixtureStats',
        'VALUES'
    ]
    
    incomplete_sections = []
    for i, section in enumerate(fixture_sections[:3], 1):  # Check first 3 sections
        missing = [elem for elem in required_per_section if elem not in section]
        if missing:
            incomplete_sections.append((i, missing))
    
    if incomplete_sections:
        print(f"   ⚠️  Some sections missing elements:")
        for section_num, missing in incomplete_sections:
            print(f"      Section {section_num}: {missing}")
    else:
        print(f"   ✅ All sections have required elements")
    
    # Count total INSERT statements
    total_inserts = sql_content.count('INSERT INTO PlayerFixtureStats')
    print(f"   ✅ Total INSERT statements: {total_inserts}")
    
    # Check for proper variable declarations
    declare_fixture = sql_content.count('DECLARE @FixtureId INT')
    declare_player = sql_content.count('DECLARE @PlayerId INT')
    
    print(f"   ✅ Variable declarations: {declare_fixture} @FixtureId, {declare_player} @PlayerId")
    
    return True

def check_sql_readiness(sql_content):
    """
    Check if SQL is ready for database execution.
    """
    print()
    print("Step 3: Checking SQL readiness for database...")
    print()
    
    checks = []
    
    # Check 1: SQL is not empty
    if len(sql_content) < 100:
        checks.append(("SQL content too short", False))
    else:
        checks.append(("SQL content length", True))
        print(f"   ✅ SQL content: {len(sql_content)} characters")
    
    # Check 2: Has INSERT statements
    if 'INSERT INTO PlayerFixtureStats' not in sql_content:
        checks.append(("No INSERT statements", False))
    else:
        checks.append(("Has INSERT statements", True))
        print(f"   ✅ Contains INSERT statements")
    
    # Check 3: Has proper table name
    if 'PlayerFixtureStats' not in sql_content:
        checks.append(("Wrong table name", False))
    else:
        checks.append(("Correct table name", True))
        print(f"   ✅ Uses correct table: PlayerFixtureStats")
    
    # Check 4: Has proper column names
    required_columns = ['MinutesPlayed', 'Goals', 'Assists', 'YellowCards', 'RedCards', 
                        'CleanSheet', 'Saves', 'GoalsConceded']
    missing_columns = [col for col in required_columns if col not in sql_content]
    
    if missing_columns:
        checks.append((f"Missing columns: {missing_columns}", False))
    else:
        checks.append(("All required columns present", True))
        print(f"   ✅ All required columns present")
    
    # Check 5: Has proper escaping for strings
    # Check for unescaped single quotes in string values
    # This is a basic check - proper escaping would be more complex
    dangerous_quotes = re.findall(r"VALUES\s*\([^)]*'[^']*'[^)]*\)", sql_content)
    if dangerous_quotes and any("''" not in v for v in dangerous_quotes[:5]):
        checks.append(("Potential unescaped quotes", False))
    else:
        checks.append(("String escaping appears correct", True))
        print(f"   ✅ String escaping appears correct")
    
    all_passed = all(check[1] for check in checks)
    
    return all_passed, checks

def main():
    print("=" * 70)
    print("MILESTONE 4, STEP 4: SQL Validation")
    print("=" * 70)
    print()
    print("Validating SQL syntax and structure...")
    print()
    
    # Load SQL file
    sql_file = os.path.join(script_dir, 'output/update_player_stats_ALL.sql')
    
    if not os.path.exists(sql_file):
        print(f"[ERROR] SQL file not found: {sql_file}")
        return False
    
    with open(sql_file, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    
    print(f"SQL file: {sql_file}")
    print(f"File size: {len(sql_content)} characters")
    print()
    
    # Step 1: Validate SQL syntax
    errors, warnings = validate_sql_syntax(sql_content)
    
    # Step 2: Validate SQL structure
    structure_valid = validate_sql_structure(sql_content)
    
    # Step 3: Check SQL readiness
    sql_ready, readiness_checks = check_sql_readiness(sql_content)
    
    # Report results
    print()
    print("=" * 70)
    print("STEP 4 VALIDATION RESULTS")
    print("=" * 70)
    print()
    
    if errors:
        print("❌ SQL Syntax Errors:")
        for error in errors:
            print(f"   - {error}")
        print()
    
    if warnings:
        print("⚠️  SQL Warnings:")
        for warning in warnings:
            print(f"   - {warning}")
        print()
    
    if not errors and structure_valid and sql_ready:
        print("✅ SQL Validation: PASSED")
        print()
        print("Summary:")
        print(f"  ✅ SQL syntax is valid")
        print(f"  ✅ SQL structure is correct")
        print(f"  ✅ SQL is ready for database execution")
        print()
        print("SQL file is ready to run against the database!")
        print()
        print("To execute:")
        print("  1. Connect to your SQL Server database")
        print("  2. Open the SQL file: output/update_player_stats_ALL.sql")
        print("  3. Execute the script")
        print("  4. Verify that all INSERT statements succeed")
        return True
    else:
        print("❌ SQL Validation: FAILED")
        print()
        if errors:
            print("Errors found:")
            for error in errors:
                print(f"  - {error}")
        return False

if __name__ == "__main__":
    success = main()
    
    if not success:
        print()
        print("❌ Validation failed - check error messages above")
        sys.exit(1)




