CREATE TABLE [dbo].[gameweeks] (
    [id] INT PRIMARY KEY IDENTITY(1,1),
    [startTime] DATETIME NOT NULL,
    [endTime] DATETIME NULL,
    [isComplete] BIT NOT NULL DEFAULT 0
);