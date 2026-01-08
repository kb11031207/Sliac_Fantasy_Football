#!/bin/bash
set -e

echo "Starting database initialization..."

# Get SQL Server host from environment or use default
SQL_SERVER_HOST=${SQL_SERVER_HOST:-sqlserver}

# Wait for SQL Server to be ready
echo "Waiting for SQL Server to be ready..."
for i in {1..60}; do
    if /opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null; then
        echo "SQL Server is ready!"
        break
    fi
    echo "Waiting for SQL Server... ($i/60)"
    sleep 2
done

# Create database if it doesn't exist
echo "Creating database 'fantasy_proj'..."
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'fantasy_proj') CREATE DATABASE fantasy_proj"
# check if database created
if [ $? -eq 0 ]; then
    echo "✓ Database created"
else
    echo "✗ Failed to create database"
    exit 1
fi
# Check if database is already initialized (check if last table exists - if it does, all previous ones should too)
echo "Checking if database is already initialized..."
# Check for the last table created (userGameweekScores) and players table
# If both exist, initialization is complete
# Use -W to remove trailing spaces and check if we get a result (value "1")
USERGW_RESULT=$(/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -Q "SELECT TOP 1 1 FROM sys.tables WHERE name = 'userGameweekScores' AND schema_id = SCHEMA_ID('dbo')" -h -1 -W 2>/dev/null | tr -d ' ')
PLAYERS_RESULT=$(/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -Q "SELECT TOP 1 1 FROM sys.tables WHERE name = 'players' AND schema_id = SCHEMA_ID('dbo')" -h -1 -W 2>/dev/null | tr -d ' ')


# print the results
echo "USERGW_RESULT: $USERGW_RESULT"
echo "PLAYERS_RESULT: $PLAYERS_RESULT"
if [ "$USERGW_RESULT" = "1" ] && [ "$PLAYERS_RESULT" = "1" ]; then
    echo "✓ Database already initialized (all key tables exist). Skipping schema creation."
    echo "  To reinitialize: drop the database or remove the volume (docker-compose down -v)"
    exit 0
fi
echo "Database not fully initialized. Proceeding with schema creation..."

# Run schema scripts in dependency order
echo "Running schema creation scripts..."

# 1. Base tables (no dependencies)
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/01-users.sql -b
echo "✓ Created users table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/02-conferenceTeams.sql -b
echo "✓ Created conferenceTeams table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/03-gameweeks.sql -b
echo "✓ Created gameweeks table"

# 2. Tables depending on base tables
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/04-players.sql -b
echo "✓ Created players table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/05-leagues.sql -b
echo "✓ Created leagues table"

# 3. Junction tables
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/06-usersXleagues.sql -b
echo "✓ Created usersXleagues table"

# 4. Dependent tables
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/07-squads.sql -b
echo "✓ Created squads table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/08-fixtures.sql -b
echo "✓ Created fixtures table"

# 5. Result and stats tables
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/09-fixtureResults.sql -b
echo "✓ Created fixtureResults table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/10-squadPlayers.sql -b
echo "✓ Created squadPlayers table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/11-playerFixtureStats.sql -b
echo "✓ Created playerFixtureStats table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/12-playerGameweekStats.sql -b
echo "✓ Created playerGameweekStats table"

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/13-userGameweekScores.sql -b
echo "✓ Created userGameweekScores table"

# 6. EF Migrations history table (if needed)
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -U sa -P "$SA_PASSWORD" -d fantasy_proj -i /docker-init/14-efmigrationshistory.sql -b 2>/dev/null || echo "⚠ EFMigrationsHistory table skipped (optional)"

echo ""
echo "Database initialization complete!"
echo "Database 'fantasy_proj' is ready to use. "
