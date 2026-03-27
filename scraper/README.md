# SLIAC Data Scraper

Python-based web scrapers to collect SLIAC soccer statistics and populate the Fantasy Football database.

## 📋 Overview

This scraper suite collects three types of data:
1. **Teams** - Conference team information
2. **Players** - Player rosters from each team
3. **Fixtures & Stats** - Match schedules, results, and player statistics

## 🗂️ Structure

```
scraper/
├── teams/                    # Team scraper
│   ├── sliac_teams_scraper.py
│   ├── requirements.txt
│   └── output/
│       ├── conference_teams.json
│       └── conference_teams.sql
│
├── players/                  # Player scraper
│   ├── sliac_players_scraper.py
│   ├── requirements.txt
│   └── output/
│       ├── players.json
│       └── players.sql
│
└── fixtures/                 # Fixture & stats scraper
    ├── 1_setup_fixtures.py
    ├── 2_update_results.py
    ├── 3_update_player_stats.py
    ├── requirements.txt
    └── output/
        ├── fixtures.sql
        ├── fixture_results.sql
        └── update_player_stats_ALL.sql
```

## 🚀 Quick Start

### Prerequisites

- Python 3.8 or higher
- pip package manager

### Installation

```bash
# Navigate to scraper directory
cd scraper

# Install dependencies for each module
cd teams && pip install -r requirements.txt
cd ../players && pip install -r requirements.txt  
cd ../fixtures && pip install -r requirements.txt
```

## 📥 Usage

### 1. Scrape Teams

Collects SLIAC conference team information.

```bash
cd scraper/teams
python sliac_teams_scraper.py
```

**Output:**
- `output/conference_teams.json` - Raw team data
- `output/conference_teams.sql` - SQL INSERT statements

**What it scrapes:**
- Team names
- School names
- Conference membership
- Team IDs

### 2. Scrape Players

Collects player rosters from each SLIAC team.

```bash
cd scraper/players
python sliac_players_scraper.py
```

**Output:**
- `output/players.json` - Raw player data
- `output/players.sql` - SQL INSERT statements

**What it scrapes:**
- Player names
- Jersey numbers
- Positions (Forward, Midfielder, Defender, Goalkeeper)
- Team associations
- Player IDs

### 3. Scrape Fixtures (3-Step Process)

#### Step 1: Setup Fixtures
Creates the fixture schedule for the season.

```bash
cd scraper/fixtures
python 1_setup_fixtures.py
```

**Output:**
- `output/fixtures.sql` - Fixture schedule
- `output/gameweeks.sql` - Gameweek definitions
- `output/fixtures.json` - Raw fixture data

**What it scrapes:**
- Match schedules
- Home/away teams
- Gameweek assignments
- Match dates and times

#### Step 2: Update Results
Updates fixture results after matches are played.

```bash
python 2_update_results.py
```

**Output:**
- `output/fixture_results.sql` - Match results
- `output/update_results.sql` - Result UPDATE statements
- `output/latest_results.json` - Recent results

**What it scrapes:**
- Final scores
- Match outcomes
- Completed match flags

#### Step 3: Update Player Stats
Scrapes detailed player statistics from match reports.

```bash
python 3_update_player_stats.py
```

**Output:**
- `output/update_player_stats_ALL.sql` - All player stats
- `output/test_player_stats.sql` - Test/sample stats
- `output/processing_log.json` - Scraping log

**What it scrapes:**
- Goals scored
- Assists
- Minutes played
- Yellow/red cards
- Clean sheets (GK/Defenders)
- Saves (Goalkeepers)
- Goals conceded (GK/Defenders)

## 🔄 Complete Workflow

### Initial Setup (Start of Season)
```bash
# 1. Get teams
cd scraper/teams
python sliac_teams_scraper.py

# 2. Get players
cd ../players
python sliac_players_scraper.py

# 3. Setup fixtures
cd ../fixtures
python 1_setup_fixtures.py

# 4. Import to database
cd ../../Solution1/Database1
sqlcmd -S localhost -d fantasy_proj -i ../../scraper/teams/output/conference_teams.sql
sqlcmd -S localhost -d fantasy_proj -i ../../scraper/players/output/players.sql
sqlcmd -S localhost -d fantasy_proj -i ../../scraper/fixtures/output/setup_fixtures.sql
```

### Weekly Updates (During Season)
```bash
cd scraper/fixtures

# After matches are played each week
python 2_update_results.py
python 3_update_player_stats.py

# Import to database
cd ../../Solution1/Database1
sqlcmd -S localhost -d fantasy_proj -i ../../scraper/fixtures/output/update_results.sql
sqlcmd -S localhost -d fantasy_proj -i ../../scraper/fixtures/output/update_player_stats_ALL.sql
```

## 🛠️ Technical Details

### Dependencies

**Common packages across all scrapers:**
- `requests` - HTTP requests
- `beautifulsoup4` - HTML parsing
- `lxml` - XML/HTML processing
- `selenium` (fixtures only) - JavaScript rendering
- `PyPDF2` (fixtures only) - PDF parsing for match reports

### Data Sources

- **SLIAC Official Website**: Team and fixture information
- **Team Websites**: Player rosters
- **Match Reports (PDFs)**: Detailed player statistics

### Error Handling

All scrapers include:
- ✅ Request retry logic
- ✅ Error logging
- ✅ Partial success handling (continues on individual failures)
- ✅ Data validation
- ✅ Output file generation even on partial failures

### Performance

- **Teams**: ~30 seconds (9 teams)
- **Players**: ~2-3 minutes (200+ players)
- **Fixtures (setup)**: ~1 minute (schedule parsing)
- **Results**: ~30 seconds (recent matches)
- **Player Stats**: ~5-10 minutes (depends on PDF count and parsing)

## 📊 Data Validation

### Automatic Checks

Each scraper validates:
- ✅ Required fields are not null
- ✅ Position values are valid (Forward, Midfielder, Defender, Goalkeeper)
- ✅ Numeric fields (goals, assists, etc.) are non-negative
- ✅ Team references exist
- ✅ Date formats are correct

### Manual Verification

After scraping, verify:
```bash
# Check record counts
wc -l scraper/teams/output/conference_teams.sql
wc -l scraper/players/output/players.sql
wc -l scraper/fixtures/output/fixtures.sql

# Check for errors in logs
grep -i error scraper/fixtures/output/processing_log.json
```

## 🐛 Troubleshooting

### Issue: "Module not found"
**Solution:** Install requirements
```bash
pip install -r requirements.txt
```

### Issue: "Connection timeout"
**Solution:** Check internet connection, SLIAC website may be down
```bash
# Test connectivity
curl -I https://sliacathletics.com
```

### Issue: "No data scraped"
**Solution:** Website structure may have changed
- Check `output/*.json` files for raw data
- Review scraper logic
- SLIAC website HTML structure may need updating

### Issue: "PDF parsing failed"
**Solution:** PDF format may be inconsistent
- Check `output/pdfs/` directory for downloaded PDFs
- Manually verify PDF structure
- May need to adjust parsing logic in `3_update_player_stats.py`

### Issue: "SQL syntax error"
**Solution:** Special characters in names
- Check generated SQL files
- Look for apostrophes, quotes in player/team names
- Scraper should handle escaping automatically

## 📝 Output Files

### JSON Files (Raw Data)
- Human-readable
- Used for debugging
- Can be imported to other systems

### SQL Files (Database Import)
- Ready-to-execute SQL statements
- INSERT or UPDATE statements
- Include proper escaping and formatting

## 🔒 Best Practices

1. **Run scrapers during off-peak hours** - Less load on SLIAC servers
2. **Save output files** - Keep historical records
3. **Version control SQL outputs** - Track data changes over time
4. **Test on sample data first** - Use test database before production
5. **Check logs after each run** - Catch issues early

## 📅 Recommended Schedule

- **Pre-Season** (Once):
  - Run team scraper
  - Run player scraper
  - Run fixture setup
  
- **Weekly** (During Season):
  - Monday: Run results scraper (weekend matches)
  - Tuesday: Run player stats scraper
  - Wednesday: Review and import to database

- **As Needed**:
  - Player scraper if rosters change
  - Fixture scraper if schedule updates

## 🎯 Fantasy Points Integration

The scraped player statistics directly feed into the fantasy scoring system:

| Stat Scraped | Fantasy Point Value |
|-------------|---------------------|
| Goals (Forward) | +5 points |
| Goals (Midfielder) | +6 points |
| Goals (Defender/GK) | +8 points |
| Assists | +3 points |
| Minutes (90+) | +2 points |
| Minutes (45-89) | +1 point |
| Yellow Card | -1 point |
| Red Card | -3 points |
| Clean Sheet (GK/Def) | +4 points |
| Saves (per 3) | +1 point |
| Goals Conceded (GK/Def) | -1 point each |

## 🔗 Integration with API

The scrapers generate SQL that populates tables used by the API:

```
Scrapers → SQL Files → Database Tables → Dapper ORM → API Services → Controllers
```

**Data Flow:**
1. Scrapers collect data → Generate SQL
2. SQL executed → Populates database
3. API reads data → Serves to frontend
4. Fantasy scoring calculated → User standings updated

## 📖 Additional Documentation

- See main project README for API documentation
- See `Solution1/DOCUMENTATION_AND_TESTING_SUMMARY.md` for complete project docs
- See `Solution1/JWT_AUTHENTICATION_GUIDE.md` for API authentication

## 👥 Contributing

When modifying scrapers:
1. Test with small data sets first
2. Validate output SQL syntax
3. Check for data integrity
4. Update this README with changes
5. Document any website structure changes

## 📞 Support

If scrapers fail:
1. Check error logs in `output/` directories
2. Verify SLIAC website is accessible
3. Check that data format hasn't changed
4. Review scraper code comments for logic

---

**Last Updated**: October 2025  
**Python Version**: 3.8+  
**Status**: Active (Season in Progress)
