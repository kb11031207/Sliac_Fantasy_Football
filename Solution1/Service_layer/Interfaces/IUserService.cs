using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface IUserService
    {
        Task<UserDto?> GetUserByIdAsync(int id);
        Task<UserDto?> AuthenticateAsync(string email, string password);
        Task<AuthResponseDto?> AuthenticateWithTokensAsync(string email, string password);
        Task<RefreshTokenResponseDto?> RefreshTokenAsync(string accessToken, string refreshToken);
        Task<UserDto> RegisterAsync(RegisterUserDto registerDto);
        Task<UserDto> UpdateUserAsync(int id, UpdateUserDto updateDto);
        Task<bool> DeleteUserAsync(int id);
        Task<bool> ChangePasswordAsync(int id, string currentPassword, string newPassword);
        Task<IEnumerable<UserDto>> GetAllUsersAsync();
    }
}
