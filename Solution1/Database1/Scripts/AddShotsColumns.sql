-- Migration script to add Shots and ShotsOnGoal columns to playerFixtureStats and playerGameweekStats
-- Created: 2025-10-XX
-- Description: Adds tracking for shots and shots on goal to player statistics

-- Add Shots and ShotsOnGoal columns to playerFixtureStats
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[playerFixtureStats]') AND name = 'Shots')
BEGIN
    ALTER TABLE playerFixtureStats
    ADD Shots TINYINT NOT NULL DEFAULT 0;
    PRINT 'Added Shots column to playerFixtureStats';
END
ELSE
BEGIN
    PRINT 'Shots column already exists in playerFixtureStats';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[playerFixtureStats]') AND name = 'ShotsOnGoal')
BEGIN
    ALTER TABLE playerFixtureStats
    ADD ShotsOnGoal TINYINT NOT NULL DEFAULT 0;
    PRINT 'Added ShotsOnGoal column to playerFixtureStats';
END
ELSE
BEGIN
    PRINT 'ShotsOnGoal column already exists in playerFixtureStats';
END

-- Add Shots and ShotsOnGoal columns to playerGameweekStats
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[playerGameweekStats]') AND name = 'Shots')
BEGIN
    ALTER TABLE playerGameweekStats
    ADD Shots TINYINT NOT NULL DEFAULT 0;
    PRINT 'Added Shots column to playerGameweekStats';
END
ELSE
BEGIN
    PRINT 'Shots column already exists in playerGameweekStats';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[playerGameweekStats]') AND name = 'ShotsOnGoal')
BEGIN
    ALTER TABLE playerGameweekStats
    ADD ShotsOnGoal TINYINT NOT NULL DEFAULT 0;
    PRINT 'Added ShotsOnGoal column to playerGameweekStats';
END
ELSE
BEGIN
    PRINT 'ShotsOnGoal column already exists in playerGameweekStats';
END

PRINT 'Migration completed successfully!';












