namespace Data_Layer.Models
{
    public class PlayerGameweekStatsAggregate
    {
        public int PlayerId { get; set; }
        public string PlayerName { get; set; } = null!;
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
    }
}
