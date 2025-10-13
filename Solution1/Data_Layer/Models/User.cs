namespace Data_Layer.Models
{
    public class User
    {
        public int Id { get; set; }
        public string? Email { get; set; }
        public string? Username { get; set; }
        public string? School { get; set; }
        public byte[] PassHash { get; set; } = null!;
        public byte[] PassSalt { get; set; } = null!;
        
        // Account lockout fields
        public int FailedLoginAttempts { get; set; } = 0;
        public DateTime? LockoutEnd { get; set; }
        
        // Refresh token fields
        public string? RefreshToken { get; set; }
        public DateTime? RefreshTokenExpiryTime { get; set; }
        
        // Navigation properties
        public virtual ICollection<League> OwnedLeagues { get; set; } = new List<League>();
        public virtual ICollection<UserLeague> UserLeagues { get; set; } = new List<UserLeague>();
        public virtual ICollection<Squad> Squads { get; set; } = new List<Squad>();
    }
}
