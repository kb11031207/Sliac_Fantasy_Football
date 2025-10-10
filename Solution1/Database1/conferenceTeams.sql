CREATE TABLE [dbo].[conferenceTeams]
(
	[Id] INT IDENTITY(1,1) not NULL PRIMARY KEY , 
    [Team] NCHAR(10) NOT NULL, 
    [school] NCHAR(10) NOT NULL,
    --team logo 
    [logoUrl] NVARCHAR(256) NULL
    
)