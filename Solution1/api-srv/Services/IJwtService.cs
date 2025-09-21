using api_srv.Models;

namespace api_srv.Services
{
    public interface IJwtService
    {
        string GenerateToken(User user);
        int? ValidateToken(string token);
    }
}
