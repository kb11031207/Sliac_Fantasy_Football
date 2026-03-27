namespace Service_layer.DTOs
{
    public class PlayerDto
    {
        public int Id { get; set; }
        public byte Position { get; set; }
        public string PositionDisplay => Position switch
        {
            1 => "GK",
            2 => "DEF",
            3 => "MID",
            4 => "FWD",
            _ => "Unknown"
        };


        public string Name { get; set; } = null!;
        public byte PlayerNum { get; set; }
        public int TeamId { get; set; }
        public string? TeamName { get; set; }
        public string? School { get; set; }
        public decimal Cost { get; set; }
        public string? PictureUrl { get; set; }
    }

    public class PlayerStatsDto
    {
        public int PlayerId { get; set; }
        public string? PlayerName { get; set; }
        public int GameweekId { get; set; }
        public byte MinutesPlayed { get; set; }
        public byte Goals { get; set; }
        public byte Assists { get; set; }
        public bool CleanSheet { get; set; }
        public byte GoalsConceded { get; set; }
        public byte YellowCards { get; set; }
        public byte RedCards { get; set; }
        public byte Saves { get; set; }
        public byte Shots { get; set; }
        public byte ShotsOnGoal { get; set; }
        public int PointsEarned { get; set; }
        public List<PlayerGameweekFixtureDto> Fixtures { get; set; } = new List<PlayerGameweekFixtureDto>();
    }

    public class PlayerGameweekFixtureDto
    {
        public int FixtureId { get; set; }
        public string? HomeTeamName { get; set; }
        public string? AwayTeamName { get; set; }
        public byte? HomeScore { get; set; }
        public byte? AwayScore { get; set; }
        public DateTime Kickoff { get; set; }
        public byte MinutesPlayed { get; set; }
        public byte Goals { get; set; }
        public byte Assists { get; set; }
        public bool CleanSheet { get; set; }
        public byte GoalsConceded { get; set; }
        public byte YellowCards { get; set; }
        public byte RedCards { get; set; }
        public byte Saves { get; set; }
        public byte Shots { get; set; }
        public byte ShotsOnGoal { get; set; }
        public int PointsEarned { get; set; }
    }

    public class PlayerFilterDto
    {
        // Existing fields
        public int? TeamId { get; set; }
        public byte? Position { get; set; }
        public decimal? MinCost { get; set; }
        public decimal? MaxCost { get; set; }
        
        // New fields for performance filtering and sorting
        public int? GameweekId { get; set; }        // Filter by specific gameweek for stats
        public string? SortBy { get; set; }          // Sort field: "points", "goals", "assists", "cleanSheets", "saves", "cost", "name"
        public string? SortOrder { get; set; }       // Sort direction: "asc" or "desc" (default: "asc")
        public bool IncludeStats { get; set; }       // Include performance stats in response (default: false)
    }

    public class PlayerStatsSummaryDto
    {
        public int TotalPoints { get; set; }        // Total points (overall or for gameweek)
        public int TotalGoals { get; set; }
        public int TotalAssists { get; set; }
        public int TotalCleanSheets { get; set; }
        public int TotalSaves { get; set; }
        public int GamesPlayed { get; set; }        // Number of gameweeks/fixtures played
    }

    public class PlayerWithStatsDto
    {
        // All existing PlayerDto fields
        public int Id { get; set; }
        public byte Position { get; set; }
        public string PositionDisplay => Position switch
        {
            1 => "GK",
            2 => "DEF",
            3 => "MID",
            4 => "FWD",
            _ => "Unknown"
        };
        public string Name { get; set; } = null!;
        public byte PlayerNum { get; set; }
        public int TeamId { get; set; }
        public string? TeamName { get; set; }
        public string? School { get; set; }
        public decimal Cost { get; set; }
        public string? PictureUrl { get; set; }
        
        // NEW: Performance stats (only included if IncludeStats = true)
        public PlayerStatsSummaryDto? Stats { get; set; }
    }
}






