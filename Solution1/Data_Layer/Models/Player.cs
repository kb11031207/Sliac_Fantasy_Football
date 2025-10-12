namespace Data_Layer.Models
{
    public class Player
    {
        public int Id { get; set; }
        public byte Position { get; set; } // 1=GK, 2=DEF, 3=MID, 4=FWD
        public string Name { get; set; } = null!;
        public byte PlayerNum { get; set; }
        public int TeamId { get; set; }
        public decimal Cost { get; set; } = 4.0m;
        public string? PictureUrl { get; set; }
        
        // Navigation properties
        public virtual ConferenceTeam Team { get; set; } = null!;
        public virtual ICollection<SquadPlayer> SquadPlayers { get; set; } = new List<SquadPlayer>();
        public virtual ICollection<PlayerGameweekStats> GameweekStats { get; set; } = new List<PlayerGameweekStats>();
    }
}



