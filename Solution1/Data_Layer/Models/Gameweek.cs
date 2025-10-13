namespace Data_Layer.Models
{
    public class Gameweek
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public bool IsComplete { get; set; } = false;
        
        // Navigation properties
        public virtual ICollection<Squad> Squads { get; set; } = new List<Squad>();
        public virtual ICollection<Fixture> Fixtures { get; set; } = new List<Fixture>();
    }
}





