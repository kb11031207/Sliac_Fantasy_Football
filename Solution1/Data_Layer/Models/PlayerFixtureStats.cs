namespace Data_Layer.Models
{
    public class PlayerFixtureStats
    {
        public int PlayerId { get; set; }
        public int FixtureId { get; set; }
        public byte MinutesPlayed { get; set; } = 0;
        public byte Goals { get; set; } = 0;
        public byte Assists { get; set; } = 0;
        public byte YellowCards { get; set; } = 0;
        public byte RedCards { get; set; } = 0;
        public bool CleanSheet { get; set; } = false;
        public byte GoalsConceded { get; set; } = 0;
        public byte OwnGoals { get; set; } = 0;
        public byte Saves { get; set; } = 0;
        
        // Navigation properties
        public virtual Player Player { get; set; } = null!;
        public virtual Fixture Fixture { get; set; } = null!;
    }
}

