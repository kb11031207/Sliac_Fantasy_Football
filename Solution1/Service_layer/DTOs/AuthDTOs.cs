using System.ComponentModel.DataAnnotations;

namespace Service_layer.DTOs
{
    public class AuthResponseDto
    {
        public int Id { get; set; }
        public string Email { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string? School { get; set; }
        public string AccessToken { get; set; } = null!;
        public string RefreshToken { get; set; } = null!;
        public DateTime AccessTokenExpiry { get; set; }
        public DateTime RefreshTokenExpiry { get; set; }
    }

    public class RefreshTokenRequestDto
    {
        [Required]
        public string AccessToken { get; set; } = null!;
        
        [Required]
        public string RefreshToken { get; set; } = null!;
    }

    public class RefreshTokenResponseDto
    {
        public string AccessToken { get; set; } = null!;
        public string RefreshToken { get; set; } = null!;
        public DateTime AccessTokenExpiry { get; set; }
        public DateTime RefreshTokenExpiry { get; set; }
    }
}



