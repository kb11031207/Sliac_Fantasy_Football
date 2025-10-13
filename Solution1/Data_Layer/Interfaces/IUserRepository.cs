using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface IUserRepository : IGenericRepository<User>
    {
        Task<User?> GetByEmailAsync(string email);
        Task<User?> GetByUsernameAsync(string username);
        Task<User?> GetUserWithSquadsAsync(int userId);
        Task<bool> EmailExistsAsync(string email);
        Task<bool> UsernameExistsAsync(string username);
        Task<User?> GetByRefreshTokenAsync(string refreshToken);
        Task<bool> UpdateRefreshTokenAsync(int userId, string refreshToken, DateTime expiryTime);
        Task<bool> IncrementFailedLoginAttemptsAsync(int userId);
        Task<bool> ResetFailedLoginAttemptsAsync(int userId);
        Task<bool> SetLockoutEndAsync(int userId, DateTime lockoutEnd);
    }
}
