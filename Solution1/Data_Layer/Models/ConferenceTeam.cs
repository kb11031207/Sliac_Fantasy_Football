namespace Data_Layer.Models
{
    public class ConferenceTeam
    {
        public int Id { get; set; }
        public string Team { get; set; } = null!;
        public string School { get; set; } = null!;
        public string? LogoUrl { get; set; }
        
        // Navigation properties
        public virtual ICollection<Player> Players { get; set; } = new List<Player>();
        public virtual ICollection<Fixture> HomeFixtures { get; set; } = new List<Fixture>();
        public virtual ICollection<Fixture> AwayFixtures { get; set; } = new List<Fixture>();
    }
}





