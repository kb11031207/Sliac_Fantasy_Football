-- Migration Script: Fix conferenceTeams column sizes
-- Run this against your fantasy_proj database to expand the Team and School columns

USE fantasy_proj;
GO

-- Alter the Team column from NCHAR(10) to NVARCHAR(50)
ALTER TABLE [dbo].[conferenceTeams]
ALTER COLUMN [Team] NVARCHAR(50) NOT NULL;
GO

-- Alter the school column from NCHAR(10) to NVARCHAR(100)
ALTER TABLE [dbo].[conferenceTeams]
ALTER COLUMN [school] NVARCHAR(100) NOT NULL;
GO

PRINT 'Column sizes updated successfully!';
PRINT 'Team column: NCHAR(10) -> NVARCHAR(50)';
PRINT 'school column: NCHAR(10) -> NVARCHAR(100)';
GO

