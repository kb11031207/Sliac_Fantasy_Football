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