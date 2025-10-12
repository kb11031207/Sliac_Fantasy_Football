namespace Data_Layer.Models
{
    public class Fixture
    {
        public int Id { get; set; }
        public int GameweekId { get; set; }
        public int HomeTeamId { get; set; }
        public int AwayTeamId { get; set; }
        public DateTime Kickoff { get; set; }
        
        // Navigation properties
        public virtual Gameweek Gameweek { get; set; } = null!;
        public virtual ConferenceTeam HomeTeam { get; set; } = null!;
        public virtual ConferenceTeam AwayTeam { get; set; } = null!;
        public virtual FixtureResult? Result { get; set; }
        public virtual ICollection<PlayerFixtureStats> PlayerStats { get; set; } = new List<PlayerFixtureStats>();
    }
}



