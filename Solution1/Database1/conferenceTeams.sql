CREATE TABLE [dbo].[conferenceTeams]
(
	[Id] INT IDENTITY(1,1) not NULL PRIMARY KEY , 
    [Team] NVARCHAR(50) NOT NULL, 
    [school] NVARCHAR(100) NOT NULL,
    --team logo 
    [logoUrl] NVARCHAR(256) NULL
    
)