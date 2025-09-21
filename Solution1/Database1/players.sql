CREATE TABLE [dbo].[players]
(
	[Id] INT  IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [position] TINYINT NOT NULL, 
    [name] NCHAR(10) NOT NULL, 
    [teamId] INT NOT NULL, 
    [cost] DECIMAL(9,2) NOT NULL DEFAULT 4, 
    CONSTRAINT [FK_players_ToConferenceteams] FOREIGN KEY ([teamId]) REFERENCES [conferenceTeams]([Id]), 
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

