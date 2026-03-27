# SLIAC Fixtures Scraper

Simple, clean fixture management for your fantasy football database.

## Overview

Two scripts, one purpose: Keep your fixtures up-to-date without the headache.

### Script 1: `1_setup_fixtures.py` (Run ONCE)
**Purpose**: Initial database setup  
**What it does**:
- Creates 6 gameweeks
- Inserts all 40 fixtures (completed + future)
- Sets everything to "not finished" initially

**When to run**: Once at the start, before anything else

### Script 2: `2_update_results.py` (Run ANYTIME)
**Purpose**: Update scores as games are played  
**What it does**:
- Checks for completed games
- Updates scores (HomeScore, AwayScore)
- Marks fixtures as finished (IsFinished=1)

**When to run**: 
- After each gameweek
- Daily during the season
- Whenever you want fresh results

---

## Quick Start

### Step 1: Install requirements
```bash
cd scraper/fixtures
pip install -r requirements.txt
```

### Step 2: Run setup (ONCE)
```bash
python 1_setup_fixtures.py
```
This creates `output/setup_fixtures.sql`

### Step 3: Load fixtures into database
Run the generated SQL file in SQL Server Management Studio

### Step 4: Update results (ANYTIME)
```bash
python 2_update_results.py
```
This creates `output/update_results.sql`

Run this SQL file to update scores

---

## File Structure

```
scraper/fixtures/
├── 1_setup_fixtures.py          # Initial setup script
├── 2_update_results.py           # Results updater script
├── requirements.txt              # Python dependencies
├── README.md                     # This file
└── output/
    ├── fixtures.json             # Raw fixture data (already scraped)
    ├── setup_fixtures.sql        # Generated setup SQL
    ├── update_results.sql        # Generated update SQL
    └── debug_stats.html          # Stats page for debugging
```

---

## How It Works

### The Flow:
1. **Setup** (once): Creates gameweeks + fixtures → All games marked "not finished"
2. **Update** (ongoing): Checks for completed games → Updates scores + marks finished
3. **Repeat** step 2 as often as you want

### Database Updates:
- **Setup**: Inserts new rows (Gameweeks + Fixtures)
- **Update**: Updates existing rows (scores + status)

### Safety:
- Running update multiple times = safe (just updates same fixtures)
- Running setup multiple times = will create duplicates (don't do it!)

---

## Example Workflow

```
Week 0: python 1_setup_fixtures.py → Load fixtures
Week 1: Games played...
        python 2_update_results.py → 10 games updated
Week 2: More games played...
        python 2_update_results.py → 15 games updated
Week 3: python 2_update_results.py → 20 games updated
... and so on
```

---

## Data Source

- **Calendar Page**: https://sliac.org/calendar.aspx?path=msoc (future fixtures)
- **Stats Page**: https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true (completed games)

The fixture data was already scraped and is stored in `output/fixtures.json`.

---

## Future Enhancements

Want live scraping from the stats page? Check `output/debug_stats.html` to see the page structure, then enhance `2_update_results.py` to parse it directly.

For now, the scripts work with the already-scraped fixture data, which is good enough to get started!

---

## Questions?

- **"Can I run the update script multiple times?"** → Yes, it's safe
- **"Will it add duplicate fixtures?"** → No, it only updates existing ones
- **"Do I need to run setup again?"** → No, only once
- **"How often should I update?"** → Whenever you want - daily, weekly, or after each gameweek

---

**That's it! Simple, clean, maintainable.** 🚀
