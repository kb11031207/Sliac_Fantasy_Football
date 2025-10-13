namespace Data_Layer.Models
{
    public class League
    {
        public int Id { get; set; }
        public int Owner { get; set; }
        public bool Type { get; set; } // 0 = private, 1 = public
        
        // Navigation properties
        public virtual User OwnerUser { get; set; } = null!;
        public virtual ICollection<UserLeague> UserLeagues { get; set; } = new List<UserLeague>();
    }
}




