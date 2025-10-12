CREATE TABLE playerGameweekStats (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PlayerId INT NOT NULL,
    GameweekId INT NOT NULL,
    FixtureId INT NOT NULL,

    MinutesPlayed TINYINT DEFAULT 0,
    Goals TINYINT DEFAULT 0,
    Assists TINYINT DEFAULT 0,
    CleanSheet BIT DEFAULT 0,
    GoalsConceded TINYINT DEFAULT 0,
    YellowCards TINYINT DEFAULT 0,
    RedCards TINYINT DEFAULT 0,
    OwnGoals TINYINT DEFAULT 0,
    Saves TINYINT DEFAULT 0,

    PointsEarned INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Stats_Player FOREIGN KEY (PlayerId) REFERENCES Players(Id),
    CONSTRAINT FK_Stats_Gameweek FOREIGN KEY (GameweekId) REFERENCES Gameweeks(Id),
    CONSTRAINT FK_Stats_Fixture FOREIGN KEY (FixtureId) REFERENCES Fixtures(Id)
);