-- Clear all players from the database
-- Use this during development when re-running scrapers

USE fantasy_proj;
GO

-- Delete all players
DELETE FROM players;
GO

-- Reset identity counter back to 1
DBCC CHECKIDENT ('players', RESEED, 0);
GO

PRINT 'All players cleared. Identity reset.';
PRINT 'You can now run the full players.sql file.';
GO






