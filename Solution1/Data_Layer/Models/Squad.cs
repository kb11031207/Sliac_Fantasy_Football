namespace Data_Layer.Models
{
    public class Squad
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int GameweekId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        
        // Navigation properties
        public virtual User User { get; set; } = null!;
        public virtual Gameweek Gameweek { get; set; } = null!;
        public virtual ICollection<SquadPlayer> SquadPlayers { get; set; } = new List<SquadPlayer>();
    }
}

