namespace Data_Layer.Models
{
    public class UserLeague
    {
        public int UserId { get; set; }
        public int LeagueId { get; set; }
        
        // Navigation properties
        public virtual User User { get; set; } = null!;
        public virtual League League { get; set; } = null!;
    }
}



