namespace Data_Layer.Models
{
    public class SquadPlayer
    {
        public int Id { get; set; }
        public int SquadId { get; set; }
        public int PlayerId { get; set; }
        public bool IsStarter { get; set; } = true;
        public bool IsCaptain { get; set; } = false;
        public bool IsVice { get; set; } = false;
        public decimal PlayerCost { get; set; }
        
        // Navigation properties
        public virtual Squad Squad { get; set; } = null!;
        public virtual Player Player { get; set; } = null!;
    }
}

