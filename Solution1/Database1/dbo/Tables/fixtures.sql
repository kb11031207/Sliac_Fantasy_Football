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