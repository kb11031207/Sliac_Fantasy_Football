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