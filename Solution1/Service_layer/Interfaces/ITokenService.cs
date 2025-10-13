namespace Service_layer.Interfaces
{
    public interface ITokenService
    {
        string GenerateAccessToken(int userId, string email, string username);
        string GenerateRefreshToken();
        System.Security.Claims.ClaimsPrincipal? GetPrincipalFromExpiredToken(string token);
    }
}



