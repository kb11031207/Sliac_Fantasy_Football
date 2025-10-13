namespace Service_layer.DTOs
{
    public class FixtureDto
    {
        public int Id { get; set; }
        public int GameweekId { get; set; }
        public int HomeTeamId { get; set; }
        public string? HomeTeamName { get; set; }
        public int AwayTeamId { get; set; }
        public string? AwayTeamName { get; set; }
        public DateTime Kickoff { get; set; }
        public byte? HomeScore { get; set; }
        public byte? AwayScore { get; set; }
        public bool IsFinished { get; set; }
    }

    public class FixtureDetailsDto
    {
        public int Id { get; set; }
        public int GameweekId { get; set; }
        public int HomeTeamId { get; set; }
        public string? HomeTeamName { get; set; }
        public int AwayTeamId { get; set; }
        public string? AwayTeamName { get; set; }
        public DateTime Kickoff { get; set; }
        public byte? HomeScore { get; set; }
        public byte? AwayScore { get; set; }
        public List<PlayerFixtureStatsDto> PlayerStats { get; set; } = new List<PlayerFixtureStatsDto>();
    }

    public class PlayerFixtureStatsDto
    {
        public int PlayerId { get; set; }
        public string? PlayerName { get; set; }
        public int TeamId { get; set; }
        public byte MinutesPlayed { get; set; }
        public byte Goals { get; set; }
        public byte Assists { get; set; }
        public byte YellowCards { get; set; }
        public byte RedCards { get; set; }
        public bool CleanSheet { get; set; }
        public byte GoalsConceded { get; set; }
        public byte Saves { get; set; }
    }
}





