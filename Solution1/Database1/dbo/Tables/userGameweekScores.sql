﻿CREATE TABLE userGameweekScores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    GameweekId INT NOT NULL,
    TotalPoints INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_UGS_User FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT FK_UGS_Gameweek FOREIGN KEY (GameweekId) REFERENCES Gameweeks(Id),
    CONSTRAINT UQ_UGS UNIQUE (UserId, GameweekId)
);