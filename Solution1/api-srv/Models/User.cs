using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace api_srv.Models
{
    [Table("users")]
    public class User
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Column("email")]
        [StringLength(256)]
        public string? Email { get; set; }

        [Column("username")]
        [StringLength(64)]
        public string? Username { get; set; }

        [Column("school")]
        [StringLength(100)]
        public string? School { get; set; }

        [Column("passHash")]
        [Required]
        public byte[] PassHash { get; set; } = null!;

        [Column("passSalt")]
        [Required]
        public byte[] PassSalt { get; set; } = null!;

        // Navigation properties
        public virtual ICollection<League> OwnedLeagues { get; set; } = new List<League>();
        public virtual ICollection<UserLeague> UserLeagues { get; set; } = new List<UserLeague>();
    }
}
