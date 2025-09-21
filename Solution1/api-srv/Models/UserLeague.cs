using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace api_srv.Models
{
    [Table("usersXleagues")]
    public class UserLeague
    {
        [Column("userId")]
        public int UserId { get; set; }

        [Column("leagueId")]
        public int LeagueId { get; set; }

        // Navigation properties
        [ForeignKey("UserId")]
        public virtual User User { get; set; } = null!;

        [ForeignKey("LeagueId")]
        public virtual League League { get; set; } = null!;
    }
}
