# SLIAC Players Scraper

Extracts player roster data from SLIAC conference team websites and generates fantasy football pricing.

## Data Sources

Team roster pages from SLIAC conference schools:
- **Principia**: https://principiaathletics.com/sports/mens-soccer/roster
- More teams to be added...

## Features

### Player Data Extracted
- **Name** - Player full name
- **Jersey Number** - Player's jersey/shirt number
- **Position** - GK (Goalkeeper), DEF (Defender), MID (Midfielder), FWD (Forward)
- **Team** - Conference team affiliation

### Fantasy Pricing System

**Automatic cost generation** based on position:

| Position   | Cost Range | Logic                          |
|------------|------------|--------------------------------|
| GK         | $4.0-$5.0  | Cheap, limited scoring         |
| Defender   | $4.5-$6.0  | Budget-friendly, clean sheets  |
| Midfielder | $5.0-$8.0  | Mid-range, versatile           |
| Forward    | $6.0-$12.0 | Premium, high variance scoring |

**Star Player Boost**: Each team gets 1-2 randomly selected "star" players with +$0.5 to +$1.0 premium pricing.

### Position Mapping

| Roster Code | Database Value | Full Name   |
|-------------|----------------|-------------|
| GK          | 1              | Goalkeeper  |
| D           | 2              | Defender    |
| M           | 3              | Midfielder  |
| F           | 4              | Forward     |

## Output Files

All output files are saved in the `output/` directory:

- **output/players.json** - Complete player data in JSON format
- **output/players.sql** - SQL INSERT statements with TeamId lookup

## Database Schema

Maps to the `Players` table:
```sql
- Name (NVARCHAR) - Player's full name
- PlayerNum (BYTE) - Jersey number
- Position (BYTE) - Position code (1-4)
- TeamId (INT) - Foreign key to ConferenceTeams
- Cost (DECIMAL) - Fantasy price
- PictureUrl (NVARCHAR, nullable) - Player photo URL
```

## Usage

### Run the scraper:
```bash
cd scraper/players
python sliac_players_scraper.py
```

### Insert into database:
```bash
# IMPORTANT: Make sure ConferenceTeams are already inserted!
# The SQL uses a subquery to look up TeamId by team name
#
# Run: output/players.sql
```

## Dependencies

- Python 3.x
- No external packages required (uses only standard library)

## Current Status

- ✅ **Principia** - 26 players
- ⏳ **Other 8 teams** - To be added

## Adding More Teams

To add another team's roster:

1. Get the team's roster page URL
2. Extract player data (jersey, name, position)
3. Add to `TEAM_ROSTERS` dictionary in the script
4. Add scraping function for that team's HTML structure
5. Run the scraper

## Notes

- Costs are randomly generated within realistic ranges
- Each run produces different pricing (due to randomness)
- "Star" players are randomly selected per team
- Jersey numbers like "0/18" are parsed as "0"
- Costs are rounded to nearest $0.5 for clean pricing












