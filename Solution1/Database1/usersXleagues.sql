CREATE TABLE [dbo].[usersXleagues]
(
	[userId] INT  NOT NULL, 
    [leagueId] INT NOT NULL, 
    CONSTRAINT [FK_usersXleagues_Tousers] FOREIGN KEY ([userid]) REFERENCES [users]([id]) ,
    CONSTRAINT [FK_usersXleagues_Toleagues] FOREIGN KEY ([leagueId]) REFERENCES [leagues]([id]), 
    --set primary key as combination of userId and leagueId to prevent duplicates
    CONSTRAINT [PK_usersXleagues] PRIMARY KEY ([userId], [leagueId]),
)
