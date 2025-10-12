
--use the database
USE fantasy_proj
-- Drop tables in reverse dependency order to avoid FK constraint errors
DROP TABLE IF EXISTS PlayerGameweekStats;
DROP TABLE IF EXISTS PlayerFixtureStats;
DROP TABLE IF EXISTS FixtureResults;
DROP TABLE IF EXISTS Fixtures;
DROP TABLE IF EXISTS UserGameweekScores;
DROP TABLE IF EXISTS squadPlayers;
DROP TABLE IF EXISTS squads;
DROP TABLE IF EXISTS gameweeks;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS conferenceTeams;
DROP TABLE IF EXISTS usersXleagues;
DROP TABLE IF EXISTS leagues;
DROP TABLE IF EXISTS users;

CREATE TABLE [dbo].[users]
(
	[id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [email] NVARCHAR(256) NULL, 
    [username] NCHAR(64) NULL, 
    [school] NCHAR(100) NULL,
    [passHash] varbinary(64) NOT NULL,
    [passSalt] varbinary(16) NOT NULL,
    --add a unique constraint on email and username
    CONSTRAINT [UQ_users_email] UNIQUE ([email]),
    CONSTRAINT [UQ_users_username] UNIQUE ([username])
    --index on email and username for faster lookups
)

CREATE TABLE [dbo].[leagues]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [owner] INT NOT NULL, 
    [type] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_leagues_Tousers] FOREIGN KEY ([owner]) REFERENCES [users]([id]), 
)

CREATE TABLE [dbo].[usersXleagues]
(
	[userId] INT  NOT NULL, 
    [leagueId] INT NOT NULL, 
    CONSTRAINT [FK_usersXleagues_Tousers] FOREIGN KEY ([userid]) REFERENCES [users]([id]) ,
    CONSTRAINT [FK_usersXleagues_Toleagues] FOREIGN KEY ([leagueId]) REFERENCES [leagues]([id]), 
    --set primary key as combination of userId and leagueId to prevent duplicates
    CONSTRAINT [PK_usersXleagues] PRIMARY KEY ([userId], [leagueId]),
)

CREATE TABLE [dbo].[conferenceTeams]
(
	[Id] INT IDENTITY(1,1) not NULL PRIMARY KEY , 
    [Team] NCHAR(10) NOT NULL, 
    [school] NCHAR(10) NOT NULL,
    --team logo 
    [logoUrl] NVARCHAR(256) NULL
    
)

CREATE TABLE [dbo].[players]
(
	[Id] INT  IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [position] TINYINT NOT NULL, 
    [name] NCHAR(10) NOT NULL, 
    --player num
    [playerNum] TINYINT NOT NULL,
    [teamId] INT NOT NULL, 
    [cost] DECIMAL(9,2) NOT NULL DEFAULT 4, 
    CONSTRAINT [FK_players_ToConferenceteams] FOREIGN KEY ([teamId]) REFERENCES [conferenceTeams]([Id]), 
    --player picture 
    [pictureUrl] NVARCHAR(256) NULL
    --
)
--create index on position and teamId for faster lookups

GO

CREATE INDEX [IX_players_position] ON [dbo].[players] ([position])

GO
CREATE INDEX [IX_players_teamId] ON [dbo].[players] ([teamId])

--cost
GO
CREATE INDEX [IX_players_cost] ON [dbo].[players] ([cost])



CREATE TABLE [dbo].[gameweeks] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [startTime] DATETIME NOT NULL,
    [endTime] DATETIME NULL,
    [isComplete] BIT NOT NULL DEFAULT 0
);

CREATE TABLE [dbo].[squads] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [userId] INT NOT NULL,
    [gameweekId] INT NOT NULL,
    [createdAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [updatedAt] DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT [FK_squads_users] FOREIGN KEY ([userId]) REFERENCES [users]([id]),
    CONSTRAINT [FK_squads_gameweeks] FOREIGN KEY ([gameweekId]) REFERENCES [gameweeks]([id]),

    CONSTRAINT [UQ_squads_user_gameweek] UNIQUE ([userId], [gameweekId])
);

CREATE TABLE [dbo].[squadPlayers] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [squadId] INT NOT NULL,
    [playerId] INT NOT NULL,
    [isStarter] BIT NOT NULL DEFAULT 1,
    [isCaptain] BIT NOT NULL DEFAULT 0,
    [isVice] BIT NOT NULL DEFAULT 0,
    [playerCost] MONEY NOT NULL,

    CONSTRAINT [FK_squadPlayers_squads] FOREIGN KEY ([squadId]) REFERENCES [squads]([id]),
    CONSTRAINT [FK_squadPlayers_players] FOREIGN KEY ([playerId]) REFERENCES [players]([id])
);

CREATE TABLE fixtures (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GameweekId INT NOT NULL,
    HomeTeamId INT NOT NULL,
    AwayTeamId INT NOT NULL,
    Kickoff DATETIME NOT NULL,
    CONSTRAINT FK_Fixtures_Gameweek FOREIGN KEY (GameweekId) REFERENCES Gameweeks(Id),
    CONSTRAINT FK_Fixtures_HomeTeam FOREIGN KEY (HomeTeamId) REFERENCES ConferenceTeams(Id),
    CONSTRAINT FK_Fixtures_AwayTeam FOREIGN KEY (AwayTeamId) REFERENCES ConferenceTeams(Id)
);

CREATE TABLE fixtureResults (
    FixtureId INT PRIMARY KEY,
    HomeScore TINYINT NOT NULL,
    AwayScore TINYINT NOT NULL,
    CONSTRAINT FK_FixtureResults_Fixture FOREIGN KEY (FixtureId) REFERENCES Fixtures(Id)
);


--maybe 

CREATE TABLE playerFixtureStats (
    PlayerId INT NOT NULL,
    FixtureId INT NOT NULL,
    MinutesPlayed TINYINT NOT NULL DEFAULT 0,
    Goals TINYINT NOT NULL DEFAULT 0,
    Assists TINYINT NOT NULL DEFAULT 0,
    YellowCards TINYINT NOT NULL DEFAULT 0,
    RedCards TINYINT NOT NULL DEFAULT 0,
    CleanSheet BIT NOT NULL DEFAULT 0,
    GoalsConceded TINYINT NOT NULL DEFAULT 0,
    OwnGoals TINYINT NOT NULL DEFAULT 0,
    Saves TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY (PlayerId, FixtureId),
    CONSTRAINT FK_PFS_Player FOREIGN KEY (PlayerId) REFERENCES Players(Id),
    CONSTRAINT FK_PFS_Fixture FOREIGN KEY (FixtureId) REFERENCES Fixtures(Id)
);



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



CREATE TABLE userGameweekScores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    GameweekId INT NOT NULL,
    TotalPoints INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_UGS_User FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT FK_UGS_Gameweek FOREIGN KEY (GameweekId) REFERENCES Gameweeks(Id),
    CONSTRAINT UQ_UGS UNIQUE (UserId, GameweekId)
);
SELECT * FROM sys.tables;










