# SLIAC Conference Teams Scraper

This scraper extracts conference team data from the SLIAC (St. Louis Intercollegiate Athletic Conference) website.

## Data Sources

1. **Standings Page**: https://sliac.org/standings.aspx?standings=234
   - Provides team abbreviations and logo URLs

2. **Members Page**: https://sliac.org/sports/2023/7/11/GEN_0711232207.aspx
   - Provides full school names

## Output Files

All output files are saved in the `output/` directory:

- **output/conference_teams.json** - JSON format with all team data
- **output/conference_teams.sql** - SQL INSERT statements ready to run against your database

## Teams Extracted

| Team       | Full School Name                     |
|------------|--------------------------------------|
| Blackburn  | Blackburn College                    |
| Eureka     | Eureka College                       |
| Greenville | Greenville University                |
| Lyon       | Lyon College                         |
| MUW        | Mississippi University for Women     |
| Principia  | Principia College                    |
| Spalding   | Spalding University                  |
| Webster    | Webster University                   |
| Westminster| Westminster College                  |

## Database Schema

The data maps to the `ConferenceTeams` table with these fields:
- `Team` (string) - Abbreviated team name
- `School` (string) - Full school name
- `LogoUrl` (string) - URL to team logo image

## Usage

### Run the scraper:
```bash
cd scraper/teams
python sliac_teams_scraper.py
```

### Insert data into database:
```bash
# Run the generated SQL file against your database using:
# - SQL Server Management Studio (SSMS)
# - Azure Data Studio
# - Or any SQL client
#
# File location: output/conference_teams.sql
```

## Dependencies

- Python 3.x
- No external packages required for v2 (data is hardcoded from web scraping)

## Notes

- The SLIAC website uses JavaScript to load content dynamically, so traditional web scraping doesn't work reliably
- Version 2 uses data extracted from the website and stored statically
- Logo URLs are full URLs pointing to sliac.org
- All school names and abbreviations are current as of October 2025

