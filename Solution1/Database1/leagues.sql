CREATE TABLE [dbo].[leagues]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [owner] INT NOT NULL, 
    [type] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_leagues_Tousers] FOREIGN KEY ([owner]) REFERENCES [users]([id]), 
)