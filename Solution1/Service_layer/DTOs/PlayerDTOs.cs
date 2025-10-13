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
        public int PointsEarned { get; set; }
    }

    public class PlayerFilterDto
    {
        public int? TeamId { get; set; }
        public byte? Position { get; set; }
        public decimal? MinCost { get; set; }
        public decimal? MaxCost { get; set; }
    }
}





