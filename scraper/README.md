# SLIAC Fantasy Football Scrapers

This directory contains all web scrapers for extracting data from the SLIAC website to populate the fantasy football database.

## 📁 Structure

```
scraper/
├── teams/           # ✅ Conference teams scraper
│   ├── sliac_teams_scraper.py
│   ├── requirements.txt
│   └── output/
│       ├── conference_teams.json
│       └── conference_teams.sql
│
├── players/         # ✅ Player rosters scraper
│   ├── sliac_players_scraper.py
│   ├── ureka.html              # Manual save for Eureka (anti-scraping)
│   ├── blackburn.html          # Manual save for Blackburn (anti-scraping)
│   ├── requirements.txt
│   └── output/
│       ├── players.json
│       └── players.sql
│
├── fixtures/        # ✅ Fixtures, results, and player stats
│   ├── 1_setup_fixtures.py     # Run ONCE to populate Gameweeks + Fixtures
│   ├── 2_update_results.py     # Run REPEATEDLY to update scores
│   ├── 3_update_player_stats.py # ⏳ IN PROGRESS - Player performance
│   ├── requirements.txt
│   └── output/
│       ├── setup_fixtures.sql
│       ├── update_results.sql
│       ├── clear_fixtures.sql
│       ├── clear_all_fixtures_data.sql
│       └── pdfs/               # Downloaded box score PDFs
│
├── requirements.txt # Global requirements
└── README.md        # This file
```

## 🚀 Quick Start

### Install Dependencies
```bash
cd scraper
pip install -r requirements.txt
```

### Run All Scrapers (In Order)
```bash
# 1. Scrape conference teams
python teams/sliac_teams_scraper.py

# 2. Scrape player rosters
python players/sliac_players_scraper.py

# 3. Setup fixtures (run ONCE)
python fixtures/1_setup_fixtures.py

# 4. Update game results (run REPEATEDLY as games complete)
python fixtures/2_update_results.py

# 5. Update player stats (run after games to get individual stats)
python fixtures/3_update_player_stats.py  # ⏳ IN PROGRESS
```

---

## 📚 Scraper Details

## 1. Teams Scraper ✅

**Location:** `teams/sliac_teams_scraper.py`  
**Purpose:** Scrapes all 9 SLIAC conference teams  
**Output:** `conference_teams.sql` → `ConferenceTeams` table  

### What It Extracts:
- Team names
- Schools/Institutions
- Logo URLs

### Run:
```bash
python teams/sliac_teams_scraper.py
```

### Output:
- `output/conference_teams.json` - Data validation
- `output/conference_teams.sql` - Ready to execute

---

## 2. Players Scraper ✅

**Location:** `players/sliac_players_scraper.py`  
**Purpose:** Scrapes player rosters from all 9 SLIAC teams  
**Output:** `players.sql` → `Players` table  

### What It Extracts:
- Player names (formatted: "FirstName LastName")
- Jersey numbers
- Positions (GK, DEF, MID, FWD)
- Team affiliation
- Auto-generated costs (based on position)

### Special Handling:
Some team websites have anti-scraping measures. For these, manually save the roster page:
1. **Eureka College**: Save as `ureka.html`
2. **Blackburn College**: Save as `blackburn.html`

The scraper uses custom parsers for these files.

### Run:
```bash
python players/sliac_players_scraper.py
```

### Output:
- `output/players.json` - All player data (~200 players)
- `output/players.sql` - Ready to execute

---

## 3. Fixtures Scraper System ✅ (3 Scripts)

### Overview
The fixtures system is split into 3 separate scripts, each serving a distinct purpose:

| Script | When to Run | Purpose |
|--------|------------|---------|
| `1_setup_fixtures.py` | **ONCE** (start of season) | Create gameweeks and fixtures |
| `2_update_results.py` | **REPEATEDLY** (after games) | Update scores as games complete |
| `3_update_player_stats.py` | **REPEATEDLY** (after games) | ⏳ Extract individual player performance |

---

### 3a. Setup Fixtures (Run Once) ✅

**Location:** `fixtures/1_setup_fixtures.py`  
**Purpose:** One-time setup to populate `Gameweeks` and `Fixtures` tables  

#### What It Does:
1. Creates 6 gameweeks (Sept 27 - Nov 3, 2025)
2. Inserts all fixtures with:
   - GameweekId (1-6)
   - HomeTeamId, AwayTeamId
   - Kickoff time (default 3:00 PM)
   - BoxScoreUrl (for later stats extraction)

#### Run:
```bash
python fixtures/1_setup_fixtures.py
```

#### Output:
- `output/setup_fixtures.sql` - Populates `Gameweeks` + `Fixtures` tables

#### Database Schema:
```sql
-- Gameweeks
INSERT INTO Gameweeks (startTime, endTime, isComplete)
VALUES ('2025-09-27 00:00:00', '2025-09-30 23:59:59', 0);

-- Fixtures
INSERT INTO Fixtures (GameweekId, HomeTeamId, AwayTeamId, Kickoff, BoxScoreUrl)
SELECT 1, (SELECT Id FROM ConferenceTeams WHERE Team = 'Lyon'), 
          (SELECT Id FROM ConferenceTeams WHERE Team = 'Spalding'),
          '2025-09-27 15:00:00', 'https://sliac.org/boxscore.aspx?id=...';
```

---

### 3b. Update Results (Run Repeatedly) ✅

**Location:** `fixtures/2_update_results.py`  
**Purpose:** Live scraper to fetch completed game scores  

#### What It Does:
1. Scrapes **live results** from: https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true
2. Parses the "Overall Results" table for completed games
3. Updates `Fixtures` table with actual play dates (handles rescheduled games)
4. Inserts/updates scores in `FixtureResults` table

#### Key Features:
- **Rescheduled Game Handling**: Matches fixtures within a 7-day window
- **Home/Away Swap Detection**: Handles cases where teams are swapped in the stats page
- **Idempotent**: Safe to run multiple times (updates existing results)

#### Run:
```bash
python fixtures/2_update_results.py
```

#### Output:
- `output/update_results.sql` - Updates `Fixtures` + `FixtureResults` tables

#### SQL Example:
```sql
DECLARE @FixtureId INT;
-- Find fixture (with 7-day tolerance for rescheduled games)
SELECT @FixtureId = Id
FROM Fixtures
WHERE HomeTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = 'Lyon')
  AND AwayTeamId = (SELECT Id FROM ConferenceTeams WHERE Team = 'Spalding')
  AND ABS(DATEDIFF(day, CAST(Kickoff AS DATE), '2025-09-27')) <= 7;

-- Update kickoff date (preserve original time)
UPDATE Fixtures
SET Kickoff = CAST(CAST('2025-09-27' AS DATETIME) + CAST(CAST(Kickoff AS TIME) AS DATETIME) AS DATETIME)
WHERE Id = @FixtureId;

-- Insert result
INSERT INTO FixtureResults (FixtureId, HomeScore, AwayScore)
VALUES (@FixtureId, 2, 0);
GO
```

---

### 3c. Update Player Stats (In Progress) ⏳

**Location:** `fixtures/3_update_player_stats.py`  
**Purpose:** Extract individual player performance from box score PDFs  

#### What It Does (So Far):
1. ✅ Fetches box score HTML page
2. ✅ Extracts document viewer URL (`/document.aspx?...`)
3. ✅ Fetches document viewer page
4. ✅ Extracts S3 PDF URL (`https://s3.us-east-2.amazonaws.com/.../xxxxx.pdf`)
5. ✅ Downloads PDF from S3
6. ✅ Parses PDF text (handles two-column layout)
7. ✅ Extracts player stats: Name, Position, Jersey, Minutes, Goals, Assists, Shots, SOG

#### What's Left to Implement:
- ⏳ Yellow/Red card parsing
- ⏳ Goalkeeper-specific stats (Saves, Goals Conceded)
- ⏳ Clean sheet detection
- ⏳ Player name matching to database (fuzzy matching)
- ⏳ SQL generation for `PlayerFixtureStats` table
- ⏳ Loop through all fixtures (currently tests one game)

#### PDF Parsing Challenge:
Box score PDFs have a **two-column layout** (Away Team | Home Team side-by-side). The script:
1. Extracts text line-by-line
2. Detects position codes (GK, DEF, MID, FWD) to find column split point
3. Parses each column separately

#### Run:
```bash
python fixtures/3_update_player_stats.py  # Currently runs test on one game
```

#### Output (When Complete):
- `output/update_player_stats.sql` - Will populate `PlayerFixtureStats` table
- `output/pdfs/` - Downloaded box score PDFs for debugging

---

## 🗄️ Database Schema

### Tables Populated by Scrapers:

| Table | Scraper | Primary Data |
|-------|---------|--------------|
| `ConferenceTeams` | Teams | Team names, schools, logos |
| `Players` | Players | Player names, positions, jersey numbers, costs |
| `Gameweeks` | Fixtures (1) | Start/end times for each gameweek |
| `Fixtures` | Fixtures (1) | Match schedule, teams, kickoff times |
| `FixtureResults` | Fixtures (2) | Final scores (HomeScore, AwayScore) |
| `PlayerFixtureStats` | Fixtures (3) | ⏳ Individual player performance |

---

## 🌐 Data Sources

| Data Type | URL |
|-----------|-----|
| Conference Teams | https://sliac.org/sports/2023/7/11/GEN_0711232207.aspx |
| Team Rosters | https://[team-website]/sports/msoc/2025-26/roster/ |
| Fixture Results | https://sliac.org/stats.aspx?path=msoc&year=2025&conf=true |
| Box Scores (HTML) | https://sliac.org/boxscore.aspx?id=...&path=msoc |
| Box Scores (PDF) | S3: https://s3.us-east-2.amazonaws.com/sidearm.nextgen.sites/[school]/stats/msoc/2025/pdf/[timestamp].pdf |

---

## 🛠️ Technical Notes

### Anti-Scraping Measures
Some team websites (Eureka, Blackburn) return 403 Forbidden for automated requests. **Workaround:**
1. Manually open roster page in browser
2. Save as HTML file (`ureka.html`, `blackburn.html`)
3. Place in `players/` directory
4. Scraper uses custom parsers for these files

### Headers Required
Most SLIAC pages return 404 without proper browser headers:
```python
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
}
```

### PDF Download Process
Box score PDFs require a **two-step process**:
1. Box score page → Extract `/document.aspx?id=...` link
2. Document viewer page → Extract S3 PDF URL from "Open" button
3. Download PDF directly from S3

### SQL Batch Separation
When declaring SQL variables in loops, use `GO` statements to separate batches:
```sql
DECLARE @FixtureId INT;
-- ... use variable ...
GO  -- Allows @FixtureId to be redeclared in next iteration

DECLARE @FixtureId INT;
-- ... next iteration ...
GO
```

---

## 📝 Usage Workflow

### Initial Database Population (Run Once)
```bash
# 1. Teams
python teams/sliac_teams_scraper.py
# Execute: teams/output/conference_teams.sql

# 2. Players
python players/sliac_players_scraper.py
# Execute: players/output/players.sql

# 3. Fixtures
python fixtures/1_setup_fixtures.py
# Execute: fixtures/output/setup_fixtures.sql
```

### Weekly Updates (Run After Games)
```bash
# Update game scores
python fixtures/2_update_results.py
# Execute: fixtures/output/update_results.sql

# Update player stats (when complete)
python fixtures/3_update_player_stats.py
# Execute: fixtures/output/update_player_stats.sql
```

---

## 🧹 Cleanup Scripts

If you need to reset fixtures data:

### Clear Fixtures Only (Keep Gameweeks)
```sql
-- Execute: fixtures/output/clear_fixtures.sql
DELETE FROM PlayerFixtureStats;
DELETE FROM FixtureResults;
DELETE FROM Fixtures;
DBCC CHECKIDENT ('Fixtures', RESEED, 0);
```

### Clear All Fixtures Data (Including Gameweeks)
```sql
-- Execute: fixtures/output/clear_all_fixtures_data.sql
DELETE FROM PlayerFixtureStats;
DELETE FROM FixtureResults;
DELETE FROM Fixtures;
DELETE FROM Gameweeks;
DBCC CHECKIDENT ('Fixtures', RESEED, 0);
DBCC CHECKIDENT ('Gameweeks', RESEED, 0);
```

---

## 🐛 Troubleshooting

### "403 Forbidden" when scraping rosters
→ Manually save the page as HTML and place in `players/` directory

### "404 Not Found" on SLIAC pages
→ Ensure you're using proper browser headers (see Technical Notes)

### "Variable @FixtureId already declared"
→ SQL script needs `GO` statements between iterations (fixed in v2)

### "Could not find fixture for X vs Y"
→ Teams might be swapped or game rescheduled. Script handles 7-day tolerance.

### PDF downloaded but contains HTML
→ Ensure you're using the 2-step process to get S3 URL, not the document.aspx URL

---

## 📊 Stats & Coverage

- **Teams:** 9 SLIAC conference teams
- **Players:** ~200 players across all teams
- **Fixtures:** ~50+ conference games (Sept-Nov 2025)
- **Gameweeks:** 6 gameweeks
- **Box Scores:** PDF parsing for detailed player stats

---

## 🔮 Future Enhancements

- [ ] Finish `3_update_player_stats.py` (goalkeeper stats, cards, SQL generation)
- [ ] Automated scheduling (cron jobs to run scrapers weekly)
- [ ] Error notifications (email/SMS when scraping fails)
- [ ] Historical data import (past seasons)
- [ ] Direct database insertion (bypass SQL file generation)
- [ ] Dashboard for scraper status and data freshness

---

## 📄 License

This project is for educational purposes (CSCI 316 - Software Development).  
All data sourced from public SLIAC websites. Ensure proper attribution and respect robots.txt.
