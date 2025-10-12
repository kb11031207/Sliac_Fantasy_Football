using System.ComponentModel.DataAnnotations;

namespace Service_layer.DTOs
{
    public class SquadDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int GameweekId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public List<SquadPlayerDto> Players { get; set; } = new List<SquadPlayerDto>();
        public decimal TotalCost { get; set; }
        public int TotalPoints { get; set; }
    }

    public class CreateSquadDto
    {
        [Required(ErrorMessage = "Gameweek is required")]
        public int GameweekId { get; set; }

        [Required(ErrorMessage = "Players are required")]
        [MinLength(15, ErrorMessage = "Squad must have exactly 15 players")]
        [MaxLength(15, ErrorMessage = "Squad must have exactly 15 players")]
        public List<int> PlayerIds { get; set; } = new List<int>();

        public int? CaptainId { get; set; }
        public int? ViceCaptainId { get; set; }
    }

    public class UpdateSquadDto
    {
        [Required(ErrorMessage = "Players are required")]
        [MinLength(15, ErrorMessage = "Squad must have exactly 15 players")]
        [MaxLength(15, ErrorMessage = "Squad must have exactly 15 players")]
        public List<int> PlayerIds { get; set; } = new List<int>();

        public int? CaptainId { get; set; }
        public int? ViceCaptainId { get; set; }
    }

    public class SquadPlayerDto
    {
        public int PlayerId { get; set; }
        public string? PlayerName { get; set; }
        public byte Position { get; set; }
        public string? TeamName { get; set; }
        public bool IsStarter { get; set; }
        public bool IsCaptain { get; set; }
        public bool IsVice { get; set; }
        public decimal PlayerCost { get; set; }
        public int? Points { get; set; }
    }
}



