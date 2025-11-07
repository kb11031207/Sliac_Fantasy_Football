-- =====================================================
-- Player Stats for: Spalding vs Lyon
-- Match Date: 2025-09-27
-- Generated: 2025-11-06 22:07:50
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Lyon';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Spalding';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-09-27')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-09-27'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Spalding vs Lyon';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Micah Mattes (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Mattes%'  -- Match last name
    OR p.name = 'Micah Mattes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Mattes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 2, 0, 5);
        PRINT '[OK] Inserted stats for Micah Mattes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Mattes (Jersey #0, Team: Spalding)';
END


-- Oliver Frankenfeld (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Oliver%'  -- Match first name
    OR p.name LIKE '%Frankenfeld%'  -- Match last name
    OR p.name = 'Oliver Frankenfeld'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oliver Frankenfeld';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oliver Frankenfeld';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oliver Frankenfeld (Jersey #3, Team: Spalding)';
END


-- Jose Huerta (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Jose%'  -- Match first name
    OR p.name LIKE '%Huerta%'  -- Match last name
    OR p.name = 'Jose Huerta'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jose Huerta';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jose Huerta';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jose Huerta (Jersey #4, Team: Spalding)';
END


-- Ethan Welsh (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Welsh%'  -- Match last name
    OR p.name = 'Ethan Welsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 79,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Welsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 79, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Welsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Welsh (Jersey #6, Team: Spalding)';
END


-- Eddie Mendez-Perez (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Eddie%'  -- Match first name
    OR p.name LIKE '%Mendez-Perez%'  -- Match last name
    OR p.name = 'Eddie Mendez-Perez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 84,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eddie Mendez-Perez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 84, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eddie Mendez-Perez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eddie Mendez-Perez (Jersey #8, Team: Spalding)';
END


-- Marlon Amaya (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Marlon%'  -- Match first name
    OR p.name LIKE '%Amaya%'  -- Match last name
    OR p.name = 'Marlon Amaya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Marlon Amaya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Marlon Amaya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Marlon Amaya (Jersey #10, Team: Spalding)';
END


-- Forte Bess (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Forte%'  -- Match first name
    OR p.name LIKE '%Bess%'  -- Match last name
    OR p.name = 'Forte Bess'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Forte Bess';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Forte Bess';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Forte Bess (Jersey #11, Team: Spalding)';
END


-- Carter Payne (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Carter%'  -- Match first name
    OR p.name LIKE '%Payne%'  -- Match last name
    OR p.name = 'Carter Payne'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carter Payne';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carter Payne';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carter Payne (Jersey #21, Team: Spalding)';
END


-- Kevin Mulume (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Kevin%'  -- Match first name
    OR p.name LIKE '%Mulume%'  -- Match last name
    OR p.name = 'Kevin Mulume'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kevin Mulume';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kevin Mulume';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kevin Mulume (Jersey #22, Team: Spalding)';
END


-- Trey McCoomer (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%McCoomer%'  -- Match last name
    OR p.name = 'Trey McCoomer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 79,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey McCoomer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 79, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey McCoomer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey McCoomer (Jersey #23, Team: Spalding)';
END


-- Hussein Abdella (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 29
  AND (
    p.name LIKE '%Hussein%'  -- Match first name
    OR p.name LIKE '%Abdella%'  -- Match last name
    OR p.name = 'Hussein Abdella'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hussein Abdella';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hussein Abdella';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hussein Abdella (Jersey #29, Team: Spalding)';
END


-- Mack Calvert (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Mack%'  -- Match first name
    OR p.name LIKE '%Calvert%'  -- Match last name
    OR p.name = 'Mack Calvert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 6,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Mack Calvert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 6, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Mack Calvert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Mack Calvert (Jersey #2, Team: Spalding)';
END


-- Jonatan De La Rosa Soriano (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Jonatan%'  -- Match first name
    OR p.name LIKE '%Soriano%'  -- Match last name
    OR p.name = 'Jonatan De La Rosa Soriano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 26,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonatan De La Rosa Soriano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 26, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonatan De La Rosa Soriano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonatan De La Rosa Soriano (Jersey #5, Team: Spalding)';
END


-- Roberto Arambula (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Roberto%'  -- Match first name
    OR p.name LIKE '%Arambula%'  -- Match last name
    OR p.name = 'Roberto Arambula'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 6,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Roberto Arambula';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 6, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Roberto Arambula';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Roberto Arambula (Jersey #12, Team: Spalding)';
END


-- Ryan Shoemaker (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Ryan%'  -- Match first name
    OR p.name LIKE '%Shoemaker%'  -- Match last name
    OR p.name = 'Ryan Shoemaker'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 5,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ryan Shoemaker';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 5, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ryan Shoemaker';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ryan Shoemaker (Jersey #13, Team: Spalding)';
END


-- Jamie Seago (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Jamie%'  -- Match first name
    OR p.name LIKE '%Seago%'  -- Match last name
    OR p.name = 'Jamie Seago'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jamie Seago';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jamie Seago';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jamie Seago (Jersey #18, Team: Spalding)';
END


-- Nolan Thomas (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nolan%'  -- Match first name
    OR p.name LIKE '%Thomas%'  -- Match last name
    OR p.name = 'Nolan Thomas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nolan Thomas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nolan Thomas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nolan Thomas (Jersey #19, Team: Spalding)';
END


-- Noah Butts (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 32
  AND (
    p.name LIKE '%Noah%'  -- Match first name
    OR p.name LIKE '%Butts%'  -- Match last name
    OR p.name = 'Noah Butts'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Noah Butts';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Noah Butts';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Noah Butts (Jersey #32, Team: Spalding)';
END


-- Grayson Pollock (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 34
  AND (
    p.name LIKE '%Grayson%'  -- Match first name
    OR p.name LIKE '%Pollock%'  -- Match last name
    OR p.name = 'Grayson Pollock'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 4,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Grayson Pollock';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 4, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Grayson Pollock';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Grayson Pollock (Jersey #34, Team: Spalding)';
END


-- Gabriel Rangel (GK) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Gabriel Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 3);
        PRINT '[OK] Inserted stats for Gabriel Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Rangel (Jersey #1, Team: Lyon)';
END


-- Jake Mcmurdo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Jake%'  -- Match first name
    OR p.name LIKE '%Mcmurdo%'  -- Match last name
    OR p.name = 'Jake Mcmurdo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 55,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jake Mcmurdo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 55, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jake Mcmurdo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jake Mcmurdo (Jersey #3, Team: Lyon)';
END


-- Salvador Fernandez (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Salvador%'  -- Match first name
    OR p.name LIKE '%Fernandez%'  -- Match last name
    OR p.name = 'Salvador Fernandez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Salvador Fernandez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Salvador Fernandez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Salvador Fernandez (Jersey #5, Team: Lyon)';
END


-- Cristian De La Rosa (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Cristian%'  -- Match first name
    OR p.name LIKE '%Rosa%'  -- Match last name
    OR p.name = 'Cristian De La Rosa'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cristian De La Rosa';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cristian De La Rosa';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cristian De La Rosa (Jersey #6, Team: Lyon)';
END


-- Matheus Nunes (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Matheus%'  -- Match first name
    OR p.name LIKE '%Nunes%'  -- Match last name
    OR p.name = 'Matheus Nunes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 81,
            Goals = 2,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Matheus Nunes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 81, 2, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Matheus Nunes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Matheus Nunes (Jersey #7, Team: Lyon)';
END


-- Micah Rangel (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Micah Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 58,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 58, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Micah Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Rangel (Jersey #8, Team: Lyon)';
END


-- Lucca Torres (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Lucca%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Lucca Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 74,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucca Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 74, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucca Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucca Torres (Jersey #9, Team: Lyon)';
END


-- Joao Barros (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Joao%'  -- Match first name
    OR p.name LIKE '%Barros%'  -- Match last name
    OR p.name = 'Joao Barros'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 74,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Joao Barros';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 74, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Joao Barros';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Joao Barros (Jersey #10, Team: Lyon)';
END


-- Tiago Donadon (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Tiago%'  -- Match first name
    OR p.name LIKE '%Donadon%'  -- Match last name
    OR p.name = 'Tiago Donadon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tiago Donadon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tiago Donadon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tiago Donadon (Jersey #11, Team: Lyon)';
END


-- Tomas Biasi (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Tomas%'  -- Match first name
    OR p.name LIKE '%Biasi%'  -- Match last name
    OR p.name = 'Tomas Biasi'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tomas Biasi';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tomas Biasi';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tomas Biasi (Jersey #16, Team: Lyon)';
END


-- Leonardo Bravo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 41
  AND (
    p.name LIKE '%Leonardo%'  -- Match first name
    OR p.name LIKE '%Bravo%'  -- Match last name
    OR p.name = 'Leonardo Bravo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Leonardo Bravo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Leonardo Bravo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Leonardo Bravo (Jersey #41, Team: Lyon)';
END


-- Taylor Prater (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Taylor%'  -- Match first name
    OR p.name LIKE '%Prater%'  -- Match last name
    OR p.name = 'Taylor Prater'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Taylor Prater';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Taylor Prater';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Taylor Prater (Jersey #2, Team: Lyon)';
END


-- Traviss Ragan (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Traviss%'  -- Match first name
    OR p.name LIKE '%Ragan%'  -- Match last name
    OR p.name = 'Traviss Ragan'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 26,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Traviss Ragan';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 26, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Traviss Ragan';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Traviss Ragan (Jersey #14, Team: Lyon)';
END


-- Frederico Ribeiro (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 29
  AND (
    p.name LIKE '%Frederico%'  -- Match first name
    OR p.name LIKE '%Ribeiro%'  -- Match last name
    OR p.name = 'Frederico Ribeiro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 16,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Frederico Ribeiro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 16, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Frederico Ribeiro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Frederico Ribeiro (Jersey #29, Team: Lyon)';
END


-- Andre Rodriguez (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 31
  AND (
    p.name LIKE '%Andre%'  -- Match first name
    OR p.name LIKE '%Rodriguez%'  -- Match last name
    OR p.name = 'Andre Rodriguez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 48,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Andre Rodriguez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 48, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Andre Rodriguez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Andre Rodriguez (Jersey #31, Team: Lyon)';
END


-- Piero Macias (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Piero%'  -- Match first name
    OR p.name LIKE '%Macias%'  -- Match last name
    OR p.name = 'Piero Macias'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 5,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Piero Macias';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 5, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Piero Macias';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Piero Macias (Jersey #35, Team: Lyon)';
END


-- Thomas Larios (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 37
  AND (
    p.name LIKE '%Thomas%'  -- Match first name
    OR p.name LIKE '%Larios%'  -- Match last name
    OR p.name = 'Thomas Larios'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Thomas Larios';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Thomas Larios';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Thomas Larios (Jersey #37, Team: Lyon)';
END


-- =====================================================
-- Complete! Processed 36 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Greenville vs Blackburn
-- Match Date: 2025-09-27
-- Generated: 2025-11-06 22:08:16
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Blackburn';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Greenville';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-09-27')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-09-27'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Greenville vs Blackburn';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Tian Poyo (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Tian%'  -- Match first name
    OR p.name LIKE '%Poyo%'  -- Match last name
    OR p.name = 'Tian Poyo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 7
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tian Poyo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 7);
        PRINT '[OK] Inserted stats for Tian Poyo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tian Poyo (Jersey #25, Team: Greenville)';
END


-- Juan Vargas (GK) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Vargas%'  -- Match last name
    OR p.name = 'Juan Vargas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Vargas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 1, 0, 0, 2, 0, 3);
        PRINT '[OK] Inserted stats for Juan Vargas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Vargas (Jersey #0, Team: Blackburn)';
END


-- =====================================================
-- Complete! Processed 47 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Principia vs MUW
-- Match Date: 2025-09-27
-- Generated: 2025-11-06 22:08:19
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'MUW';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Principia';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-09-27')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-09-27'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Principia vs MUW';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Nacho Cachaza (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Nacho%'  -- Match first name
    OR p.name LIKE '%Cachaza%'  -- Match last name
    OR p.name = 'Nacho Cachaza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nacho Cachaza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nacho Cachaza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nacho Cachaza (Jersey #3, Team: Principia)';
END


-- Eduardo Salazar (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Eduardo%'  -- Match first name
    OR p.name LIKE '%Salazar%'  -- Match last name
    OR p.name = 'Eduardo Salazar'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eduardo Salazar';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eduardo Salazar';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eduardo Salazar (Jersey #6, Team: Principia)';
END


-- Effenberg Joya (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Effenberg%'  -- Match first name
    OR p.name LIKE '%Joya%'  -- Match last name
    OR p.name = 'Effenberg Joya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 56,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Effenberg Joya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 56, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Effenberg Joya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Effenberg Joya (Jersey #7, Team: Principia)';
END


-- Alejandro Liborio (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Alejandro%'  -- Match first name
    OR p.name LIKE '%Liborio%'  -- Match last name
    OR p.name = 'Alejandro Liborio'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alejandro Liborio';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alejandro Liborio';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alejandro Liborio (Jersey #9, Team: Principia)';
END


-- Diego Alas (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Alas%'  -- Match last name
    OR p.name = 'Diego Alas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 41,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Alas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 41, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Alas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Alas (Jersey #10, Team: Principia)';
END


-- Wizzy Afrani (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Wizzy%'  -- Match first name
    OR p.name LIKE '%Afrani%'  -- Match last name
    OR p.name = 'Wizzy Afrani'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 76,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Wizzy Afrani';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 76, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Wizzy Afrani';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Wizzy Afrani (Jersey #11, Team: Principia)';
END


-- Jonathan Keller (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jonathan%'  -- Match first name
    OR p.name LIKE '%Keller%'  -- Match last name
    OR p.name = 'Jonathan Keller'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 80,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonathan Keller';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 80, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonathan Keller';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonathan Keller (Jersey #13, Team: Principia)';
END


-- Juan Garcia Lopez (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Lopez%'  -- Match last name
    OR p.name = 'Juan Garcia Lopez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Garcia Lopez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Garcia Lopez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Garcia Lopez (Jersey #14, Team: Principia)';
END


-- Damilola Odunuga (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Damilola%'  -- Match first name
    OR p.name LIKE '%Odunuga%'  -- Match last name
    OR p.name = 'Damilola Odunuga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Damilola Odunuga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Damilola Odunuga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Damilola Odunuga (Jersey #15, Team: Principia)';
END


-- Diego De Manuel Romero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Romero%'  -- Match last name
    OR p.name = 'Diego De Manuel Romero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego De Manuel Romero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego De Manuel Romero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego De Manuel Romero (Jersey #21, Team: Principia)';
END


-- Edgar Cartagena (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Edgar%'  -- Match first name
    OR p.name LIKE '%Cartagena%'  -- Match last name
    OR p.name = 'Edgar Cartagena'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Edgar Cartagena';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 1);
        PRINT '[OK] Inserted stats for Edgar Cartagena';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Edgar Cartagena (Jersey #30, Team: Principia)';
END


-- Eziuche Ejimadu (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Eziuche%'  -- Match first name
    OR p.name LIKE '%Ejimadu%'  -- Match last name
    OR p.name = 'Eziuche Ejimadu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 28,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eziuche Ejimadu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 28, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eziuche Ejimadu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eziuche Ejimadu (Jersey #12, Team: Principia)';
END


-- Kaiky Dos Santos (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Kaiky%'  -- Match first name
    OR p.name LIKE '%Santos%'  -- Match last name
    OR p.name = 'Kaiky Dos Santos'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 34,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kaiky Dos Santos';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 34, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kaiky Dos Santos';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kaiky Dos Santos (Jersey #16, Team: Principia)';
END


-- Nana Koranteng (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nana%'  -- Match first name
    OR p.name LIKE '%Koranteng%'  -- Match last name
    OR p.name = 'Nana Koranteng'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 34,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nana Koranteng';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 34, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nana Koranteng';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nana Koranteng (Jersey #19, Team: Principia)';
END


-- Amri Seperia (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Amri%'  -- Match first name
    OR p.name LIKE '%Seperia%'  -- Match last name
    OR p.name = 'Amri Seperia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Amri Seperia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Amri Seperia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Amri Seperia (Jersey #23, Team: Principia)';
END


-- Kelvin Kasirye (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Kelvin%'  -- Match first name
    OR p.name LIKE '%Kasirye%'  -- Match last name
    OR p.name = 'Kelvin Kasirye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 31,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kelvin Kasirye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 31, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kelvin Kasirye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kelvin Kasirye (Jersey #25, Team: Principia)';
END


-- Drew Pack (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Drew%'  -- Match first name
    OR p.name LIKE '%Pack%'  -- Match last name
    OR p.name = 'Drew Pack'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Drew Pack';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Drew Pack';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Drew Pack (Jersey #3, Team: MUW)';
END


-- Cole Crawford (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Cole%'  -- Match first name
    OR p.name LIKE '%Crawford%'  -- Match last name
    OR p.name = 'Cole Crawford'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cole Crawford';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cole Crawford';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cole Crawford (Jersey #4, Team: MUW)';
END


-- Daniel Holmes (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Daniel%'  -- Match first name
    OR p.name LIKE '%Holmes%'  -- Match last name
    OR p.name = 'Daniel Holmes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 77,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Daniel Holmes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 77, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Daniel Holmes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Daniel Holmes (Jersey #5, Team: MUW)';
END


-- Kyle Morris (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Morris%'  -- Match last name
    OR p.name = 'Kyle Morris'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Morris';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Morris';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Morris (Jersey #14, Team: MUW)';
END


-- Ethan Barnes (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Barnes%'  -- Match last name
    OR p.name = 'Ethan Barnes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Barnes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Barnes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Barnes (Jersey #16, Team: MUW)';
END


-- Luke Bradley (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Bradley%'  -- Match last name
    OR p.name = 'Luke Bradley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Bradley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Bradley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Bradley (Jersey #19, Team: MUW)';
END


-- Trey Parnell (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%Parnell%'  -- Match last name
    OR p.name = 'Trey Parnell'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey Parnell';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey Parnell';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey Parnell (Jersey #22, Team: MUW)';
END


-- Juan Puga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Puga%'  -- Match last name
    OR p.name = 'Juan Puga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Puga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Puga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Puga (Jersey #27, Team: MUW)';
END


-- Sam Davis (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Sam%'  -- Match first name
    OR p.name LIKE '%Davis%'  -- Match last name
    OR p.name = 'Sam Davis'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sam Davis';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sam Davis';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sam Davis (Jersey #35, Team: MUW)';
END


-- Preston Holmes (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Preston%'  -- Match first name
    OR p.name LIKE '%Holmes%'  -- Match last name
    OR p.name = 'Preston Holmes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 54,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Preston Holmes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 54, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Preston Holmes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Preston Holmes (Jersey #6, Team: MUW)';
END


-- Josh Zuniga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Josh%'  -- Match first name
    OR p.name LIKE '%Zuniga%'  -- Match last name
    OR p.name = 'Josh Zuniga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Josh Zuniga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Josh Zuniga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Josh Zuniga (Jersey #11, Team: MUW)';
END


-- Dilyn Arnold (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Dilyn%'  -- Match first name
    OR p.name LIKE '%Arnold%'  -- Match last name
    OR p.name = 'Dilyn Arnold'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dilyn Arnold';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Dilyn Arnold';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dilyn Arnold (Jersey #15, Team: MUW)';
END


-- John Hendrix (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%John%'  -- Match first name
    OR p.name LIKE '%Hendrix%'  -- Match last name
    OR p.name = 'John Hendrix'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 31,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for John Hendrix';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 31, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for John Hendrix';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: John Hendrix (Jersey #18, Team: MUW)';
END


-- =====================================================
-- Complete! Processed 32 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Westminster vs Eureka
-- Match Date: 2025-09-28
-- Generated: 2025-11-06 22:08:23
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Eureka';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Westminster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-09-28')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-09-28'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Westminster vs Eureka';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Hunter Deeken (GK) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Hunter%'  -- Match first name
    OR p.name LIKE '%Deeken%'  -- Match last name
    OR p.name = 'Hunter Deeken'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 4
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hunter Deeken';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 4);
        PRINT '[OK] Inserted stats for Hunter Deeken';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hunter Deeken (Jersey #0, Team: Westminster)';
END


-- Sebastian Torres (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 99
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Sebastian Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 5);
        PRINT '[OK] Inserted stats for Sebastian Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Torres (Jersey #99, Team: Eureka)';
END


-- =====================================================
-- Complete! Processed 43 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Blackburn vs Westminster
-- Match Date: 2025-10-01
-- Generated: 2025-11-06 22:08:34
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Westminster';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Blackburn';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-01')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-01'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Blackburn vs Westminster';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Juan Vargas (GK) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Vargas%'  -- Match last name
    OR p.name = 'Juan Vargas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Vargas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 2, 0, 3);
        PRINT '[OK] Inserted stats for Juan Vargas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Vargas (Jersey #0, Team: Blackburn)';
END


-- Hunter Deeken (GK) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Hunter%'  -- Match first name
    OR p.name LIKE '%Deeken%'  -- Match last name
    OR p.name = 'Hunter Deeken'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hunter Deeken';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 3);
        PRINT '[OK] Inserted stats for Hunter Deeken';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hunter Deeken (Jersey #0, Team: Westminster)';
END


-- =====================================================
-- Complete! Processed 44 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Webster vs Eureka
-- Match Date: 2025-10-01
-- Generated: 2025-11-06 22:08:59
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Eureka';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Webster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-01')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-01'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Webster vs Eureka';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Luke Dillon (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Dillon%'  -- Match last name
    OR p.name = 'Luke Dillon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 81,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 2
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Dillon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 81, 0, 0, 0, 0, 1, 0, 0, 2);
        PRINT '[OK] Inserted stats for Luke Dillon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Dillon (Jersey #1, Team: Webster)';
END


-- Ty Baudendistel (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Ty%'  -- Match first name
    OR p.name LIKE '%Baudendistel%'  -- Match last name
    OR p.name = 'Ty Baudendistel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 8,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ty Baudendistel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 8, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ty Baudendistel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ty Baudendistel (Jersey #35, Team: Webster)';
END


-- Sebastian Torres (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 99
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Sebastian Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 3,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 10
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 3, 0, 10);
        PRINT '[OK] Inserted stats for Sebastian Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Torres (Jersey #99, Team: Eureka)';
END


-- Brayton Strawkas (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 55
  AND (
    p.name LIKE '%Brayton%'  -- Match first name
    OR p.name LIKE '%Strawkas%'  -- Match last name
    OR p.name = 'Brayton Strawkas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 4,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brayton Strawkas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 4, 0, 0, 0, 0, 0, 1, 0, 0);
        PRINT '[OK] Inserted stats for Brayton Strawkas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brayton Strawkas (Jersey #55, Team: Eureka)';
END


-- =====================================================
-- Complete! Processed 52 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: MUW vs Spalding
-- Match Date: 2025-10-04
-- Generated: 2025-11-06 22:09:02
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Spalding';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'MUW';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-04')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-04'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for MUW vs Spalding';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Nick Gutierrez (GK) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Nick%'  -- Match first name
    OR p.name LIKE '%Gutierrez%'  -- Match last name
    OR p.name = 'Nick Gutierrez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 10,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 10
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nick Gutierrez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 10, 0, 10);
        PRINT '[OK] Inserted stats for Nick Gutierrez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nick Gutierrez (Jersey #1, Team: MUW)';
END


-- Cole Crawford (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Cole%'  -- Match first name
    OR p.name LIKE '%Crawford%'  -- Match last name
    OR p.name = 'Cole Crawford'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cole Crawford';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cole Crawford';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cole Crawford (Jersey #4, Team: MUW)';
END


-- Josh Zuniga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Josh%'  -- Match first name
    OR p.name LIKE '%Zuniga%'  -- Match last name
    OR p.name = 'Josh Zuniga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 76,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Josh Zuniga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 76, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Josh Zuniga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Josh Zuniga (Jersey #11, Team: MUW)';
END


-- Kyle Morris (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Morris%'  -- Match last name
    OR p.name = 'Kyle Morris'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 84,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Morris';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 84, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Morris';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Morris (Jersey #14, Team: MUW)';
END


-- Dilyn Arnold (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Dilyn%'  -- Match first name
    OR p.name LIKE '%Arnold%'  -- Match last name
    OR p.name = 'Dilyn Arnold'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 17,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dilyn Arnold';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 17, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Dilyn Arnold';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dilyn Arnold (Jersey #15, Team: MUW)';
END


-- Ethan Barnes (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Barnes%'  -- Match last name
    OR p.name = 'Ethan Barnes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Barnes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Barnes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Barnes (Jersey #16, Team: MUW)';
END


-- Luke Bradley (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Bradley%'  -- Match last name
    OR p.name = 'Luke Bradley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Bradley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Bradley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Bradley (Jersey #19, Team: MUW)';
END


-- Trey Parnell (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%Parnell%'  -- Match last name
    OR p.name = 'Trey Parnell'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 81,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey Parnell';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 81, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey Parnell';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey Parnell (Jersey #22, Team: MUW)';
END


-- Sam Davis (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Sam%'  -- Match first name
    OR p.name LIKE '%Davis%'  -- Match last name
    OR p.name = 'Sam Davis'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 64,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sam Davis';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 64, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sam Davis';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sam Davis (Jersey #35, Team: MUW)';
END


-- Drew Pack (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Drew%'  -- Match first name
    OR p.name LIKE '%Pack%'  -- Match last name
    OR p.name = 'Drew Pack'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 33,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Drew Pack';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 33, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Drew Pack';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Drew Pack (Jersey #3, Team: MUW)';
END


-- Preston Holmes (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Preston%'  -- Match first name
    OR p.name LIKE '%Holmes%'  -- Match last name
    OR p.name = 'Preston Holmes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 48,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Preston Holmes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 48, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Preston Holmes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Preston Holmes (Jersey #6, Team: MUW)';
END


-- Justin Nazariega (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Justin%'  -- Match first name
    OR p.name LIKE '%Nazariega%'  -- Match last name
    OR p.name = 'Justin Nazariega'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 27,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Justin Nazariega';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 27, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Justin Nazariega';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Justin Nazariega (Jersey #7, Team: MUW)';
END


-- John Hendrix (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%John%'  -- Match first name
    OR p.name LIKE '%Hendrix%'  -- Match last name
    OR p.name = 'John Hendrix'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 30,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for John Hendrix';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 30, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for John Hendrix';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: John Hendrix (Jersey #18, Team: MUW)';
END


-- Micah Mattes (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Mattes%'  -- Match last name
    OR p.name = 'Micah Mattes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 60,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 2
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Mattes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 60, 0, 0, 0, 0, 0, 1, 0, 2);
        PRINT '[OK] Inserted stats for Micah Mattes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Mattes (Jersey #0, Team: Spalding)';
END


-- Oliver Frankenfeld (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Oliver%'  -- Match first name
    OR p.name LIKE '%Frankenfeld%'  -- Match last name
    OR p.name = 'Oliver Frankenfeld'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oliver Frankenfeld';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oliver Frankenfeld';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oliver Frankenfeld (Jersey #3, Team: Spalding)';
END


-- Eddie Mendez-Perez (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Eddie%'  -- Match first name
    OR p.name LIKE '%Mendez-Perez%'  -- Match last name
    OR p.name = 'Eddie Mendez-Perez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 2,
            Assists = 3,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eddie Mendez-Perez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 2, 3, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eddie Mendez-Perez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eddie Mendez-Perez (Jersey #8, Team: Spalding)';
END


-- Marlon Amaya (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Marlon%'  -- Match first name
    OR p.name LIKE '%Amaya%'  -- Match last name
    OR p.name = 'Marlon Amaya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 3,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Marlon Amaya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 3, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Marlon Amaya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Marlon Amaya (Jersey #10, Team: Spalding)';
END


-- Forte Bess (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Forte%'  -- Match first name
    OR p.name LIKE '%Bess%'  -- Match last name
    OR p.name = 'Forte Bess'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Forte Bess';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Forte Bess';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Forte Bess (Jersey #11, Team: Spalding)';
END


-- Nolan Thomas (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nolan%'  -- Match first name
    OR p.name LIKE '%Thomas%'  -- Match last name
    OR p.name = 'Nolan Thomas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 60,
            Goals = 2,
            Assists = 2,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nolan Thomas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 60, 2, 2, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nolan Thomas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nolan Thomas (Jersey #19, Team: Spalding)';
END


-- Carter Payne (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Carter%'  -- Match first name
    OR p.name LIKE '%Payne%'  -- Match last name
    OR p.name = 'Carter Payne'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 73,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carter Payne';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 73, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carter Payne';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carter Payne (Jersey #21, Team: Spalding)';
END


-- Kevin Mulume (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Kevin%'  -- Match first name
    OR p.name LIKE '%Mulume%'  -- Match last name
    OR p.name = 'Kevin Mulume'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 80,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kevin Mulume';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 80, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kevin Mulume';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kevin Mulume (Jersey #22, Team: Spalding)';
END


-- Trey McCoomer (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%McCoomer%'  -- Match last name
    OR p.name = 'Trey McCoomer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 52,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey McCoomer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 52, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey McCoomer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey McCoomer (Jersey #23, Team: Spalding)';
END


-- Gabe Brangers (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabe%'  -- Match first name
    OR p.name LIKE '%Brangers%'  -- Match last name
    OR p.name = 'Gabe Brangers'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabe Brangers';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabe Brangers';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabe Brangers (Jersey #1, Team: Spalding)';
END


-- Mack Calvert (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Mack%'  -- Match first name
    OR p.name LIKE '%Calvert%'  -- Match last name
    OR p.name = 'Mack Calvert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 38,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Mack Calvert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 38, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Mack Calvert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Mack Calvert (Jersey #2, Team: Spalding)';
END


-- Jonatan De La Rosa Soriano (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Jonatan%'  -- Match first name
    OR p.name LIKE '%Soriano%'  -- Match last name
    OR p.name = 'Jonatan De La Rosa Soriano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonatan De La Rosa Soriano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonatan De La Rosa Soriano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonatan De La Rosa Soriano (Jersey #5, Team: Spalding)';
END


-- Roberto Arambula (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Roberto%'  -- Match first name
    OR p.name LIKE '%Arambula%'  -- Match last name
    OR p.name = 'Roberto Arambula'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Roberto Arambula';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Roberto Arambula';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Roberto Arambula (Jersey #12, Team: Spalding)';
END


-- Dylan Hash (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 91
  AND (
    p.name LIKE '%Dylan%'  -- Match first name
    OR p.name LIKE '%Hash%'  -- Match last name
    OR p.name = 'Dylan Hash'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dylan Hash';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 1);
        PRINT '[OK] Inserted stats for Dylan Hash';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dylan Hash (Jersey #91, Team: Spalding)';
END


-- =====================================================
-- Complete! Processed 35 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Webster vs Greenville
-- Match Date: 2025-10-04
-- Generated: 2025-11-06 22:09:25
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Greenville';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Webster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-04')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-04'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Webster vs Greenville';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Luke Dillon (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Dillon%'  -- Match last name
    OR p.name = 'Luke Dillon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 3,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Dillon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 3, 0, 5);
        PRINT '[OK] Inserted stats for Luke Dillon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Dillon (Jersey #1, Team: Webster)';
END


-- Luke Walsh (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Walsh%'  -- Match last name
    OR p.name = 'Luke Walsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Walsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Walsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Walsh (Jersey #2, Team: Webster)';
END


-- Ian Meyer (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Ian%'  -- Match first name
    OR p.name LIKE '%Meyer%'  -- Match last name
    OR p.name = 'Ian Meyer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ian Meyer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ian Meyer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ian Meyer (Jersey #3, Team: Webster)';
END


-- Finn Rohl (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Finn%'  -- Match first name
    OR p.name LIKE '%Rohl%'  -- Match last name
    OR p.name = 'Finn Rohl'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 41,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Finn Rohl';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 41, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Finn Rohl';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Finn Rohl (Jersey #11, Team: Webster)';
END


-- Danny Nusinovic (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Nusinovic%'  -- Match last name
    OR p.name = 'Danny Nusinovic'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Nusinovic';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Danny Nusinovic';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Nusinovic (Jersey #16, Team: Webster)';
END


-- Scott Price (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Scott%'  -- Match first name
    OR p.name LIKE '%Price%'  -- Match last name
    OR p.name = 'Scott Price'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Scott Price';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Scott Price';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Scott Price (Jersey #17, Team: Webster)';
END


-- Alberto Duque Gonzalez (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Alberto%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Alberto Duque Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 82,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alberto Duque Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 82, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alberto Duque Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alberto Duque Gonzalez (Jersey #26, Team: Webster)';
END


-- Enzo Goncalves Proni (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Enzo%'  -- Match first name
    OR p.name LIKE '%Proni%'  -- Match last name
    OR p.name = 'Enzo Goncalves Proni'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 8,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Enzo Goncalves Proni';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 8, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Enzo Goncalves Proni';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Enzo Goncalves Proni (Jersey #9, Team: Webster)';
END


-- Elmin Lemes (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Elmin%'  -- Match first name
    OR p.name LIKE '%Lemes%'  -- Match last name
    OR p.name = 'Elmin Lemes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 20,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Elmin Lemes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 20, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Elmin Lemes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Elmin Lemes (Jersey #10, Team: Webster)';
END


-- Hayden Hatley (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Hayden%'  -- Match first name
    OR p.name LIKE '%Hatley%'  -- Match last name
    OR p.name = 'Hayden Hatley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 54,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hayden Hatley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 54, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hayden Hatley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hayden Hatley (Jersey #20, Team: Webster)';
END


-- Carlos Ziesecke (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Carlos%'  -- Match first name
    OR p.name LIKE '%Ziesecke%'  -- Match last name
    OR p.name = 'Carlos Ziesecke'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carlos Ziesecke';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carlos Ziesecke';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carlos Ziesecke (Jersey #3, Team: Greenville)';
END


-- Abraham Sedillo (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Abraham%'  -- Match first name
    OR p.name LIKE '%Sedillo%'  -- Match last name
    OR p.name = 'Abraham Sedillo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Abraham Sedillo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Abraham Sedillo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Abraham Sedillo (Jersey #4, Team: Greenville)';
END


-- Ben Wilcoxen (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Ben%'  -- Match first name
    OR p.name LIKE '%Wilcoxen%'  -- Match last name
    OR p.name = 'Ben Wilcoxen'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 80,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ben Wilcoxen';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 80, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ben Wilcoxen';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ben Wilcoxen (Jersey #5, Team: Greenville)';
END


-- Manolo Juarez (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Manolo%'  -- Match first name
    OR p.name LIKE '%Juarez%'  -- Match last name
    OR p.name = 'Manolo Juarez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Manolo Juarez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Manolo Juarez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Manolo Juarez (Jersey #11, Team: Greenville)';
END


-- Izan Gonzalez Rivera (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Izan%'  -- Match first name
    OR p.name LIKE '%Rivera%'  -- Match last name
    OR p.name = 'Izan Gonzalez Rivera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Izan Gonzalez Rivera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Izan Gonzalez Rivera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Izan Gonzalez Rivera (Jersey #17, Team: Greenville)';
END


-- Tian Poyo (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Tian%'  -- Match first name
    OR p.name LIKE '%Poyo%'  -- Match last name
    OR p.name = 'Tian Poyo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 7
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tian Poyo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 2, 0, 7);
        PRINT '[OK] Inserted stats for Tian Poyo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tian Poyo (Jersey #25, Team: Greenville)';
END


-- Pedro Kamada (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Pedro%'  -- Match first name
    OR p.name LIKE '%Kamada%'  -- Match last name
    OR p.name = 'Pedro Kamada'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 20,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pedro Kamada';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 20, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pedro Kamada';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pedro Kamada (Jersey #7, Team: Greenville)';
END


-- Braulio Martinez (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Braulio%'  -- Match first name
    OR p.name LIKE '%Martinez%'  -- Match last name
    OR p.name = 'Braulio Martinez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 14,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Braulio Martinez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 14, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Braulio Martinez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Braulio Martinez (Jersey #9, Team: Greenville)';
END


-- Pablo Canola (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 34
  AND (
    p.name LIKE '%Pablo%'  -- Match first name
    OR p.name LIKE '%Canola%'  -- Match last name
    OR p.name = 'Pablo Canola'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pablo Canola';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pablo Canola';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pablo Canola (Jersey #34, Team: Greenville)';
END


-- =====================================================
-- Complete! Processed 38 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Westminster vs Lyon
-- Match Date: 2025-10-04
-- Generated: 2025-11-06 22:09:29
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Lyon';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Westminster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-04')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-04'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Westminster vs Lyon';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Danny Monroy (GK) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Monroy%'  -- Match last name
    OR p.name = 'Danny Monroy'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 6,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Monroy';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 6, 0, 5);
        PRINT '[OK] Inserted stats for Danny Monroy';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Monroy (Jersey #1, Team: Westminster)';
END


-- Brayden Eckelkamp (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Brayden%'  -- Match first name
    OR p.name LIKE '%Eckelkamp%'  -- Match last name
    OR p.name = 'Brayden Eckelkamp'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brayden Eckelkamp';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brayden Eckelkamp';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brayden Eckelkamp (Jersey #2, Team: Westminster)';
END


-- Matthew Garrone (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Matthew%'  -- Match first name
    OR p.name LIKE '%Garrone%'  -- Match last name
    OR p.name = 'Matthew Garrone'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Matthew Garrone';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Matthew Garrone';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Matthew Garrone (Jersey #6, Team: Westminster)';
END


-- Lucas Sottile (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Lucas%'  -- Match first name
    OR p.name LIKE '%Sottile%'  -- Match last name
    OR p.name = 'Lucas Sottile'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucas Sottile';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucas Sottile';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucas Sottile (Jersey #7, Team: Westminster)';
END


-- Nathan Naumann (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Nathan%'  -- Match first name
    OR p.name LIKE '%Naumann%'  -- Match last name
    OR p.name = 'Nathan Naumann'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 47,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nathan Naumann';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nathan Naumann';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nathan Naumann (Jersey #9, Team: Westminster)';
END


-- Noah Naumann (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Noah%'  -- Match first name
    OR p.name LIKE '%Naumann%'  -- Match last name
    OR p.name = 'Noah Naumann'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 56,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Noah Naumann';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 56, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Noah Naumann';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Noah Naumann (Jersey #10, Team: Westminster)';
END


-- Khamani Matallah (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Khamani%'  -- Match first name
    OR p.name LIKE '%Matallah%'  -- Match last name
    OR p.name = 'Khamani Matallah'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Khamani Matallah';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Khamani Matallah';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Khamani Matallah (Jersey #11, Team: Westminster)';
END


-- Evan Schmitt (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Evan%'  -- Match first name
    OR p.name LIKE '%Schmitt%'  -- Match last name
    OR p.name = 'Evan Schmitt'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 47,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Evan Schmitt';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Evan Schmitt';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Evan Schmitt (Jersey #21, Team: Westminster)';
END


-- Braedon Cairer (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Braedon%'  -- Match first name
    OR p.name LIKE '%Cairer%'  -- Match last name
    OR p.name = 'Braedon Cairer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 51,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Braedon Cairer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 51, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Braedon Cairer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Braedon Cairer (Jersey #25, Team: Westminster)';
END


-- Kyle Bonck (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Bonck%'  -- Match last name
    OR p.name = 'Kyle Bonck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Bonck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Bonck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Bonck (Jersey #30, Team: Westminster)';
END


-- Blessing Kahiya (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Blessing%'  -- Match first name
    OR p.name LIKE '%Kahiya%'  -- Match last name
    OR p.name = 'Blessing Kahiya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 35,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Blessing Kahiya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 35, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Blessing Kahiya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Blessing Kahiya (Jersey #8, Team: Westminster)';
END


-- Christian Mahoro (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Christian%'  -- Match first name
    OR p.name LIKE '%Mahoro%'  -- Match last name
    OR p.name = 'Christian Mahoro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 34,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Christian Mahoro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 34, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Christian Mahoro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Christian Mahoro (Jersey #13, Team: Westminster)';
END


-- Dillon Jones (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Dillon%'  -- Match first name
    OR p.name LIKE '%Jones%'  -- Match last name
    OR p.name = 'Dillon Jones'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dillon Jones';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Dillon Jones';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dillon Jones (Jersey #14, Team: Westminster)';
END


-- Sam Bundren (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Sam%'  -- Match first name
    OR p.name LIKE '%Bundren%'  -- Match last name
    OR p.name = 'Sam Bundren'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sam Bundren';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sam Bundren';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sam Bundren (Jersey #15, Team: Westminster)';
END


-- Lucas Cole (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Lucas%'  -- Match first name
    OR p.name LIKE '%Cole%'  -- Match last name
    OR p.name = 'Lucas Cole'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucas Cole';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucas Cole';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucas Cole (Jersey #16, Team: Westminster)';
END


-- Brandon Schaupert (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Brandon%'  -- Match first name
    OR p.name LIKE '%Schaupert%'  -- Match last name
    OR p.name = 'Brandon Schaupert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 51,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brandon Schaupert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 51, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brandon Schaupert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brandon Schaupert (Jersey #17, Team: Westminster)';
END


-- Juan Pico-Vazquez (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Pico-Vazquez%'  -- Match last name
    OR p.name = 'Juan Pico-Vazquez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 35,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Pico-Vazquez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 35, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Pico-Vazquez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Pico-Vazquez (Jersey #18, Team: Westminster)';
END


-- Trey White (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%White%'  -- Match last name
    OR p.name = 'Trey White'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 17,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey White';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 17, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey White';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey White (Jersey #19, Team: Westminster)';
END


-- Parker Murphy (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Parker%'  -- Match first name
    OR p.name LIKE '%Murphy%'  -- Match last name
    OR p.name = 'Parker Murphy'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Parker Murphy';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Parker Murphy';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Parker Murphy (Jersey #20, Team: Westminster)';
END


-- Thomas Kennedy (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Thomas%'  -- Match first name
    OR p.name LIKE '%Kennedy%'  -- Match last name
    OR p.name = 'Thomas Kennedy'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Thomas Kennedy';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Thomas Kennedy';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Thomas Kennedy (Jersey #23, Team: Westminster)';
END


-- Krischan Schulz (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Krischan%'  -- Match first name
    OR p.name LIKE '%Schulz%'  -- Match last name
    OR p.name = 'Krischan Schulz'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Krischan Schulz';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Krischan Schulz';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Krischan Schulz (Jersey #26, Team: Westminster)';
END


-- Owen Harrison (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Owen%'  -- Match first name
    OR p.name LIKE '%Harrison%'  -- Match last name
    OR p.name = 'Owen Harrison'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 47,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Owen Harrison';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Owen Harrison';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Owen Harrison (Jersey #27, Team: Westminster)';
END


-- Lachlan Zetter (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 28
  AND (
    p.name LIKE '%Lachlan%'  -- Match first name
    OR p.name LIKE '%Zetter%'  -- Match last name
    OR p.name = 'Lachlan Zetter'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 17,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lachlan Zetter';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 17, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lachlan Zetter';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lachlan Zetter (Jersey #28, Team: Westminster)';
END


-- Gabriel Rangel (GK) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Gabriel Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 1);
        PRINT '[OK] Inserted stats for Gabriel Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Rangel (Jersey #1, Team: Lyon)';
END


-- Jake Mcmurdo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Jake%'  -- Match first name
    OR p.name LIKE '%Mcmurdo%'  -- Match last name
    OR p.name = 'Jake Mcmurdo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 44,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jake Mcmurdo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 44, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jake Mcmurdo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jake Mcmurdo (Jersey #3, Team: Lyon)';
END


-- Cristian De La Rosa (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Cristian%'  -- Match first name
    OR p.name LIKE '%Rosa%'  -- Match last name
    OR p.name = 'Cristian De La Rosa'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 64,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cristian De La Rosa';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 64, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cristian De La Rosa';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cristian De La Rosa (Jersey #6, Team: Lyon)';
END


-- Matheus Nunes (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Matheus%'  -- Match first name
    OR p.name LIKE '%Nunes%'  -- Match last name
    OR p.name = 'Matheus Nunes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 73,
            Goals = 3,
            Assists = 2,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Matheus Nunes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 73, 3, 2, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Matheus Nunes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Matheus Nunes (Jersey #7, Team: Lyon)';
END


-- Micah Rangel (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Micah Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 47,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Micah Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Rangel (Jersey #8, Team: Lyon)';
END


-- Lucca Torres (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Lucca%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Lucca Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 1,
            Assists = 2,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucca Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 1, 2, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucca Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucca Torres (Jersey #9, Team: Lyon)';
END


-- Joao Barros (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Joao%'  -- Match first name
    OR p.name LIKE '%Barros%'  -- Match last name
    OR p.name = 'Joao Barros'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Joao Barros';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Joao Barros';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Joao Barros (Jersey #10, Team: Lyon)';
END


-- Tiago Donadon (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Tiago%'  -- Match first name
    OR p.name LIKE '%Donadon%'  -- Match last name
    OR p.name = 'Tiago Donadon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 55,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tiago Donadon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 55, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tiago Donadon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tiago Donadon (Jersey #11, Team: Lyon)';
END


-- Tomas Biasi (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Tomas%'  -- Match first name
    OR p.name LIKE '%Biasi%'  -- Match last name
    OR p.name = 'Tomas Biasi'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 72,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tomas Biasi';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 72, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tomas Biasi';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tomas Biasi (Jersey #16, Team: Lyon)';
END


-- Leonardo Bravo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 41
  AND (
    p.name LIKE '%Leonardo%'  -- Match first name
    OR p.name LIKE '%Bravo%'  -- Match last name
    OR p.name = 'Leonardo Bravo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 87,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Leonardo Bravo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 87, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Leonardo Bravo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Leonardo Bravo (Jersey #41, Team: Lyon)';
END


-- Roman Magnanelli (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Roman%'  -- Match first name
    OR p.name LIKE '%Magnanelli%'  -- Match last name
    OR p.name = 'Roman Magnanelli'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Roman Magnanelli';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Roman Magnanelli';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Roman Magnanelli (Jersey #12, Team: Lyon)';
END


-- Traviss Ragan (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Traviss%'  -- Match first name
    OR p.name LIKE '%Ragan%'  -- Match last name
    OR p.name = 'Traviss Ragan'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Traviss Ragan';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Traviss Ragan';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Traviss Ragan (Jersey #14, Team: Lyon)';
END


-- Jacob Harrod (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Jacob%'  -- Match first name
    OR p.name LIKE '%Harrod%'  -- Match last name
    OR p.name = 'Jacob Harrod'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jacob Harrod';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jacob Harrod';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jacob Harrod (Jersey #17, Team: Lyon)';
END


-- Harrison Craig (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Harrison%'  -- Match first name
    OR p.name LIKE '%Craig%'  -- Match last name
    OR p.name = 'Harrison Craig'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Harrison Craig';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Harrison Craig';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Harrison Craig (Jersey #20, Team: Lyon)';
END


-- Inaki Terra (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Inaki%'  -- Match first name
    OR p.name LIKE '%Terra%'  -- Match last name
    OR p.name = 'Inaki Terra'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Inaki Terra';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Inaki Terra';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Inaki Terra (Jersey #22, Team: Lyon)';
END


-- Merrick Luibel (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 24
  AND (
    p.name LIKE '%Merrick%'  -- Match first name
    OR p.name LIKE '%Luibel%'  -- Match last name
    OR p.name = 'Merrick Luibel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Merrick Luibel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Merrick Luibel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Merrick Luibel (Jersey #24, Team: Lyon)';
END


-- Murilo Coelho (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Murilo%'  -- Match first name
    OR p.name LIKE '%Coelho%'  -- Match last name
    OR p.name = 'Murilo Coelho'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Murilo Coelho';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Murilo Coelho';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Murilo Coelho (Jersey #26, Team: Lyon)';
END


-- Ariel Reyes (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Ariel%'  -- Match first name
    OR p.name LIKE '%Reyes%'  -- Match last name
    OR p.name = 'Ariel Reyes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ariel Reyes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ariel Reyes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ariel Reyes (Jersey #27, Team: Lyon)';
END


-- Frederico Ribeiro (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 29
  AND (
    p.name LIKE '%Frederico%'  -- Match first name
    OR p.name LIKE '%Ribeiro%'  -- Match last name
    OR p.name = 'Frederico Ribeiro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Frederico Ribeiro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Frederico Ribeiro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Frederico Ribeiro (Jersey #29, Team: Lyon)';
END


-- Ezra Busby (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Ezra%'  -- Match first name
    OR p.name LIKE '%Busby%'  -- Match last name
    OR p.name = 'Ezra Busby'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ezra Busby';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ezra Busby';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ezra Busby (Jersey #30, Team: Lyon)';
END


-- Samuel Camacho (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 34
  AND (
    p.name LIKE '%Samuel%'  -- Match first name
    OR p.name LIKE '%Camacho%'  -- Match last name
    OR p.name = 'Samuel Camacho'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 14,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Samuel Camacho';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 14, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Samuel Camacho';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Samuel Camacho (Jersey #34, Team: Lyon)';
END


-- Piero Macias (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Piero%'  -- Match first name
    OR p.name LIKE '%Macias%'  -- Match last name
    OR p.name = 'Piero Macias'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 17,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Piero Macias';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 17, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Piero Macias';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Piero Macias (Jersey #35, Team: Lyon)';
END


-- Thomas Larios (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 37
  AND (
    p.name LIKE '%Thomas%'  -- Match first name
    OR p.name LIKE '%Larios%'  -- Match last name
    OR p.name = 'Thomas Larios'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Thomas Larios';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Thomas Larios';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Thomas Larios (Jersey #37, Team: Lyon)';
END


-- =====================================================
-- Complete! Processed 53 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Eureka vs Principia
-- Match Date: 2025-10-04
-- Generated: 2025-11-06 22:09:34
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Principia';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Eureka';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-04')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-04'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Eureka vs Principia';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- James Williams (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%James%'  -- Match first name
    OR p.name LIKE '%Williams%'  -- Match last name
    OR p.name = 'James Williams'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 42,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for James Williams';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 42, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for James Williams';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: James Williams (Jersey #2, Team: Eureka)';
END


-- Walter Medrano (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Walter%'  -- Match first name
    OR p.name LIKE '%Medrano%'  -- Match last name
    OR p.name = 'Walter Medrano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 49,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Walter Medrano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 49, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Walter Medrano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Walter Medrano (Jersey #4, Team: Eureka)';
END


-- Tristan Martinez (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Tristan%'  -- Match first name
    OR p.name LIKE '%Martinez%'  -- Match last name
    OR p.name = 'Tristan Martinez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tristan Martinez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tristan Martinez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tristan Martinez (Jersey #5, Team: Eureka)';
END


-- Jesus Canas (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Jesus%'  -- Match first name
    OR p.name LIKE '%Canas%'  -- Match last name
    OR p.name = 'Jesus Canas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jesus Canas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jesus Canas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jesus Canas (Jersey #7, Team: Eureka)';
END


-- Michael DeCarlo (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%DeCarlo%'  -- Match last name
    OR p.name = 'Michael DeCarlo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael DeCarlo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael DeCarlo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael DeCarlo (Jersey #8, Team: Eureka)';
END


-- Pascal Calonges (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Pascal%'  -- Match first name
    OR p.name LIKE '%Calonges%'  -- Match last name
    OR p.name = 'Pascal Calonges'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 49,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pascal Calonges';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 49, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pascal Calonges';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pascal Calonges (Jersey #11, Team: Eureka)';
END


-- Landon Porch (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Landon%'  -- Match first name
    OR p.name LIKE '%Porch%'  -- Match last name
    OR p.name = 'Landon Porch'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Landon Porch';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Landon Porch';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Landon Porch (Jersey #14, Team: Eureka)';
END


-- Michael Kondilis (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%Kondilis%'  -- Match last name
    OR p.name = 'Michael Kondilis'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 47,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael Kondilis';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 47, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael Kondilis';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael Kondilis (Jersey #17, Team: Eureka)';
END


-- Uli Castaneda (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Uli%'  -- Match first name
    OR p.name LIKE '%Castaneda%'  -- Match last name
    OR p.name = 'Uli Castaneda'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 31,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Uli Castaneda';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 31, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Uli Castaneda';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Uli Castaneda (Jersey #27, Team: Eureka)';
END


-- Leo Mendoza (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 36
  AND (
    p.name LIKE '%Leo%'  -- Match first name
    OR p.name LIKE '%Mendoza%'  -- Match last name
    OR p.name = 'Leo Mendoza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 31,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Leo Mendoza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 31, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Leo Mendoza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Leo Mendoza (Jersey #36, Team: Eureka)';
END


-- Sebastian Torres (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 99
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Sebastian Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 4,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 4
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 4, 0, 4);
        PRINT '[OK] Inserted stats for Sebastian Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Torres (Jersey #99, Team: Eureka)';
END


-- Charles Wyzukovicz (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Charles%'  -- Match first name
    OR p.name LIKE '%Wyzukovicz%'  -- Match last name
    OR p.name = 'Charles Wyzukovicz'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Charles Wyzukovicz';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 1, 0, 0);
        PRINT '[OK] Inserted stats for Charles Wyzukovicz';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Charles Wyzukovicz (Jersey #1, Team: Eureka)';
END


-- Tyler Kramer (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Tyler%'  -- Match first name
    OR p.name LIKE '%Kramer%'  -- Match last name
    OR p.name = 'Tyler Kramer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 37,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tyler Kramer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 37, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tyler Kramer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tyler Kramer (Jersey #12, Team: Eureka)';
END


-- Jovani Zuniga (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jovani%'  -- Match first name
    OR p.name LIKE '%Zuniga%'  -- Match last name
    OR p.name = 'Jovani Zuniga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 55,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jovani Zuniga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 55, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jovani Zuniga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jovani Zuniga (Jersey #13, Team: Eureka)';
END


-- Jacob Adamson (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Jacob%'  -- Match first name
    OR p.name LIKE '%Adamson%'  -- Match last name
    OR p.name = 'Jacob Adamson'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 55,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jacob Adamson';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 55, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jacob Adamson';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jacob Adamson (Jersey #15, Team: Eureka)';
END


-- Owen Peich (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Owen%'  -- Match first name
    OR p.name LIKE '%Peich%'  -- Match last name
    OR p.name = 'Owen Peich'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 23,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Owen Peich';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 23, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Owen Peich';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Owen Peich (Jersey #18, Team: Eureka)';
END


-- Aldo Mora-Lovera (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Aldo%'  -- Match first name
    OR p.name LIKE '%Mora-Lovera%'  -- Match last name
    OR p.name = 'Aldo Mora-Lovera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 30,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Aldo Mora-Lovera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 30, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Aldo Mora-Lovera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Aldo Mora-Lovera (Jersey #21, Team: Eureka)';
END


-- Miguel Núñez (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Miguel%'  -- Match first name
    OR p.name LIKE '%Núñez%'  -- Match last name
    OR p.name = 'Miguel Núñez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Miguel Núñez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Miguel Núñez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Miguel Núñez (Jersey #26, Team: Eureka)';
END


-- Fallilou Ndiaye (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 28
  AND (
    p.name LIKE '%Fallilou%'  -- Match first name
    OR p.name LIKE '%Ndiaye%'  -- Match last name
    OR p.name = 'Fallilou Ndiaye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Fallilou Ndiaye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Fallilou Ndiaye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Fallilou Ndiaye (Jersey #28, Team: Eureka)';
END


-- Raphael Mungu (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 29
  AND (
    p.name LIKE '%Raphael%'  -- Match first name
    OR p.name LIKE '%Mungu%'  -- Match last name
    OR p.name = 'Raphael Mungu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 29,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Raphael Mungu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 29, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Raphael Mungu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Raphael Mungu (Jersey #29, Team: Eureka)';
END


-- Diego Bueno (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Bueno%'  -- Match last name
    OR p.name = 'Diego Bueno'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Bueno';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Bueno';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Bueno (Jersey #30, Team: Eureka)';
END


-- Gabriel Gonzalez (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Gabriel Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabriel Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Gonzalez (Jersey #35, Team: Eureka)';
END


-- Brody Spera (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 40
  AND (
    p.name LIKE '%Brody%'  -- Match first name
    OR p.name LIKE '%Spera%'  -- Match last name
    OR p.name = 'Brody Spera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brody Spera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brody Spera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brody Spera (Jersey #40, Team: Eureka)';
END


-- Oscar Villagrana (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 41
  AND (
    p.name LIKE '%Oscar%'  -- Match first name
    OR p.name LIKE '%Villagrana%'  -- Match last name
    OR p.name = 'Oscar Villagrana'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oscar Villagrana';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oscar Villagrana';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oscar Villagrana (Jersey #41, Team: Eureka)';
END


-- Rafa Ascencio Garcia (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Rafa%'  -- Match first name
    OR p.name LIKE '%Garcia%'  -- Match last name
    OR p.name = 'Rafa Ascencio Garcia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 2
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Rafa Ascencio Garcia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 2);
        PRINT '[OK] Inserted stats for Rafa Ascencio Garcia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Rafa Ascencio Garcia (Jersey #1, Team: Principia)';
END


-- Nacho Cachaza (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Nacho%'  -- Match first name
    OR p.name LIKE '%Cachaza%'  -- Match last name
    OR p.name = 'Nacho Cachaza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nacho Cachaza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nacho Cachaza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nacho Cachaza (Jersey #3, Team: Principia)';
END


-- Sebastian Castro (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Castro%'  -- Match last name
    OR p.name = 'Sebastian Castro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 65,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Castro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 65, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sebastian Castro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Castro (Jersey #5, Team: Principia)';
END


-- Alejandro Liborio (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Alejandro%'  -- Match first name
    OR p.name LIKE '%Liborio%'  -- Match last name
    OR p.name = 'Alejandro Liborio'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 52,
            Goals = 1,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alejandro Liborio';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 52, 1, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alejandro Liborio';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alejandro Liborio (Jersey #9, Team: Principia)';
END


-- Diego Alas (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Alas%'  -- Match last name
    OR p.name = 'Diego Alas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 74,
            Goals = 2,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Alas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 74, 2, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Alas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Alas (Jersey #10, Team: Principia)';
END


-- Wizzy Afrani (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Wizzy%'  -- Match first name
    OR p.name LIKE '%Afrani%'  -- Match last name
    OR p.name = 'Wizzy Afrani'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Wizzy Afrani';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Wizzy Afrani';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Wizzy Afrani (Jersey #11, Team: Principia)';
END


-- Jonathan Keller (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jonathan%'  -- Match first name
    OR p.name LIKE '%Keller%'  -- Match last name
    OR p.name = 'Jonathan Keller'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 51,
            Goals = 2,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonathan Keller';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 51, 2, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonathan Keller';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonathan Keller (Jersey #13, Team: Principia)';
END


-- Juan Garcia Lopez (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Lopez%'  -- Match last name
    OR p.name = 'Juan Garcia Lopez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Garcia Lopez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Garcia Lopez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Garcia Lopez (Jersey #14, Team: Principia)';
END


-- Michael Wanda (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%Wanda%'  -- Match last name
    OR p.name = 'Michael Wanda'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael Wanda';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael Wanda';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael Wanda (Jersey #20, Team: Principia)';
END


-- Diego De Manuel Romero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Romero%'  -- Match last name
    OR p.name = 'Diego De Manuel Romero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego De Manuel Romero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego De Manuel Romero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego De Manuel Romero (Jersey #21, Team: Principia)';
END


-- Cade Pecheck (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Cade%'  -- Match first name
    OR p.name LIKE '%Pecheck%'  -- Match last name
    OR p.name = 'Cade Pecheck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 54,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cade Pecheck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 54, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cade Pecheck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cade Pecheck (Jersey #22, Team: Principia)';
END


-- Ethan Hoff (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Hoff%'  -- Match last name
    OR p.name = 'Ethan Hoff'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 12,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Hoff';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 12, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Hoff';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Hoff (Jersey #2, Team: Principia)';
END


-- Eduardo Salazar (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Eduardo%'  -- Match first name
    OR p.name LIKE '%Salazar%'  -- Match last name
    OR p.name = 'Eduardo Salazar'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 36,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eduardo Salazar';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 36, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eduardo Salazar';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eduardo Salazar (Jersey #6, Team: Principia)';
END


-- Effenberg Joya (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Effenberg%'  -- Match first name
    OR p.name LIKE '%Joya%'  -- Match last name
    OR p.name = 'Effenberg Joya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Effenberg Joya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Effenberg Joya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Effenberg Joya (Jersey #7, Team: Principia)';
END


-- Eziuche Ejimadu (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Eziuche%'  -- Match first name
    OR p.name LIKE '%Ejimadu%'  -- Match last name
    OR p.name = 'Eziuche Ejimadu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eziuche Ejimadu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eziuche Ejimadu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eziuche Ejimadu (Jersey #12, Team: Principia)';
END


-- Damilola Odunuga (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Damilola%'  -- Match first name
    OR p.name LIKE '%Odunuga%'  -- Match last name
    OR p.name = 'Damilola Odunuga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 48,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Damilola Odunuga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 48, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Damilola Odunuga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Damilola Odunuga (Jersey #15, Team: Principia)';
END


-- Kaiky Dos Santos (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Kaiky%'  -- Match first name
    OR p.name LIKE '%Santos%'  -- Match last name
    OR p.name = 'Kaiky Dos Santos'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 13,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kaiky Dos Santos';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 13, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kaiky Dos Santos';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kaiky Dos Santos (Jersey #16, Team: Principia)';
END


-- Nana Koranteng (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nana%'  -- Match first name
    OR p.name LIKE '%Koranteng%'  -- Match last name
    OR p.name = 'Nana Koranteng'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nana Koranteng';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nana Koranteng';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nana Koranteng (Jersey #19, Team: Principia)';
END


-- Amri Seperia (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Amri%'  -- Match first name
    OR p.name LIKE '%Seperia%'  -- Match last name
    OR p.name = 'Amri Seperia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Amri Seperia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Amri Seperia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Amri Seperia (Jersey #23, Team: Principia)';
END


-- Kelvin Kasirye (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Kelvin%'  -- Match first name
    OR p.name LIKE '%Kasirye%'  -- Match last name
    OR p.name = 'Kelvin Kasirye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 27,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kelvin Kasirye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 27, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kelvin Kasirye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kelvin Kasirye (Jersey #25, Team: Principia)';
END


-- Ernesto Botero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 28
  AND (
    p.name LIKE '%Ernesto%'  -- Match first name
    OR p.name LIKE '%Botero%'  -- Match last name
    OR p.name = 'Ernesto Botero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 12,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ernesto Botero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 12, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ernesto Botero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ernesto Botero (Jersey #28, Team: Principia)';
END


-- Edgar Cartagena (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Edgar%'  -- Match first name
    OR p.name LIKE '%Cartagena%'  -- Match last name
    OR p.name = 'Edgar Cartagena'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Edgar Cartagena';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 1);
        PRINT '[OK] Inserted stats for Edgar Cartagena';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Edgar Cartagena (Jersey #30, Team: Principia)';
END


-- =====================================================
-- Complete! Processed 47 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Blackburn vs Spalding
-- Match Date: 2025-10-08
-- Generated: 2025-11-06 22:09:43
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Spalding';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Blackburn';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-08')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-08'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Blackburn vs Spalding';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Yousserf Mahrish (GK) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Yousserf%'  -- Match first name
    OR p.name LIKE '%Mahrish%'  -- Match last name
    OR p.name = 'Yousserf Mahrish'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 3,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 6
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Yousserf Mahrish';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 3, 0, 6);
        PRINT '[OK] Inserted stats for Yousserf Mahrish';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Yousserf Mahrish (Jersey #1, Team: Blackburn)';
END


-- Ty Dyson (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Ty%'  -- Match first name
    OR p.name LIKE '%Dyson%'  -- Match last name
    OR p.name = 'Ty Dyson'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 34,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ty Dyson';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 34, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ty Dyson';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ty Dyson (Jersey #2, Team: Blackburn)';
END


-- Brayden Smith (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Brayden%'  -- Match first name
    OR p.name LIKE '%Smith%'  -- Match last name
    OR p.name = 'Brayden Smith'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 84,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brayden Smith';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 84, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brayden Smith';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brayden Smith (Jersey #3, Team: Blackburn)';
END


-- Gavin Norwood (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Gavin%'  -- Match first name
    OR p.name LIKE '%Norwood%'  -- Match last name
    OR p.name = 'Gavin Norwood'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 33,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gavin Norwood';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 33, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gavin Norwood';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gavin Norwood (Jersey #5, Team: Blackburn)';
END


-- Johnny Perla (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Johnny%'  -- Match first name
    OR p.name LIKE '%Perla%'  -- Match last name
    OR p.name = 'Johnny Perla'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Johnny Perla';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Johnny Perla';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Johnny Perla (Jersey #10, Team: Blackburn)';
END


-- Grant Eugea (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Grant%'  -- Match first name
    OR p.name LIKE '%Eugea%'  -- Match last name
    OR p.name = 'Grant Eugea'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Grant Eugea';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Grant Eugea';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Grant Eugea (Jersey #12, Team: Blackburn)';
END


-- Fredy Paiz (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Fredy%'  -- Match first name
    OR p.name LIKE '%Paiz%'  -- Match last name
    OR p.name = 'Fredy Paiz'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 54,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Fredy Paiz';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 54, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Fredy Paiz';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Fredy Paiz (Jersey #17, Team: Blackburn)';
END


-- Antonio Baca (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Antonio%'  -- Match first name
    OR p.name LIKE '%Baca%'  -- Match last name
    OR p.name = 'Antonio Baca'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Antonio Baca';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Antonio Baca';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Antonio Baca (Jersey #21, Team: Blackburn)';
END


-- Nathan Soto (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Nathan%'  -- Match first name
    OR p.name LIKE '%Soto%'  -- Match last name
    OR p.name = 'Nathan Soto'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 86,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nathan Soto';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 86, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nathan Soto';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nathan Soto (Jersey #26, Team: Blackburn)';
END


-- Corbin Bochinski (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 55
  AND (
    p.name LIKE '%Corbin%'  -- Match first name
    OR p.name LIKE '%Bochinski%'  -- Match last name
    OR p.name = 'Corbin Bochinski'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 33,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Corbin Bochinski';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 33, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Corbin Bochinski';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Corbin Bochinski (Jersey #55, Team: Blackburn)';
END


-- Abner Portillo (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Abner%'  -- Match first name
    OR p.name LIKE '%Portillo%'  -- Match last name
    OR p.name = 'Abner Portillo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 48,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Abner Portillo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 48, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Abner Portillo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Abner Portillo (Jersey #4, Team: Blackburn)';
END


-- Cristian Cazares (FWD) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Cristian%'  -- Match first name
    OR p.name LIKE '%Cazares%'  -- Match last name
    OR p.name = 'Cristian Cazares'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cristian Cazares';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cristian Cazares';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cristian Cazares (Jersey #13, Team: Blackburn)';
END


-- Fabian Perez (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Fabian%'  -- Match first name
    OR p.name LIKE '%Perez%'  -- Match last name
    OR p.name = 'Fabian Perez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 24,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Fabian Perez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 24, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Fabian Perez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Fabian Perez (Jersey #15, Team: Blackburn)';
END


-- Byron McNeil (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 24
  AND (
    p.name LIKE '%Byron%'  -- Match first name
    OR p.name LIKE '%McNeil%'  -- Match last name
    OR p.name = 'Byron McNeil'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 65,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Byron McNeil';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 65, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Byron McNeil';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Byron McNeil (Jersey #24, Team: Blackburn)';
END


-- Kendrik Troutt (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Kendrik%'  -- Match first name
    OR p.name LIKE '%Troutt%'  -- Match last name
    OR p.name = 'Kendrik Troutt'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kendrik Troutt';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kendrik Troutt';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kendrik Troutt (Jersey #27, Team: Blackburn)';
END


-- Axel Gutierrez (DEF) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 32
  AND (
    p.name LIKE '%Axel%'  -- Match first name
    OR p.name LIKE '%Gutierrez%'  -- Match last name
    OR p.name = 'Axel Gutierrez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 28,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Axel Gutierrez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 28, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Axel Gutierrez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Axel Gutierrez (Jersey #32, Team: Blackburn)';
END


-- Adrian Castillo (MID) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 38
  AND (
    p.name LIKE '%Adrian%'  -- Match first name
    OR p.name LIKE '%Castillo%'  -- Match last name
    OR p.name = 'Adrian Castillo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 68,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Adrian Castillo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 68, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Adrian Castillo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Adrian Castillo (Jersey #38, Team: Blackburn)';
END


-- Micah Mattes (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Mattes%'  -- Match last name
    OR p.name = 'Micah Mattes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Mattes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 2, 0, 3);
        PRINT '[OK] Inserted stats for Micah Mattes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Mattes (Jersey #0, Team: Spalding)';
END


-- Oliver Frankenfeld (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Oliver%'  -- Match first name
    OR p.name LIKE '%Frankenfeld%'  -- Match last name
    OR p.name = 'Oliver Frankenfeld'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oliver Frankenfeld';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oliver Frankenfeld';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oliver Frankenfeld (Jersey #3, Team: Spalding)';
END


-- Jose Huerta (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Jose%'  -- Match first name
    OR p.name LIKE '%Huerta%'  -- Match last name
    OR p.name = 'Jose Huerta'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jose Huerta';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jose Huerta';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jose Huerta (Jersey #4, Team: Spalding)';
END


-- Ethan Welsh (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Welsh%'  -- Match last name
    OR p.name = 'Ethan Welsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 50,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Welsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 50, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Welsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Welsh (Jersey #6, Team: Spalding)';
END


-- Marlon Amaya (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Marlon%'  -- Match first name
    OR p.name LIKE '%Amaya%'  -- Match last name
    OR p.name = 'Marlon Amaya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 2,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Marlon Amaya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 2, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Marlon Amaya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Marlon Amaya (Jersey #10, Team: Spalding)';
END


-- Forte Bess (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Forte%'  -- Match first name
    OR p.name LIKE '%Bess%'  -- Match last name
    OR p.name = 'Forte Bess'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 73,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Forte Bess';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 73, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Forte Bess';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Forte Bess (Jersey #11, Team: Spalding)';
END


-- Nolan Thomas (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nolan%'  -- Match first name
    OR p.name LIKE '%Thomas%'  -- Match last name
    OR p.name = 'Nolan Thomas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nolan Thomas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nolan Thomas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nolan Thomas (Jersey #19, Team: Spalding)';
END


-- Carter Payne (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Carter%'  -- Match first name
    OR p.name LIKE '%Payne%'  -- Match last name
    OR p.name = 'Carter Payne'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 87,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carter Payne';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 87, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carter Payne';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carter Payne (Jersey #21, Team: Spalding)';
END


-- Kevin Mulume (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Kevin%'  -- Match first name
    OR p.name LIKE '%Mulume%'  -- Match last name
    OR p.name = 'Kevin Mulume'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kevin Mulume';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kevin Mulume';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kevin Mulume (Jersey #22, Team: Spalding)';
END


-- Trey McCoomer (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%McCoomer%'  -- Match last name
    OR p.name = 'Trey McCoomer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey McCoomer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey McCoomer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey McCoomer (Jersey #23, Team: Spalding)';
END


-- Mack Calvert (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Mack%'  -- Match first name
    OR p.name LIKE '%Calvert%'  -- Match last name
    OR p.name = 'Mack Calvert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Mack Calvert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Mack Calvert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Mack Calvert (Jersey #2, Team: Spalding)';
END


-- Jonatan De La Rosa Soriano (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Jonatan%'  -- Match first name
    OR p.name LIKE '%Soriano%'  -- Match last name
    OR p.name = 'Jonatan De La Rosa Soriano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 36,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonatan De La Rosa Soriano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 36, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonatan De La Rosa Soriano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonatan De La Rosa Soriano (Jersey #5, Team: Spalding)';
END


-- Benit Mulume (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Benit%'  -- Match first name
    OR p.name LIKE '%Mulume%'  -- Match last name
    OR p.name = 'Benit Mulume'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Benit Mulume';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Benit Mulume';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Benit Mulume (Jersey #17, Team: Spalding)';
END


-- Jamie Seago (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Jamie%'  -- Match first name
    OR p.name LIKE '%Seago%'  -- Match last name
    OR p.name = 'Jamie Seago'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 14,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jamie Seago';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 14, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jamie Seago';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jamie Seago (Jersey #18, Team: Spalding)';
END


-- =====================================================
-- Complete! Processed 33 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Westminster vs Webster
-- Match Date: 2025-10-08
-- Generated: 2025-11-06 22:09:55
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Webster';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Westminster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-08')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-08'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Westminster vs Webster';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Hunter Deeken (GK) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Hunter%'  -- Match first name
    OR p.name LIKE '%Deeken%'  -- Match last name
    OR p.name = 'Hunter Deeken'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 7
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hunter Deeken';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 7);
        PRINT '[OK] Inserted stats for Hunter Deeken';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hunter Deeken (Jersey #0, Team: Westminster)';
END


-- Brayden Eckelkamp (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Brayden%'  -- Match first name
    OR p.name LIKE '%Eckelkamp%'  -- Match last name
    OR p.name = 'Brayden Eckelkamp'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brayden Eckelkamp';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brayden Eckelkamp';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brayden Eckelkamp (Jersey #2, Team: Westminster)';
END


-- Lucas Sottile (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Lucas%'  -- Match first name
    OR p.name LIKE '%Sottile%'  -- Match last name
    OR p.name = 'Lucas Sottile'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucas Sottile';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucas Sottile';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucas Sottile (Jersey #7, Team: Westminster)';
END


-- Noah Naumann (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Noah%'  -- Match first name
    OR p.name LIKE '%Naumann%'  -- Match last name
    OR p.name = 'Noah Naumann'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Noah Naumann';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Noah Naumann';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Noah Naumann (Jersey #10, Team: Westminster)';
END


-- Khamani Matallah (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Khamani%'  -- Match first name
    OR p.name LIKE '%Matallah%'  -- Match last name
    OR p.name = 'Khamani Matallah'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 29,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Khamani Matallah';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 29, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Khamani Matallah';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Khamani Matallah (Jersey #11, Team: Westminster)';
END


-- Brandon Schaupert (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Brandon%'  -- Match first name
    OR p.name LIKE '%Schaupert%'  -- Match last name
    OR p.name = 'Brandon Schaupert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 71,
            Goals = 1,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brandon Schaupert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 71, 1, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brandon Schaupert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brandon Schaupert (Jersey #17, Team: Westminster)';
END


-- Evan Schmitt (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Evan%'  -- Match first name
    OR p.name LIKE '%Schmitt%'  -- Match last name
    OR p.name = 'Evan Schmitt'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 88,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Evan Schmitt';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 88, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Evan Schmitt';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Evan Schmitt (Jersey #21, Team: Westminster)';
END


-- Braedon Cairer (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Braedon%'  -- Match first name
    OR p.name LIKE '%Cairer%'  -- Match last name
    OR p.name = 'Braedon Cairer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Braedon Cairer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Braedon Cairer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Braedon Cairer (Jersey #25, Team: Westminster)';
END


-- Krischan Schulz (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Krischan%'  -- Match first name
    OR p.name LIKE '%Schulz%'  -- Match last name
    OR p.name = 'Krischan Schulz'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Krischan Schulz';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Krischan Schulz';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Krischan Schulz (Jersey #26, Team: Westminster)';
END


-- Kyle Bonck (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Bonck%'  -- Match last name
    OR p.name = 'Kyle Bonck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Bonck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Bonck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Bonck (Jersey #30, Team: Westminster)';
END


-- Matthew Garrone (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Matthew%'  -- Match first name
    OR p.name LIKE '%Garrone%'  -- Match last name
    OR p.name = 'Matthew Garrone'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 17,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Matthew Garrone';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 17, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Matthew Garrone';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Matthew Garrone (Jersey #6, Team: Westminster)';
END


-- Blessing Kahiya (MID) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Blessing%'  -- Match first name
    OR p.name LIKE '%Kahiya%'  -- Match last name
    OR p.name = 'Blessing Kahiya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Blessing Kahiya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Blessing Kahiya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Blessing Kahiya (Jersey #8, Team: Westminster)';
END


-- Nathan Naumann (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Nathan%'  -- Match first name
    OR p.name LIKE '%Naumann%'  -- Match last name
    OR p.name = 'Nathan Naumann'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 31,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nathan Naumann';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 31, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nathan Naumann';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nathan Naumann (Jersey #9, Team: Westminster)';
END


-- Sam Bundren (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Sam%'  -- Match first name
    OR p.name LIKE '%Bundren%'  -- Match last name
    OR p.name = 'Sam Bundren'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 28,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sam Bundren';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 28, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sam Bundren';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sam Bundren (Jersey #15, Team: Westminster)';
END


-- Juan Pico-Vazquez (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Pico-Vazquez%'  -- Match last name
    OR p.name = 'Juan Pico-Vazquez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 8,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Pico-Vazquez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 8, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Pico-Vazquez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Pico-Vazquez (Jersey #18, Team: Westminster)';
END


-- Parker Murphy (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Parker%'  -- Match first name
    OR p.name LIKE '%Murphy%'  -- Match last name
    OR p.name = 'Parker Murphy'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 30,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Parker Murphy';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 30, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Parker Murphy';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Parker Murphy (Jersey #20, Team: Westminster)';
END


-- Owen Harrison (DEF) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Owen%'  -- Match first name
    OR p.name LIKE '%Harrison%'  -- Match last name
    OR p.name = 'Owen Harrison'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Owen Harrison';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Owen Harrison';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Owen Harrison (Jersey #27, Team: Westminster)';
END


-- Lachlan Zetter (FWD) - Westminster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Westminster'
  AND p.playerNum = 28
  AND (
    p.name LIKE '%Lachlan%'  -- Match first name
    OR p.name LIKE '%Zetter%'  -- Match last name
    OR p.name = 'Lachlan Zetter'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 18,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lachlan Zetter';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 18, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lachlan Zetter';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lachlan Zetter (Jersey #28, Team: Westminster)';
END


-- Charlie Leahy (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Charlie%'  -- Match first name
    OR p.name LIKE '%Leahy%'  -- Match last name
    OR p.name = 'Charlie Leahy'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 3,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Charlie Leahy';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 3, 0, 1);
        PRINT '[OK] Inserted stats for Charlie Leahy';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Charlie Leahy (Jersey #0, Team: Webster)';
END


-- Ian Meyer (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Ian%'  -- Match first name
    OR p.name LIKE '%Meyer%'  -- Match last name
    OR p.name = 'Ian Meyer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ian Meyer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ian Meyer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ian Meyer (Jersey #3, Team: Webster)';
END


-- Finn Rohl (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Finn%'  -- Match first name
    OR p.name LIKE '%Rohl%'  -- Match last name
    OR p.name = 'Finn Rohl'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Finn Rohl';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Finn Rohl';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Finn Rohl (Jersey #11, Team: Webster)';
END


-- Danny Nusinovic (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Nusinovic%'  -- Match last name
    OR p.name = 'Danny Nusinovic'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 67,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Nusinovic';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 67, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Danny Nusinovic';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Nusinovic (Jersey #16, Team: Webster)';
END


-- Scott Price (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Scott%'  -- Match first name
    OR p.name LIKE '%Price%'  -- Match last name
    OR p.name = 'Scott Price'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Scott Price';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Scott Price';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Scott Price (Jersey #17, Team: Webster)';
END


-- Alberto Duque Gonzalez (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Alberto%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Alberto Duque Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alberto Duque Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alberto Duque Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alberto Duque Gonzalez (Jersey #26, Team: Webster)';
END


-- Luke Walsh (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Walsh%'  -- Match last name
    OR p.name = 'Luke Walsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Walsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Walsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Walsh (Jersey #2, Team: Webster)';
END


-- Elmin Lemes (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Elmin%'  -- Match first name
    OR p.name LIKE '%Lemes%'  -- Match last name
    OR p.name = 'Elmin Lemes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 29,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Elmin Lemes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 29, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Elmin Lemes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Elmin Lemes (Jersey #10, Team: Webster)';
END


-- Hayden Hatley (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Hayden%'  -- Match first name
    OR p.name LIKE '%Hatley%'  -- Match last name
    OR p.name = 'Hayden Hatley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 58,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hayden Hatley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 58, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hayden Hatley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hayden Hatley (Jersey #20, Team: Webster)';
END


-- =====================================================
-- Complete! Processed 37 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Lyon vs Eureka
-- Match Date: 2025-10-09
-- Generated: 2025-11-06 22:09:59
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Eureka';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Lyon';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-09')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-09'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Lyon vs Eureka';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Gabriel Rangel (GK) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Gabriel Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabriel Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Rangel (Jersey #1, Team: Lyon)';
END


-- Xavier Brisbon (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Xavier%'  -- Match first name
    OR p.name LIKE '%Brisbon%'  -- Match last name
    OR p.name = 'Xavier Brisbon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 4,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 10
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Xavier Brisbon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 4, 0, 10);
        PRINT '[OK] Inserted stats for Xavier Brisbon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Xavier Brisbon (Jersey #0, Team: Eureka)';
END


-- =====================================================
-- Complete! Processed 41 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Spalding vs Eureka
-- Match Date: 2025-10-11
-- Generated: 2025-11-06 22:10:01
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Eureka';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Spalding';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-11')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-11'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Spalding vs Eureka';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Micah Mattes (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Mattes%'  -- Match last name
    OR p.name = 'Micah Mattes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 74,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 4,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 2
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Mattes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 74, 0, 0, 0, 0, 0, 4, 0, 2);
        PRINT '[OK] Inserted stats for Micah Mattes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Mattes (Jersey #0, Team: Spalding)';
END


-- Gabe Brangers (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabe%'  -- Match first name
    OR p.name LIKE '%Brangers%'  -- Match last name
    OR p.name = 'Gabe Brangers'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabe Brangers';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 1);
        PRINT '[OK] Inserted stats for Gabe Brangers';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabe Brangers (Jersey #1, Team: Spalding)';
END


-- Xavier Brisbon (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Xavier%'  -- Match first name
    OR p.name LIKE '%Brisbon%'  -- Match last name
    OR p.name = 'Xavier Brisbon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 80,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 4
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Xavier Brisbon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 80, 0, 0, 0, 0, 0, 0, 0, 4);
        PRINT '[OK] Inserted stats for Xavier Brisbon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Xavier Brisbon (Jersey #0, Team: Eureka)';
END


-- Brayton Strawkas (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 55
  AND (
    p.name LIKE '%Brayton%'  -- Match first name
    OR p.name LIKE '%Strawkas%'  -- Match last name
    OR p.name = 'Brayton Strawkas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brayton Strawkas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 1, 0, 0, 1, 0, 0);
        PRINT '[OK] Inserted stats for Brayton Strawkas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brayton Strawkas (Jersey #55, Team: Eureka)';
END


-- =====================================================
-- Complete! Processed 44 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Lyon vs Blackburn
-- Match Date: 2025-10-11
-- Generated: 2025-11-06 22:10:02
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Blackburn';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Lyon';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-11')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-11'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Lyon vs Blackburn';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Gabriel Rangel (GK) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Gabriel Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 8
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 8);
        PRINT '[OK] Inserted stats for Gabriel Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Rangel (Jersey #1, Team: Lyon)';
END


-- Juan Vargas (GK) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Vargas%'  -- Match last name
    OR p.name = 'Juan Vargas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 7
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Vargas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 7);
        PRINT '[OK] Inserted stats for Juan Vargas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Vargas (Jersey #0, Team: Blackburn)';
END


-- =====================================================
-- Complete! Processed 39 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Greenville vs MUW
-- Match Date: 2025-10-11
-- Generated: 2025-11-06 22:10:05
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'MUW';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Greenville';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-11')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-11'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Greenville vs MUW';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Carlos Ziesecke (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Carlos%'  -- Match first name
    OR p.name LIKE '%Ziesecke%'  -- Match last name
    OR p.name = 'Carlos Ziesecke'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carlos Ziesecke';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carlos Ziesecke';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carlos Ziesecke (Jersey #3, Team: Greenville)';
END


-- Ben Wilcoxen (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Ben%'  -- Match first name
    OR p.name LIKE '%Wilcoxen%'  -- Match last name
    OR p.name = 'Ben Wilcoxen'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ben Wilcoxen';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ben Wilcoxen';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ben Wilcoxen (Jersey #5, Team: Greenville)';
END


-- Gabriel Sule (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Sule%'  -- Match last name
    OR p.name = 'Gabriel Sule'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 86,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Sule';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 86, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabriel Sule';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Sule (Jersey #10, Team: Greenville)';
END


-- Dominick Messer (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Dominick%'  -- Match first name
    OR p.name LIKE '%Messer%'  -- Match last name
    OR p.name = 'Dominick Messer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dominick Messer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 0);
        PRINT '[OK] Inserted stats for Dominick Messer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dominick Messer (Jersey #12, Team: Greenville)';
END


-- Izan Gonzalez Rivera (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Izan%'  -- Match first name
    OR p.name LIKE '%Rivera%'  -- Match last name
    OR p.name = 'Izan Gonzalez Rivera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 82,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Izan Gonzalez Rivera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 82, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Izan Gonzalez Rivera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Izan Gonzalez Rivera (Jersey #17, Team: Greenville)';
END


-- Richard Kerwer (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Richard%'  -- Match first name
    OR p.name LIKE '%Kerwer%'  -- Match last name
    OR p.name = 'Richard Kerwer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Richard Kerwer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Richard Kerwer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Richard Kerwer (Jersey #18, Team: Greenville)';
END


-- Andres Garcia (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Andres%'  -- Match first name
    OR p.name LIKE '%Garcia%'  -- Match last name
    OR p.name = 'Andres Garcia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Andres Garcia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Andres Garcia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Andres Garcia (Jersey #20, Team: Greenville)';
END


-- Will Malone (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 54
  AND (
    p.name LIKE '%Will%'  -- Match first name
    OR p.name LIKE '%Malone%'  -- Match last name
    OR p.name = 'Will Malone'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 51,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Will Malone';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 51, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Will Malone';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Will Malone (Jersey #54, Team: Greenville)';
END


-- Samuel Paez (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Samuel%'  -- Match first name
    OR p.name LIKE '%Paez%'  -- Match last name
    OR p.name = 'Samuel Paez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Samuel Paez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Samuel Paez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Samuel Paez (Jersey #6, Team: Greenville)';
END


-- Braulio Martinez (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Braulio%'  -- Match first name
    OR p.name LIKE '%Martinez%'  -- Match last name
    OR p.name = 'Braulio Martinez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Braulio Martinez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Braulio Martinez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Braulio Martinez (Jersey #9, Team: Greenville)';
END


-- Gerardo Alarcon (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Gerardo%'  -- Match first name
    OR p.name LIKE '%Alarcon%'  -- Match last name
    OR p.name = 'Gerardo Alarcon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gerardo Alarcon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gerardo Alarcon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gerardo Alarcon (Jersey #30, Team: Greenville)';
END


-- Pablo Canola (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 34
  AND (
    p.name LIKE '%Pablo%'  -- Match first name
    OR p.name LIKE '%Canola%'  -- Match last name
    OR p.name = 'Pablo Canola'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pablo Canola';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pablo Canola';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pablo Canola (Jersey #34, Team: Greenville)';
END


-- Cole Crawford (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Cole%'  -- Match first name
    OR p.name LIKE '%Crawford%'  -- Match last name
    OR p.name = 'Cole Crawford'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cole Crawford';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cole Crawford';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cole Crawford (Jersey #4, Team: MUW)';
END


-- Kyle Morris (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Morris%'  -- Match last name
    OR p.name = 'Kyle Morris'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Morris';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Morris';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Morris (Jersey #14, Team: MUW)';
END


-- Ethan Barnes (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Barnes%'  -- Match last name
    OR p.name = 'Ethan Barnes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 29,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Barnes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 29, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Barnes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Barnes (Jersey #16, Team: MUW)';
END


-- Luke Bradley (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Bradley%'  -- Match last name
    OR p.name = 'Luke Bradley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Bradley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Bradley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Bradley (Jersey #19, Team: MUW)';
END


-- Trey Parnell (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%Parnell%'  -- Match last name
    OR p.name = 'Trey Parnell'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey Parnell';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey Parnell';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey Parnell (Jersey #22, Team: MUW)';
END


-- Juan Puga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Puga%'  -- Match last name
    OR p.name = 'Juan Puga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 82,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Puga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 82, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Puga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Puga (Jersey #27, Team: MUW)';
END


-- Drew Pack (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Drew%'  -- Match first name
    OR p.name LIKE '%Pack%'  -- Match last name
    OR p.name = 'Drew Pack'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 28,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Drew Pack';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 28, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Drew Pack';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Drew Pack (Jersey #3, Team: MUW)';
END


-- Dilyn Arnold (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Dilyn%'  -- Match first name
    OR p.name LIKE '%Arnold%'  -- Match last name
    OR p.name = 'Dilyn Arnold'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 61,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dilyn Arnold';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 61, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Dilyn Arnold';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dilyn Arnold (Jersey #15, Team: MUW)';
END


-- =====================================================
-- Complete! Processed 35 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Principia vs Webster
-- Match Date: 2025-10-11
-- Generated: 2025-11-06 22:10:08
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Webster';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Principia';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-11')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-11'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Principia vs Webster';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Nacho Cachaza (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Nacho%'  -- Match first name
    OR p.name LIKE '%Cachaza%'  -- Match last name
    OR p.name = 'Nacho Cachaza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nacho Cachaza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nacho Cachaza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nacho Cachaza (Jersey #3, Team: Principia)';
END


-- Sebastian Castro (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Castro%'  -- Match last name
    OR p.name = 'Sebastian Castro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 71,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Castro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 71, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sebastian Castro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Castro (Jersey #5, Team: Principia)';
END


-- Alejandro Liborio (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Alejandro%'  -- Match first name
    OR p.name LIKE '%Liborio%'  -- Match last name
    OR p.name = 'Alejandro Liborio'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 76,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alejandro Liborio';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 76, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alejandro Liborio';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alejandro Liborio (Jersey #9, Team: Principia)';
END


-- Diego Alas (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Alas%'  -- Match last name
    OR p.name = 'Diego Alas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Alas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Alas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Alas (Jersey #10, Team: Principia)';
END


-- Wizzy Afrani (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Wizzy%'  -- Match first name
    OR p.name LIKE '%Afrani%'  -- Match last name
    OR p.name = 'Wizzy Afrani'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 67,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Wizzy Afrani';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 67, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Wizzy Afrani';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Wizzy Afrani (Jersey #11, Team: Principia)';
END


-- Jonathan Keller (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jonathan%'  -- Match first name
    OR p.name LIKE '%Keller%'  -- Match last name
    OR p.name = 'Jonathan Keller'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 56,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonathan Keller';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 56, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonathan Keller';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonathan Keller (Jersey #13, Team: Principia)';
END


-- Juan Garcia Lopez (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Lopez%'  -- Match last name
    OR p.name = 'Juan Garcia Lopez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Garcia Lopez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Garcia Lopez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Garcia Lopez (Jersey #14, Team: Principia)';
END


-- Michael Wanda (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%Wanda%'  -- Match last name
    OR p.name = 'Michael Wanda'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael Wanda';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael Wanda';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael Wanda (Jersey #20, Team: Principia)';
END


-- Diego De Manuel Romero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Romero%'  -- Match last name
    OR p.name = 'Diego De Manuel Romero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 44,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego De Manuel Romero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 44, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego De Manuel Romero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego De Manuel Romero (Jersey #21, Team: Principia)';
END


-- Cade Pecheck (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Cade%'  -- Match first name
    OR p.name LIKE '%Pecheck%'  -- Match last name
    OR p.name = 'Cade Pecheck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 79,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cade Pecheck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 79, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cade Pecheck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cade Pecheck (Jersey #22, Team: Principia)';
END


-- Edgar Cartagena (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Edgar%'  -- Match first name
    OR p.name LIKE '%Cartagena%'  -- Match last name
    OR p.name = 'Edgar Cartagena'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 3,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Edgar Cartagena';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 3, 0, 3);
        PRINT '[OK] Inserted stats for Edgar Cartagena';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Edgar Cartagena (Jersey #30, Team: Principia)';
END


-- Effenberg Joya (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Effenberg%'  -- Match first name
    OR p.name LIKE '%Joya%'  -- Match last name
    OR p.name = 'Effenberg Joya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 3,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Effenberg Joya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 3, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Effenberg Joya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Effenberg Joya (Jersey #7, Team: Principia)';
END


-- Eziuche Ejimadu (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Eziuche%'  -- Match first name
    OR p.name LIKE '%Ejimadu%'  -- Match last name
    OR p.name = 'Eziuche Ejimadu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 16,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eziuche Ejimadu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 16, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eziuche Ejimadu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eziuche Ejimadu (Jersey #12, Team: Principia)';
END


-- Damilola Odunuga (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Damilola%'  -- Match first name
    OR p.name LIKE '%Odunuga%'  -- Match last name
    OR p.name = 'Damilola Odunuga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 35,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Damilola Odunuga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 35, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Damilola Odunuga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Damilola Odunuga (Jersey #15, Team: Principia)';
END


-- Nana Koranteng (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nana%'  -- Match first name
    OR p.name LIKE '%Koranteng%'  -- Match last name
    OR p.name = 'Nana Koranteng'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 58,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nana Koranteng';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 58, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nana Koranteng';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nana Koranteng (Jersey #19, Team: Principia)';
END


-- Kelvin Kasirye (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Kelvin%'  -- Match first name
    OR p.name LIKE '%Kasirye%'  -- Match last name
    OR p.name = 'Kelvin Kasirye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kelvin Kasirye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kelvin Kasirye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kelvin Kasirye (Jersey #25, Team: Principia)';
END


-- Luke Dillon (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Dillon%'  -- Match last name
    OR p.name = 'Luke Dillon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Dillon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 5);
        PRINT '[OK] Inserted stats for Luke Dillon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Dillon (Jersey #1, Team: Webster)';
END


-- Luke Walsh (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Walsh%'  -- Match last name
    OR p.name = 'Luke Walsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 82,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Walsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 82, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Walsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Walsh (Jersey #2, Team: Webster)';
END


-- Ian Meyer (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Ian%'  -- Match first name
    OR p.name LIKE '%Meyer%'  -- Match last name
    OR p.name = 'Ian Meyer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ian Meyer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ian Meyer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ian Meyer (Jersey #3, Team: Webster)';
END


-- Danny Nusinovic (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Nusinovic%'  -- Match last name
    OR p.name = 'Danny Nusinovic'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Nusinovic';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Danny Nusinovic';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Nusinovic (Jersey #16, Team: Webster)';
END


-- Scott Price (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Scott%'  -- Match first name
    OR p.name LIKE '%Price%'  -- Match last name
    OR p.name = 'Scott Price'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Scott Price';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Scott Price';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Scott Price (Jersey #17, Team: Webster)';
END


-- Hayden Hatley (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Hayden%'  -- Match first name
    OR p.name LIKE '%Hatley%'  -- Match last name
    OR p.name = 'Hayden Hatley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 67,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hayden Hatley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 67, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hayden Hatley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hayden Hatley (Jersey #20, Team: Webster)';
END


-- Alberto Duque Gonzalez (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Alberto%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Alberto Duque Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 75,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alberto Duque Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 75, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alberto Duque Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alberto Duque Gonzalez (Jersey #26, Team: Webster)';
END


-- Elmin Lemes (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Elmin%'  -- Match first name
    OR p.name LIKE '%Lemes%'  -- Match last name
    OR p.name = 'Elmin Lemes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 43,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Elmin Lemes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 43, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Elmin Lemes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Elmin Lemes (Jersey #10, Team: Webster)';
END


-- Finn Rohl (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Finn%'  -- Match first name
    OR p.name LIKE '%Rohl%'  -- Match last name
    OR p.name = 'Finn Rohl'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 12,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Finn Rohl';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 12, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Finn Rohl';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Finn Rohl (Jersey #11, Team: Webster)';
END


-- =====================================================
-- Complete! Processed 37 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Principia vs Spalding
-- Match Date: 2025-10-14
-- Generated: 2025-11-06 22:10:10
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Spalding';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Principia';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-14')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-14'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Principia vs Spalding';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Nacho Cachaza (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Nacho%'  -- Match first name
    OR p.name LIKE '%Cachaza%'  -- Match last name
    OR p.name = 'Nacho Cachaza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nacho Cachaza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nacho Cachaza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nacho Cachaza (Jersey #3, Team: Principia)';
END


-- Sebastian Castro (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Castro%'  -- Match last name
    OR p.name = 'Sebastian Castro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Castro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sebastian Castro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Castro (Jersey #5, Team: Principia)';
END


-- Effenberg Joya (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Effenberg%'  -- Match first name
    OR p.name LIKE '%Joya%'  -- Match last name
    OR p.name = 'Effenberg Joya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 74,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Effenberg Joya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 74, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Effenberg Joya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Effenberg Joya (Jersey #7, Team: Principia)';
END


-- Diego Alas (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Alas%'  -- Match last name
    OR p.name = 'Diego Alas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 76,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Alas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 76, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Alas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Alas (Jersey #10, Team: Principia)';
END


-- Wizzy Afrani (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Wizzy%'  -- Match first name
    OR p.name LIKE '%Afrani%'  -- Match last name
    OR p.name = 'Wizzy Afrani'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Wizzy Afrani';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Wizzy Afrani';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Wizzy Afrani (Jersey #11, Team: Principia)';
END


-- Jonathan Keller (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jonathan%'  -- Match first name
    OR p.name LIKE '%Keller%'  -- Match last name
    OR p.name = 'Jonathan Keller'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonathan Keller';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonathan Keller';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonathan Keller (Jersey #13, Team: Principia)';
END


-- Juan Garcia Lopez (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Lopez%'  -- Match last name
    OR p.name = 'Juan Garcia Lopez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Garcia Lopez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Garcia Lopez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Garcia Lopez (Jersey #14, Team: Principia)';
END


-- Nana Koranteng (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nana%'  -- Match first name
    OR p.name LIKE '%Koranteng%'  -- Match last name
    OR p.name = 'Nana Koranteng'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 43,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nana Koranteng';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 43, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nana Koranteng';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nana Koranteng (Jersey #19, Team: Principia)';
END


-- Diego De Manuel Romero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Romero%'  -- Match last name
    OR p.name = 'Diego De Manuel Romero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 61,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego De Manuel Romero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 61, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego De Manuel Romero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego De Manuel Romero (Jersey #21, Team: Principia)';
END


-- Cade Pecheck (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Cade%'  -- Match first name
    OR p.name LIKE '%Pecheck%'  -- Match last name
    OR p.name = 'Cade Pecheck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cade Pecheck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cade Pecheck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cade Pecheck (Jersey #22, Team: Principia)';
END


-- Edgar Cartagena (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Edgar%'  -- Match first name
    OR p.name LIKE '%Cartagena%'  -- Match last name
    OR p.name = 'Edgar Cartagena'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Edgar Cartagena';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 0);
        PRINT '[OK] Inserted stats for Edgar Cartagena';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Edgar Cartagena (Jersey #30, Team: Principia)';
END


-- Eduardo Salazar (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Eduardo%'  -- Match first name
    OR p.name LIKE '%Salazar%'  -- Match last name
    OR p.name = 'Eduardo Salazar'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 25,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eduardo Salazar';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 25, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eduardo Salazar';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eduardo Salazar (Jersey #6, Team: Principia)';
END


-- Eziuche Ejimadu (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Eziuche%'  -- Match first name
    OR p.name LIKE '%Ejimadu%'  -- Match last name
    OR p.name = 'Eziuche Ejimadu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 26,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eziuche Ejimadu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 26, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eziuche Ejimadu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eziuche Ejimadu (Jersey #12, Team: Principia)';
END


-- Damilola Odunuga (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Damilola%'  -- Match first name
    OR p.name LIKE '%Odunuga%'  -- Match last name
    OR p.name = 'Damilola Odunuga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 21,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Damilola Odunuga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 21, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Damilola Odunuga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Damilola Odunuga (Jersey #15, Team: Principia)';
END


-- Kelvin Kasirye (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Kelvin%'  -- Match first name
    OR p.name LIKE '%Kasirye%'  -- Match last name
    OR p.name = 'Kelvin Kasirye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kelvin Kasirye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kelvin Kasirye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kelvin Kasirye (Jersey #25, Team: Principia)';
END


-- Micah Mattes (GK) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Mattes%'  -- Match last name
    OR p.name = 'Micah Mattes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Mattes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 3);
        PRINT '[OK] Inserted stats for Micah Mattes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Mattes (Jersey #0, Team: Spalding)';
END


-- Oliver Frankenfeld (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Oliver%'  -- Match first name
    OR p.name LIKE '%Frankenfeld%'  -- Match last name
    OR p.name = 'Oliver Frankenfeld'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oliver Frankenfeld';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oliver Frankenfeld';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oliver Frankenfeld (Jersey #3, Team: Spalding)';
END


-- Jose Huerta (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Jose%'  -- Match first name
    OR p.name LIKE '%Huerta%'  -- Match last name
    OR p.name = 'Jose Huerta'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jose Huerta';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jose Huerta';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jose Huerta (Jersey #4, Team: Spalding)';
END


-- Jonatan De La Rosa Soriano (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Jonatan%'  -- Match first name
    OR p.name LIKE '%Soriano%'  -- Match last name
    OR p.name = 'Jonatan De La Rosa Soriano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 56,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonatan De La Rosa Soriano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 56, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonatan De La Rosa Soriano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonatan De La Rosa Soriano (Jersey #5, Team: Spalding)';
END


-- Ethan Welsh (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Ethan%'  -- Match first name
    OR p.name LIKE '%Welsh%'  -- Match last name
    OR p.name = 'Ethan Welsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ethan Welsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ethan Welsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ethan Welsh (Jersey #6, Team: Spalding)';
END


-- Eddie Mendez-Perez (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Eddie%'  -- Match first name
    OR p.name LIKE '%Mendez-Perez%'  -- Match last name
    OR p.name = 'Eddie Mendez-Perez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eddie Mendez-Perez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eddie Mendez-Perez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eddie Mendez-Perez (Jersey #8, Team: Spalding)';
END


-- Marlon Amaya (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Marlon%'  -- Match first name
    OR p.name LIKE '%Amaya%'  -- Match last name
    OR p.name = 'Marlon Amaya'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Marlon Amaya';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Marlon Amaya';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Marlon Amaya (Jersey #10, Team: Spalding)';
END


-- Nolan Thomas (FWD) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nolan%'  -- Match first name
    OR p.name LIKE '%Thomas%'  -- Match last name
    OR p.name = 'Nolan Thomas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 79,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nolan Thomas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 79, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nolan Thomas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nolan Thomas (Jersey #19, Team: Spalding)';
END


-- Carter Payne (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Carter%'  -- Match first name
    OR p.name LIKE '%Payne%'  -- Match last name
    OR p.name = 'Carter Payne'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 81,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carter Payne';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 81, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carter Payne';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carter Payne (Jersey #21, Team: Spalding)';
END


-- Kevin Mulume (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Kevin%'  -- Match first name
    OR p.name LIKE '%Mulume%'  -- Match last name
    OR p.name = 'Kevin Mulume'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kevin Mulume';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kevin Mulume';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kevin Mulume (Jersey #22, Team: Spalding)';
END


-- Trey McCoomer (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%McCoomer%'  -- Match last name
    OR p.name = 'Trey McCoomer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey McCoomer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey McCoomer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey McCoomer (Jersey #23, Team: Spalding)';
END


-- Mack Calvert (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Mack%'  -- Match first name
    OR p.name LIKE '%Calvert%'  -- Match last name
    OR p.name = 'Mack Calvert'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Mack Calvert';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Mack Calvert';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Mack Calvert (Jersey #2, Team: Spalding)';
END


-- Ryan Shoemaker (DEF) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Ryan%'  -- Match first name
    OR p.name LIKE '%Shoemaker%'  -- Match last name
    OR p.name = 'Ryan Shoemaker'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 8,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ryan Shoemaker';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 8, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ryan Shoemaker';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ryan Shoemaker (Jersey #13, Team: Spalding)';
END


-- Jamie Seago (MID) - Spalding
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Spalding'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Jamie%'  -- Match first name
    OR p.name LIKE '%Seago%'  -- Match last name
    OR p.name = 'Jamie Seago'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jamie Seago';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jamie Seago';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jamie Seago (Jersey #18, Team: Spalding)';
END


-- =====================================================
-- Complete! Processed 29 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Eureka vs Greenville
-- Match Date: 2025-10-15
-- Generated: 2025-11-06 22:10:12
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Greenville';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Eureka';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-15')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-15'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Eureka vs Greenville';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Xavier Brisbon (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Xavier%'  -- Match first name
    OR p.name LIKE '%Brisbon%'  -- Match last name
    OR p.name = 'Xavier Brisbon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 2,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 7
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Xavier Brisbon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 2, 0, 7);
        PRINT '[OK] Inserted stats for Xavier Brisbon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Xavier Brisbon (Jersey #0, Team: Eureka)';
END


-- James Williams (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%James%'  -- Match first name
    OR p.name LIKE '%Williams%'  -- Match last name
    OR p.name = 'James Williams'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for James Williams';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for James Williams';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: James Williams (Jersey #2, Team: Eureka)';
END


-- Walter Medrano (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Walter%'  -- Match first name
    OR p.name LIKE '%Medrano%'  -- Match last name
    OR p.name = 'Walter Medrano'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 76,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Walter Medrano';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 76, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Walter Medrano';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Walter Medrano (Jersey #4, Team: Eureka)';
END


-- Tristan Martinez (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Tristan%'  -- Match first name
    OR p.name LIKE '%Martinez%'  -- Match last name
    OR p.name = 'Tristan Martinez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tristan Martinez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tristan Martinez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tristan Martinez (Jersey #5, Team: Eureka)';
END


-- Michael DeCarlo (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%DeCarlo%'  -- Match last name
    OR p.name = 'Michael DeCarlo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 87,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael DeCarlo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 87, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael DeCarlo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael DeCarlo (Jersey #8, Team: Eureka)';
END


-- Joyce Kabesa (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Joyce%'  -- Match first name
    OR p.name LIKE '%Kabesa%'  -- Match last name
    OR p.name = 'Joyce Kabesa'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 58,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Joyce Kabesa';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 58, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Joyce Kabesa';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Joyce Kabesa (Jersey #9, Team: Eureka)';
END


-- Jovani Zuniga (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jovani%'  -- Match first name
    OR p.name LIKE '%Zuniga%'  -- Match last name
    OR p.name = 'Jovani Zuniga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 80,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jovani Zuniga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 80, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jovani Zuniga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jovani Zuniga (Jersey #13, Team: Eureka)';
END


-- Landon Porch (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Landon%'  -- Match first name
    OR p.name LIKE '%Porch%'  -- Match last name
    OR p.name = 'Landon Porch'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Landon Porch';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Landon Porch';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Landon Porch (Jersey #14, Team: Eureka)';
END


-- Jacob Adamson (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Jacob%'  -- Match first name
    OR p.name LIKE '%Adamson%'  -- Match last name
    OR p.name = 'Jacob Adamson'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 79,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jacob Adamson';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 79, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jacob Adamson';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jacob Adamson (Jersey #15, Team: Eureka)';
END


-- Michael Kondilis (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Michael%'  -- Match first name
    OR p.name LIKE '%Kondilis%'  -- Match last name
    OR p.name = 'Michael Kondilis'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 41,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Michael Kondilis';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 41, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Michael Kondilis';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Michael Kondilis (Jersey #17, Team: Eureka)';
END


-- Oscar Villagrana (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 41
  AND (
    p.name LIKE '%Oscar%'  -- Match first name
    OR p.name LIKE '%Villagrana%'  -- Match last name
    OR p.name = 'Oscar Villagrana'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Oscar Villagrana';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Oscar Villagrana';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Oscar Villagrana (Jersey #41, Team: Eureka)';
END


-- Jesus Canas (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Jesus%'  -- Match first name
    OR p.name LIKE '%Canas%'  -- Match last name
    OR p.name = 'Jesus Canas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 65,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jesus Canas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 65, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jesus Canas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jesus Canas (Jersey #7, Team: Eureka)';
END


-- Anthony Gutierrez (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Anthony%'  -- Match first name
    OR p.name LIKE '%Gutierrez%'  -- Match last name
    OR p.name = 'Anthony Gutierrez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Anthony Gutierrez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Anthony Gutierrez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Anthony Gutierrez (Jersey #10, Team: Eureka)';
END


-- Pascal Calonges (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Pascal%'  -- Match first name
    OR p.name LIKE '%Calonges%'  -- Match last name
    OR p.name = 'Pascal Calonges'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 27,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pascal Calonges';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 27, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pascal Calonges';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pascal Calonges (Jersey #11, Team: Eureka)';
END


-- Tyler Kramer (DEF) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Tyler%'  -- Match first name
    OR p.name LIKE '%Kramer%'  -- Match last name
    OR p.name = 'Tyler Kramer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 7,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tyler Kramer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 7, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Tyler Kramer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tyler Kramer (Jersey #12, Team: Eureka)';
END


-- Aldo Mora-Lovera (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Aldo%'  -- Match first name
    OR p.name LIKE '%Mora-Lovera%'  -- Match last name
    OR p.name = 'Aldo Mora-Lovera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 15,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Aldo Mora-Lovera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 15, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Aldo Mora-Lovera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Aldo Mora-Lovera (Jersey #21, Team: Eureka)';
END


-- Diego Bueno (FWD) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Bueno%'  -- Match last name
    OR p.name = 'Diego Bueno'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego Bueno';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego Bueno';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego Bueno (Jersey #30, Team: Eureka)';
END


-- Leo Mendoza (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 36
  AND (
    p.name LIKE '%Leo%'  -- Match first name
    OR p.name LIKE '%Mendoza%'  -- Match last name
    OR p.name = 'Leo Mendoza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 59,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Leo Mendoza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 59, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Leo Mendoza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Leo Mendoza (Jersey #36, Team: Eureka)';
END


-- Brody Spera (MID) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 40
  AND (
    p.name LIKE '%Brody%'  -- Match first name
    OR p.name LIKE '%Spera%'  -- Match last name
    OR p.name = 'Brody Spera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Brody Spera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Brody Spera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Brody Spera (Jersey #40, Team: Eureka)';
END


-- Carlos Ziesecke (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Carlos%'  -- Match first name
    OR p.name LIKE '%Ziesecke%'  -- Match last name
    OR p.name = 'Carlos Ziesecke'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carlos Ziesecke';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carlos Ziesecke';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carlos Ziesecke (Jersey #3, Team: Greenville)';
END


-- Ben Wilcoxen (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Ben%'  -- Match first name
    OR p.name LIKE '%Wilcoxen%'  -- Match last name
    OR p.name = 'Ben Wilcoxen'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ben Wilcoxen';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ben Wilcoxen';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ben Wilcoxen (Jersey #5, Team: Greenville)';
END


-- Gabriel Sule (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Sule%'  -- Match last name
    OR p.name = 'Gabriel Sule'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Sule';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabriel Sule';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Sule (Jersey #10, Team: Greenville)';
END


-- Manolo Juarez (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Manolo%'  -- Match first name
    OR p.name LIKE '%Juarez%'  -- Match last name
    OR p.name = 'Manolo Juarez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 63,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Manolo Juarez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 63, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Manolo Juarez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Manolo Juarez (Jersey #11, Team: Greenville)';
END


-- Izan Gonzalez Rivera (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Izan%'  -- Match first name
    OR p.name LIKE '%Rivera%'  -- Match last name
    OR p.name = 'Izan Gonzalez Rivera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 53,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Izan Gonzalez Rivera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 53, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Izan Gonzalez Rivera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Izan Gonzalez Rivera (Jersey #17, Team: Greenville)';
END


-- Richard Kerwer (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Richard%'  -- Match first name
    OR p.name LIKE '%Kerwer%'  -- Match last name
    OR p.name = 'Richard Kerwer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 67,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Richard Kerwer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 67, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Richard Kerwer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Richard Kerwer (Jersey #18, Team: Greenville)';
END


-- Andres Garcia (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Andres%'  -- Match first name
    OR p.name LIKE '%Garcia%'  -- Match last name
    OR p.name = 'Andres Garcia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 77,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Andres Garcia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 77, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Andres Garcia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Andres Garcia (Jersey #20, Team: Greenville)';
END


-- Tian Poyo (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Tian%'  -- Match first name
    OR p.name LIKE '%Poyo%'  -- Match last name
    OR p.name = 'Tian Poyo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tian Poyo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 1);
        PRINT '[OK] Inserted stats for Tian Poyo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tian Poyo (Jersey #25, Team: Greenville)';
END


-- Pedro Kamada (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Pedro%'  -- Match first name
    OR p.name LIKE '%Kamada%'  -- Match last name
    OR p.name = 'Pedro Kamada'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 43,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pedro Kamada';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 43, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pedro Kamada';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pedro Kamada (Jersey #7, Team: Greenville)';
END


-- Braulio Martinez (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Braulio%'  -- Match first name
    OR p.name LIKE '%Martinez%'  -- Match last name
    OR p.name = 'Braulio Martinez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 32,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Braulio Martinez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 32, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Braulio Martinez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Braulio Martinez (Jersey #9, Team: Greenville)';
END


-- Gerardo Alarcon (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Gerardo%'  -- Match first name
    OR p.name LIKE '%Alarcon%'  -- Match last name
    OR p.name = 'Gerardo Alarcon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gerardo Alarcon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gerardo Alarcon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gerardo Alarcon (Jersey #30, Team: Greenville)';
END


-- Will Malone (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 54
  AND (
    p.name LIKE '%Will%'  -- Match first name
    OR p.name LIKE '%Malone%'  -- Match last name
    OR p.name = 'Will Malone'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 29,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Will Malone';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 29, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Will Malone';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Will Malone (Jersey #54, Team: Greenville)';
END


-- =====================================================
-- Complete! Processed 37 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: MUW vs Webster
-- Match Date: 2025-10-16
-- Generated: 2025-11-06 22:10:15
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Webster';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'MUW';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-16')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-16'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for MUW vs Webster';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Nick Gutierrez (GK) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Nick%'  -- Match first name
    OR p.name LIKE '%Gutierrez%'  -- Match last name
    OR p.name = 'Nick Gutierrez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 8,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 17
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nick Gutierrez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 8, 0, 17);
        PRINT '[OK] Inserted stats for Nick Gutierrez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nick Gutierrez (Jersey #1, Team: MUW)';
END


-- Cole Crawford (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 4
  AND (
    p.name LIKE '%Cole%'  -- Match first name
    OR p.name LIKE '%Crawford%'  -- Match last name
    OR p.name = 'Cole Crawford'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cole Crawford';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cole Crawford';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cole Crawford (Jersey #4, Team: MUW)';
END


-- Josh Zuniga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Josh%'  -- Match first name
    OR p.name LIKE '%Zuniga%'  -- Match last name
    OR p.name = 'Josh Zuniga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 53,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Josh Zuniga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 53, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Josh Zuniga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Josh Zuniga (Jersey #11, Team: MUW)';
END


-- Kyle Morris (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Kyle%'  -- Match first name
    OR p.name LIKE '%Morris%'  -- Match last name
    OR p.name = 'Kyle Morris'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kyle Morris';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kyle Morris';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kyle Morris (Jersey #14, Team: MUW)';
END


-- Dilyn Arnold (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 15
  AND (
    p.name LIKE '%Dilyn%'  -- Match first name
    OR p.name LIKE '%Arnold%'  -- Match last name
    OR p.name = 'Dilyn Arnold'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 62,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dilyn Arnold';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 62, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Dilyn Arnold';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dilyn Arnold (Jersey #15, Team: MUW)';
END


-- Luke Bradley (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Bradley%'  -- Match last name
    OR p.name = 'Luke Bradley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Bradley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Bradley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Bradley (Jersey #19, Team: MUW)';
END


-- Trey Parnell (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Trey%'  -- Match first name
    OR p.name LIKE '%Parnell%'  -- Match last name
    OR p.name = 'Trey Parnell'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 46,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Trey Parnell';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 46, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Trey Parnell';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Trey Parnell (Jersey #22, Team: MUW)';
END


-- Juan Puga (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 27
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Puga%'  -- Match last name
    OR p.name = 'Juan Puga'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 60,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Puga';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 60, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Juan Puga';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Puga (Jersey #27, Team: MUW)';
END


-- Sam Davis (MID) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 35
  AND (
    p.name LIKE '%Sam%'  -- Match first name
    OR p.name LIKE '%Davis%'  -- Match last name
    OR p.name = 'Sam Davis'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sam Davis';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sam Davis';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sam Davis (Jersey #35, Team: MUW)';
END


-- Drew Pack (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Drew%'  -- Match first name
    OR p.name LIKE '%Pack%'  -- Match last name
    OR p.name = 'Drew Pack'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 13,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Drew Pack';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 13, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Drew Pack';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Drew Pack (Jersey #3, Team: MUW)';
END


-- Daniel Holmes (DEF) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Daniel%'  -- Match first name
    OR p.name LIKE '%Holmes%'  -- Match last name
    OR p.name = 'Daniel Holmes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 6,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Daniel Holmes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 6, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Daniel Holmes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Daniel Holmes (Jersey #5, Team: MUW)';
END


-- Preston Holmes (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Preston%'  -- Match first name
    OR p.name LIKE '%Holmes%'  -- Match last name
    OR p.name = 'Preston Holmes'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 22,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Preston Holmes';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 22, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Preston Holmes';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Preston Holmes (Jersey #6, Team: MUW)';
END


-- Justin Nazariega (FWD) - MUW
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'MUW'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Justin%'  -- Match first name
    OR p.name LIKE '%Nazariega%'  -- Match last name
    OR p.name = 'Justin Nazariega'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 13,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Justin Nazariega';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 13, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Justin Nazariega';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Justin Nazariega (Jersey #7, Team: MUW)';
END


-- Luke Dillon (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Dillon%'  -- Match last name
    OR p.name = 'Luke Dillon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Dillon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 0, 0, 0, 1, 0, 0, 1);
        PRINT '[OK] Inserted stats for Luke Dillon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Dillon (Jersey #1, Team: Webster)';
END


-- Luke Walsh (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Walsh%'  -- Match last name
    OR p.name = 'Luke Walsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 65,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Walsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 65, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Walsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Walsh (Jersey #2, Team: Webster)';
END


-- Danny Nusinovic (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Nusinovic%'  -- Match last name
    OR p.name = 'Danny Nusinovic'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 71,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Nusinovic';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 71, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Danny Nusinovic';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Nusinovic (Jersey #16, Team: Webster)';
END


-- Scott Price (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Scott%'  -- Match first name
    OR p.name LIKE '%Price%'  -- Match last name
    OR p.name = 'Scott Price'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 53,
            Goals = 1,
            Assists = 3,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Scott Price';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 53, 1, 3, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Scott Price';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Scott Price (Jersey #17, Team: Webster)';
END


-- Hayden Hatley (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Hayden%'  -- Match first name
    OR p.name LIKE '%Hatley%'  -- Match last name
    OR p.name = 'Hayden Hatley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 65,
            Goals = 0,
            Assists = 1,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hayden Hatley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 65, 0, 1, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hayden Hatley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hayden Hatley (Jersey #20, Team: Webster)';
END


-- Alberto Duque Gonzalez (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Alberto%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Alberto Duque Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 66,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alberto Duque Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 66, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alberto Duque Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alberto Duque Gonzalez (Jersey #26, Team: Webster)';
END


-- Enzo Goncalves Proni (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Enzo%'  -- Match first name
    OR p.name LIKE '%Proni%'  -- Match last name
    OR p.name = 'Enzo Goncalves Proni'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 6,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Enzo Goncalves Proni';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 6, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Enzo Goncalves Proni';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Enzo Goncalves Proni (Jersey #9, Team: Webster)';
END


-- Jakub Samelko (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 33
  AND (
    p.name LIKE '%Jakub%'  -- Match first name
    OR p.name LIKE '%Samelko%'  -- Match last name
    OR p.name = 'Jakub Samelko'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jakub Samelko';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 1);
        PRINT '[OK] Inserted stats for Jakub Samelko';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jakub Samelko (Jersey #33, Team: Webster)';
END


-- =====================================================
-- Complete! Processed 43 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Greenville vs Principia
-- Match Date: 2025-10-17
-- Generated: 2025-11-06 22:10:17
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Principia';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Greenville';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-17')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-17'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Greenville vs Principia';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Carlos Ziesecke (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Carlos%'  -- Match first name
    OR p.name LIKE '%Ziesecke%'  -- Match last name
    OR p.name = 'Carlos Ziesecke'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Carlos Ziesecke';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Carlos Ziesecke';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Carlos Ziesecke (Jersey #3, Team: Greenville)';
END


-- Ben Wilcoxen (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Ben%'  -- Match first name
    OR p.name LIKE '%Wilcoxen%'  -- Match last name
    OR p.name = 'Ben Wilcoxen'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ben Wilcoxen';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ben Wilcoxen';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ben Wilcoxen (Jersey #5, Team: Greenville)';
END


-- Gabriel Sule (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Sule%'  -- Match last name
    OR p.name = 'Gabriel Sule'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Sule';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gabriel Sule';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Sule (Jersey #10, Team: Greenville)';
END


-- Manolo Juarez (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Manolo%'  -- Match first name
    OR p.name LIKE '%Juarez%'  -- Match last name
    OR p.name = 'Manolo Juarez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 11,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Manolo Juarez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 11, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Manolo Juarez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Manolo Juarez (Jersey #11, Team: Greenville)';
END


-- Izan Gonzalez Rivera (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Izan%'  -- Match first name
    OR p.name LIKE '%Rivera%'  -- Match last name
    OR p.name = 'Izan Gonzalez Rivera'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 58,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Izan Gonzalez Rivera';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 58, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Izan Gonzalez Rivera';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Izan Gonzalez Rivera (Jersey #17, Team: Greenville)';
END


-- Richard Kerwer (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 18
  AND (
    p.name LIKE '%Richard%'  -- Match first name
    OR p.name LIKE '%Kerwer%'  -- Match last name
    OR p.name = 'Richard Kerwer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 40,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Richard Kerwer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 40, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Richard Kerwer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Richard Kerwer (Jersey #18, Team: Greenville)';
END


-- Andres Garcia (FWD) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Andres%'  -- Match first name
    OR p.name LIKE '%Garcia%'  -- Match last name
    OR p.name = 'Andres Garcia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 85,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Andres Garcia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 85, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Andres Garcia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Andres Garcia (Jersey #20, Team: Greenville)';
END


-- Tian Poyo (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Tian%'  -- Match first name
    OR p.name LIKE '%Poyo%'  -- Match last name
    OR p.name = 'Tian Poyo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 1,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 1
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Tian Poyo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 1, 0, 0, 0, 0, 0, 0, 0, 1);
        PRINT '[OK] Inserted stats for Tian Poyo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Tian Poyo (Jersey #25, Team: Greenville)';
END


-- Pedro Kamada (DEF) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 7
  AND (
    p.name LIKE '%Pedro%'  -- Match first name
    OR p.name LIKE '%Kamada%'  -- Match last name
    OR p.name = 'Pedro Kamada'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 42,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Pedro Kamada';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 42, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Pedro Kamada';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Pedro Kamada (Jersey #7, Team: Greenville)';
END


-- Dominick Messer (GK) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Dominick%'  -- Match first name
    OR p.name LIKE '%Messer%'  -- Match last name
    OR p.name = 'Dominick Messer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 88,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 4
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Dominick Messer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 88, 0, 0, 0, 0, 1, 0, 0, 4);
        PRINT '[OK] Inserted stats for Dominick Messer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Dominick Messer (Jersey #12, Team: Greenville)';
END


-- Estuardo Salguero (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Estuardo%'  -- Match first name
    OR p.name LIKE '%Salguero%'  -- Match last name
    OR p.name = 'Estuardo Salguero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 5,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Estuardo Salguero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 5, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Estuardo Salguero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Estuardo Salguero (Jersey #23, Team: Greenville)';
END


-- Gerardo Alarcon (MID) - Greenville
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Greenville'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Gerardo%'  -- Match first name
    OR p.name LIKE '%Alarcon%'  -- Match last name
    OR p.name = 'Gerardo Alarcon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gerardo Alarcon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Gerardo Alarcon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gerardo Alarcon (Jersey #30, Team: Greenville)';
END


-- Nacho Cachaza (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Nacho%'  -- Match first name
    OR p.name LIKE '%Cachaza%'  -- Match last name
    OR p.name = 'Nacho Cachaza'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nacho Cachaza';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nacho Cachaza';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nacho Cachaza (Jersey #3, Team: Principia)';
END


-- Sebastian Castro (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Sebastian%'  -- Match first name
    OR p.name LIKE '%Castro%'  -- Match last name
    OR p.name = 'Sebastian Castro'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 64,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Sebastian Castro';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 64, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Sebastian Castro';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Sebastian Castro (Jersey #5, Team: Principia)';
END


-- Wizzy Afrani (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Wizzy%'  -- Match first name
    OR p.name LIKE '%Afrani%'  -- Match last name
    OR p.name = 'Wizzy Afrani'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Wizzy Afrani';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Wizzy Afrani';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Wizzy Afrani (Jersey #11, Team: Principia)';
END


-- Jonathan Keller (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 13
  AND (
    p.name LIKE '%Jonathan%'  -- Match first name
    OR p.name LIKE '%Keller%'  -- Match last name
    OR p.name = 'Jonathan Keller'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 82,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jonathan Keller';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 82, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jonathan Keller';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jonathan Keller (Jersey #13, Team: Principia)';
END


-- Nana Koranteng (FWD) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 19
  AND (
    p.name LIKE '%Nana%'  -- Match first name
    OR p.name LIKE '%Koranteng%'  -- Match last name
    OR p.name = 'Nana Koranteng'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 78,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Nana Koranteng';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 78, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Nana Koranteng';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Nana Koranteng (Jersey #19, Team: Principia)';
END


-- Diego De Manuel Romero (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 21
  AND (
    p.name LIKE '%Diego%'  -- Match first name
    OR p.name LIKE '%Romero%'  -- Match last name
    OR p.name = 'Diego De Manuel Romero'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 57,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Diego De Manuel Romero';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 57, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Diego De Manuel Romero';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Diego De Manuel Romero (Jersey #21, Team: Principia)';
END


-- Cade Pecheck (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 22
  AND (
    p.name LIKE '%Cade%'  -- Match first name
    OR p.name LIKE '%Pecheck%'  -- Match last name
    OR p.name = 'Cade Pecheck'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 73,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Cade Pecheck';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 73, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Cade Pecheck';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Cade Pecheck (Jersey #22, Team: Principia)';
END


-- Kelvin Kasirye (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 25
  AND (
    p.name LIKE '%Kelvin%'  -- Match first name
    OR p.name LIKE '%Kasirye%'  -- Match last name
    OR p.name = 'Kelvin Kasirye'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 20,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Kelvin Kasirye';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 20, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Kelvin Kasirye';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Kelvin Kasirye (Jersey #25, Team: Principia)';
END


-- Edgar Cartagena (GK) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 30
  AND (
    p.name LIKE '%Edgar%'  -- Match first name
    OR p.name LIKE '%Cartagena%'  -- Match last name
    OR p.name = 'Edgar Cartagena'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 4
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Edgar Cartagena';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 4);
        PRINT '[OK] Inserted stats for Edgar Cartagena';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Edgar Cartagena (Jersey #30, Team: Principia)';
END


-- Eduardo Salazar (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 6
  AND (
    p.name LIKE '%Eduardo%'  -- Match first name
    OR p.name LIKE '%Salazar%'  -- Match last name
    OR p.name = 'Eduardo Salazar'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 33,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eduardo Salazar';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 33, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eduardo Salazar';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eduardo Salazar (Jersey #6, Team: Principia)';
END


-- Eziuche Ejimadu (MID) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 12
  AND (
    p.name LIKE '%Eziuche%'  -- Match first name
    OR p.name LIKE '%Ejimadu%'  -- Match last name
    OR p.name = 'Eziuche Ejimadu'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 20,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Eziuche Ejimadu';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 20, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Eziuche Ejimadu';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Eziuche Ejimadu (Jersey #12, Team: Principia)';
END


-- Amri Seperia (DEF) - Principia
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Principia'
  AND p.playerNum = 23
  AND (
    p.name LIKE '%Amri%'  -- Match first name
    OR p.name LIKE '%Seperia%'  -- Match last name
    OR p.name = 'Amri Seperia'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Amri Seperia';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Amri Seperia';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Amri Seperia (Jersey #23, Team: Principia)';
END


-- =====================================================
-- Complete! Processed 34 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Webster vs Lyon
-- Match Date: 2025-10-18
-- Generated: 2025-11-06 22:10:26
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Lyon';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Webster';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-18')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-18'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Webster vs Lyon';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Luke Dillon (GK) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Dillon%'  -- Match last name
    OR p.name = 'Luke Dillon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 3
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Dillon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 3);
        PRINT '[OK] Inserted stats for Luke Dillon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Dillon (Jersey #1, Team: Webster)';
END


-- Luke Walsh (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 2
  AND (
    p.name LIKE '%Luke%'  -- Match first name
    OR p.name LIKE '%Walsh%'  -- Match last name
    OR p.name = 'Luke Walsh'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Luke Walsh';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Luke Walsh';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Luke Walsh (Jersey #2, Team: Webster)';
END


-- Ian Meyer (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Ian%'  -- Match first name
    OR p.name LIKE '%Meyer%'  -- Match last name
    OR p.name = 'Ian Meyer'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Ian Meyer';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Ian Meyer';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Ian Meyer (Jersey #3, Team: Webster)';
END


-- Danny Nusinovic (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 16
  AND (
    p.name LIKE '%Danny%'  -- Match first name
    OR p.name LIKE '%Nusinovic%'  -- Match last name
    OR p.name = 'Danny Nusinovic'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 1,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Danny Nusinovic';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 1, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Danny Nusinovic';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Danny Nusinovic (Jersey #16, Team: Webster)';
END


-- Scott Price (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 17
  AND (
    p.name LIKE '%Scott%'  -- Match first name
    OR p.name LIKE '%Price%'  -- Match last name
    OR p.name = 'Scott Price'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 1,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Scott Price';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 1, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Scott Price';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Scott Price (Jersey #17, Team: Webster)';
END


-- Hayden Hatley (FWD) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 20
  AND (
    p.name LIKE '%Hayden%'  -- Match first name
    OR p.name LIKE '%Hatley%'  -- Match last name
    OR p.name = 'Hayden Hatley'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 45,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Hayden Hatley';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 45, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Hayden Hatley';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Hayden Hatley (Jersey #20, Team: Webster)';
END


-- Alberto Duque Gonzalez (MID) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 26
  AND (
    p.name LIKE '%Alberto%'  -- Match first name
    OR p.name LIKE '%Gonzalez%'  -- Match last name
    OR p.name = 'Alberto Duque Gonzalez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Alberto Duque Gonzalez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Alberto Duque Gonzalez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Alberto Duque Gonzalez (Jersey #26, Team: Webster)';
END


-- Finn Rohl (DEF) - Webster
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Webster'
  AND p.playerNum = 11
  AND (
    p.name LIKE '%Finn%'  -- Match first name
    OR p.name LIKE '%Rohl%'  -- Match last name
    OR p.name = 'Finn Rohl'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 19,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Finn Rohl';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 19, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Finn Rohl';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Finn Rohl (Jersey #11, Team: Webster)';
END


-- Gabriel Rangel (GK) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 1
  AND (
    p.name LIKE '%Gabriel%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Gabriel Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 2
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Gabriel Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 2);
        PRINT '[OK] Inserted stats for Gabriel Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Gabriel Rangel (Jersey #1, Team: Lyon)';
END


-- Jake Mcmurdo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 3
  AND (
    p.name LIKE '%Jake%'  -- Match first name
    OR p.name LIKE '%Mcmurdo%'  -- Match last name
    OR p.name = 'Jake Mcmurdo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 59,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Jake Mcmurdo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 59, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Jake Mcmurdo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Jake Mcmurdo (Jersey #3, Team: Lyon)';
END


-- Salvador Fernandez (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 5
  AND (
    p.name LIKE '%Salvador%'  -- Match first name
    OR p.name LIKE '%Fernandez%'  -- Match last name
    OR p.name = 'Salvador Fernandez'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 56,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Salvador Fernandez';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 56, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Salvador Fernandez';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Salvador Fernandez (Jersey #5, Team: Lyon)';
END


-- Micah Rangel (MID) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 8
  AND (
    p.name LIKE '%Micah%'  -- Match first name
    OR p.name LIKE '%Rangel%'  -- Match last name
    OR p.name = 'Micah Rangel'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 69,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Micah Rangel';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 69, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Micah Rangel';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Micah Rangel (Jersey #8, Team: Lyon)';
END


-- Lucca Torres (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 9
  AND (
    p.name LIKE '%Lucca%'  -- Match first name
    OR p.name LIKE '%Torres%'  -- Match last name
    OR p.name = 'Lucca Torres'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 70,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Lucca Torres';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 70, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Lucca Torres';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Lucca Torres (Jersey #9, Team: Lyon)';
END


-- Joao Barros (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 10
  AND (
    p.name LIKE '%Joao%'  -- Match first name
    OR p.name LIKE '%Barros%'  -- Match last name
    OR p.name = 'Joao Barros'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 81,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Joao Barros';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 81, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Joao Barros';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Joao Barros (Jersey #10, Team: Lyon)';
END


-- Leonardo Bravo (DEF) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 41
  AND (
    p.name LIKE '%Leonardo%'  -- Match first name
    OR p.name LIKE '%Bravo%'  -- Match last name
    OR p.name = 'Leonardo Bravo'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Leonardo Bravo';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Leonardo Bravo';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Leonardo Bravo (Jersey #41, Team: Lyon)';
END


-- Traviss Ragan (FWD) - Lyon
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Lyon'
  AND p.playerNum = 14
  AND (
    p.name LIKE '%Traviss%'  -- Match first name
    OR p.name LIKE '%Ragan%'  -- Match last name
    OR p.name = 'Traviss Ragan'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 9,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 0
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Traviss Ragan';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 9, 0, 0, 0, 0, 0, 0, 0, 0);
        PRINT '[OK] Inserted stats for Traviss Ragan';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Traviss Ragan (Jersey #14, Team: Lyon)';
END


-- =====================================================
-- Complete! Processed 32 players
-- =====================================================

GO

-- =====================================================
-- Player Stats for: Eureka vs Blackburn
-- Match Date: 2025-10-18
-- Generated: 2025-11-06 22:10:31
-- =====================================================

-- Find fixture ID dynamically based on teams
DECLARE @FixtureId INT;
DECLARE @Team1Id INT, @Team2Id INT;
DECLARE @PlayerId INT;  -- Declare once, reuse for all players

-- Get team IDs
SELECT @Team1Id = Id FROM conferenceTeams WHERE Team = 'Blackburn';
SELECT @Team2Id = Id FROM conferenceTeams WHERE Team = 'Eureka';

-- Find fixture (checking both home/away combinations)
SELECT TOP 1 @FixtureId = f.Id
FROM fixtures f
WHERE ((f.HomeTeamId = @Team1Id AND f.AwayTeamId = @Team2Id)
    OR (f.HomeTeamId = @Team2Id AND f.AwayTeamId = @Team1Id))
  AND ABS(DATEDIFF(day, f.Kickoff, '2025-10-18')) <= 7
ORDER BY ABS(DATEDIFF(day, f.Kickoff, '2025-10-18'));

IF @FixtureId IS NULL
BEGIN
    PRINT 'ERROR: Could not find fixture for Eureka vs Blackburn';
    RETURN;
END

PRINT 'Found Fixture ID: ' + CAST(@FixtureId AS VARCHAR(10));

-- Xavier Brisbon (GK) - Eureka
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Eureka'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Xavier%'  -- Match first name
    OR p.name LIKE '%Brisbon%'  -- Match last name
    OR p.name = 'Xavier Brisbon'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 1,
            GoalsConceded = 0,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Xavier Brisbon';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 1, 0, 0, 5);
        PRINT '[OK] Inserted stats for Xavier Brisbon';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Xavier Brisbon (Jersey #0, Team: Eureka)';
END


-- Juan Vargas (GK) - Blackburn
-- Find player by name, jersey, and team
-- (Reusing @PlayerId declared at top)
SELECT TOP 1 @PlayerId = p.Id
FROM players p
INNER JOIN conferenceTeams ct ON p.teamId = ct.Id
WHERE ct.Team = 'Blackburn'
  AND p.playerNum = 0
  AND (
    p.name LIKE '%Juan%'  -- Match first name
    OR p.name LIKE '%Vargas%'  -- Match last name
    OR p.name = 'Juan Vargas'  -- Exact match
  );

-- Insert stats if player found
IF @PlayerId IS NOT NULL AND @FixtureId IS NOT NULL
BEGIN
    -- Check if stats already exist
    IF EXISTS (SELECT 1 FROM playerFixtureStats WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId)
    BEGIN
        UPDATE playerFixtureStats
        SET MinutesPlayed = 90,
            Goals = 0,
            Assists = 0,
            YellowCards = 0,
            RedCards = 0,
            CleanSheet = 0,
            GoalsConceded = 1,
            OwnGoals = 0,  -- TODO: Parse from PDF
            Saves = 5
        WHERE PlayerId = @PlayerId AND FixtureId = @FixtureId;
        PRINT '[OK] Updated stats for Juan Vargas';
    END
    ELSE
    BEGIN
        INSERT INTO playerFixtureStats (PlayerId, FixtureId, MinutesPlayed, Goals, Assists, YellowCards, RedCards, CleanSheet, GoalsConceded, OwnGoals, Saves)
        VALUES (@PlayerId, @FixtureId, 90, 0, 0, 0, 0, 0, 1, 0, 5);
        PRINT '[OK] Inserted stats for Juan Vargas';
    END
END
ELSE
BEGIN
    PRINT '[FAIL] Could not find player: Juan Vargas (Jersey #0, Team: Blackburn)';
END


-- =====================================================
-- Complete! Processed 43 players
-- =====================================================