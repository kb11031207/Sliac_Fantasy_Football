namespace Data_Layer.Models
{
    public class UserGameweekScores
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int GameweekId { get; set; }
        public int TotalPoints { get; set; } = 0;
        
        // Navigation properties
        public virtual User User { get; set; } = null!;
        public virtual Gameweek Gameweek { get; set; } = null!;
    }
}



