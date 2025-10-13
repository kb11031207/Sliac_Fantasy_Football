
--use the database
USE fantasy_proj
GO

-- Drop tables in reverse dependency order to avoid FK constraint errors
DROP TABLE IF EXISTS PlayerGameweekStats;
GO

DROP TABLE IF EXISTS PlayerFixtureStats;
GO

DROP TABLE IF EXISTS FixtureResults;
GO

DROP TABLE IF EXISTS Fixtures;
GO

DROP TABLE IF EXISTS UserGameweekScores;
GO

DROP TABLE IF EXISTS squadPlayers;
GO

DROP TABLE IF EXISTS squads;
GO

DROP TABLE IF EXISTS gameweeks;
GO

DROP TABLE IF EXISTS players;
GO

DROP TABLE IF EXISTS conferenceTeams;
GO

DROP TABLE IF EXISTS usersXleagues;
GO

DROP TABLE IF EXISTS leagues;
GO

DROP TABLE IF EXISTS users;
GO

SELECT * FROM sys.tables;
GO
