-- Migration Script: Fix players.name column size
-- Run this against your fantasy_proj database to expand the name column

USE fantasy_proj;
GO

-- First, delete any test data that was partially inserted
DELETE FROM players;
GO

-- Alter the name column from NCHAR(10) to NVARCHAR(100)
ALTER TABLE [dbo].[players]
ALTER COLUMN [name] NVARCHAR(100) NOT NULL;
GO

PRINT 'Column size updated successfully!';
PRINT 'name column: NCHAR(10) -> NVARCHAR(100)';
PRINT 'You can now insert players with full names.';
GO












