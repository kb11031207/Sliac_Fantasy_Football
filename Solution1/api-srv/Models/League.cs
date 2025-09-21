using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace api_srv.Models
{
    [Table("leagues")]
    public class League
    {
        [Key]
        [Column("Id")]
        public int Id { get; set; }

        [Column("owner")]
        [Required]
        public int Owner { get; set; }

        [Column("type")]
        public bool Type { get; set; } = false;

        // Navigation properties
        [ForeignKey("Owner")]
        public virtual User OwnerUser { get; set; } = null!;
        public virtual ICollection<UserLeague> UserLeagues { get; set; } = new List<UserLeague>();
    }
}
