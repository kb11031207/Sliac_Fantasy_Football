using System.ComponentModel.DataAnnotations;

namespace api_srv.Models.DTOs
{
    public class CreateLeagueRequest
    {
        [Required(ErrorMessage = "League type is required")]
        public bool Type { get; set; }
    }
}
