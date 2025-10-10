CREATE TABLE fixtureResults (
    FixtureId INT PRIMARY KEY,
    HomeScore TINYINT NOT NULL,
    AwayScore TINYINT NOT NULL,
    CONSTRAINT FK_FixtureResults_Fixture FOREIGN KEY (FixtureId) REFERENCES Fixtures(Id)
);