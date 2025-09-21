using System.ComponentModel.DataAnnotations;

namespace api_srv.Models.DTOs
{
    public class LoginRequest
    {
        [Required(ErrorMessage = "Email or username is required")]
        public string EmailOrUsername { get; set; } = string.Empty;

        [Required(ErrorMessage = "Password is required")]
        public string Password { get; set; } = string.Empty;
    }
}
