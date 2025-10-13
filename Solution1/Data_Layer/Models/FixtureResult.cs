namespace Data_Layer.Models
{
    public class FixtureResult
    {
        public int FixtureId { get; set; }
        public byte HomeScore { get; set; }
        public byte AwayScore { get; set; }
        
        // Navigation property
        public virtual Fixture Fixture { get; set; } = null!;
    }
}





