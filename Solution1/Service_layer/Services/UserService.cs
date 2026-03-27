using System.Security.Claims;
using System.Security.Cryptography;
using AutoMapper;
using Microsoft.Extensions.Configuration;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly ITokenService _tokenService;
        private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;

        private const int MaxFailedLoginAttempts = 5;
        private const int LockoutDurationMinutes = 15;

        public UserService(
            IUserRepository userRepository, 
            ITokenService tokenService,
            IMapper mapper,
            IConfiguration configuration)
        {
            _userRepository = userRepository;
            _tokenService = tokenService;
            _mapper = mapper;
            _configuration = configuration;
        }

        public async Task<UserDto?> GetUserByIdAsync(int id)
        {
            var user = await _userRepository.GetByIdAsync(id);
            return _mapper.Map<UserDto>(user);
        }

        public async Task<UserDto?> AuthenticateAsync(string email, string password)
        {
            var user = await _userRepository.GetByEmailAsync(email);
            if (user == null)
                return null;

            // Check if account is locked
            if (user.LockoutEnd.HasValue && user.LockoutEnd.Value > DateTime.UtcNow)
            {
                return null; // Account is locked
            }

            // Reset lockout if expired
            if (user.LockoutEnd.HasValue && user.LockoutEnd.Value <= DateTime.UtcNow)
            {
                await _userRepository.ResetFailedLoginAttemptsAsync(user.Id);
                user.FailedLoginAttempts = 0;
                user.LockoutEnd = null;
            }

            // Verify password
            if (!VerifyPasswordHash(password, user.PassHash, user.PassSalt))
            {
                // Increment failed attempts
                await _userRepository.IncrementFailedLoginAttemptsAsync(user.Id);
                user.FailedLoginAttempts++;

                // Lock account if max attempts reached
                if (user.FailedLoginAttempts >= MaxFailedLoginAttempts)
                {
                    var lockoutEnd = DateTime.UtcNow.AddMinutes(LockoutDurationMinutes);
                    await _userRepository.SetLockoutEndAsync(user.Id, lockoutEnd);
                }

                return null;
            }

            // Successful login - reset failed attempts
            if (user.FailedLoginAttempts > 0)
            {
                await _userRepository.ResetFailedLoginAttemptsAsync(user.Id);
            }

            return _mapper.Map<UserDto>(user);
        }

        public async Task<AuthResponseDto?> AuthenticateWithTokensAsync(string email, string password)
        {
            var user = await _userRepository.GetByEmailAsync(email);
            if (user == null)
                return null;

            // Check if account is locked
            if (user.LockoutEnd.HasValue && user.LockoutEnd.Value > DateTime.UtcNow)
            {
                throw new UnauthorizedAccessException($"Account is locked until {user.LockoutEnd.Value.ToLocalTime()}. Please try again later.");
            }

            // Reset lockout if expired
            if (user.LockoutEnd.HasValue && user.LockoutEnd.Value <= DateTime.UtcNow)
            {
                await _userRepository.ResetFailedLoginAttemptsAsync(user.Id);
                user.FailedLoginAttempts = 0;
                user.LockoutEnd = null;
            }

            // Verify password
            if (!VerifyPasswordHash(password, user.PassHash, user.PassSalt))
            {
                // Increment failed attempts
                await _userRepository.IncrementFailedLoginAttemptsAsync(user.Id);
                user.FailedLoginAttempts++;

                // Lock account if max attempts reached
                if (user.FailedLoginAttempts >= MaxFailedLoginAttempts)
                {
                    var lockoutEnd = DateTime.UtcNow.AddMinutes(LockoutDurationMinutes);
                    await _userRepository.SetLockoutEndAsync(user.Id, lockoutEnd);
                    throw new UnauthorizedAccessException($"Account locked due to too many failed login attempts. Try again after {LockoutDurationMinutes} minutes.");
                }

                return null;
            }

            // Successful login - reset failed attempts
            if (user.FailedLoginAttempts > 0)
            {
                await _userRepository.ResetFailedLoginAttemptsAsync(user.Id);
            }

            // Generate tokens
            var accessToken = _tokenService.GenerateAccessToken(user.Id, user.Email!, user.Username!);
            var refreshToken = _tokenService.GenerateRefreshToken();
            
            var accessTokenExpiry = DateTime.UtcNow.AddMinutes(
                Convert.ToDouble(_configuration["JwtSettings:AccessTokenExpirationMinutes"]));
            var refreshTokenExpiry = DateTime.UtcNow.AddDays(
                Convert.ToDouble(_configuration["JwtSettings:RefreshTokenExpirationDays"]));

            // Save refresh token to database
            await _userRepository.UpdateRefreshTokenAsync(user.Id, refreshToken, refreshTokenExpiry);

            return new AuthResponseDto
            {
                Id = user.Id,
                Email = user.Email!,
                Username = user.Username!,
                School = user.School,
                AccessToken = accessToken,
                RefreshToken = refreshToken,
                AccessTokenExpiry = accessTokenExpiry,
                RefreshTokenExpiry = refreshTokenExpiry
            };
        }

        public async Task<RefreshTokenResponseDto?> RefreshTokenAsync(string accessToken, string refreshToken)
        {
            var principal = _tokenService.GetPrincipalFromExpiredToken(accessToken);
            if (principal == null)
                return null;

            var userId = int.Parse(principal.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            var user = await _userRepository.GetByIdAsync(userId);

            if (user == null || user.RefreshToken != refreshToken || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
                return null;

            // Generate new tokens
            var newAccessToken = _tokenService.GenerateAccessToken(user.Id, user.Email!, user.Username!);
            var newRefreshToken = _tokenService.GenerateRefreshToken();
            
            var accessTokenExpiry = DateTime.UtcNow.AddMinutes(
                Convert.ToDouble(_configuration["JwtSettings:AccessTokenExpirationMinutes"]));
            var refreshTokenExpiry = DateTime.UtcNow.AddDays(
                Convert.ToDouble(_configuration["JwtSettings:RefreshTokenExpirationDays"]));

            // Update refresh token in database
            await _userRepository.UpdateRefreshTokenAsync(user.Id, newRefreshToken, refreshTokenExpiry);

            return new RefreshTokenResponseDto
            {
                AccessToken = newAccessToken,
                RefreshToken = newRefreshToken,
                AccessTokenExpiry = accessTokenExpiry,
                RefreshTokenExpiry = refreshTokenExpiry
            };
        }

        public async Task<UserDto> RegisterAsync(RegisterUserDto registerDto)
        {
            // Validate email uniqueness
            if (await _userRepository.EmailExistsAsync(registerDto.Email))
                throw new ArgumentException("Email already exists");

            // Validate username uniqueness
            if (await _userRepository.UsernameExistsAsync(registerDto.Username))
                throw new ArgumentException("Username already exists");

            // Create password hash
            CreatePasswordHash(registerDto.Password, out byte[] passwordHash, out byte[] passwordSalt);

            var user = new User
            {
                Email = registerDto.Email,
                Username = registerDto.Username,
                School = registerDto.School,
                PassHash = passwordHash,
                PassSalt = passwordSalt
            };

            var createdUser = await _userRepository.AddAsync(user);
            return _mapper.Map<UserDto>(createdUser);
        }

        public async Task<UserDto> UpdateUserAsync(int id, UpdateUserDto updateDto)
        {
            var user = await _userRepository.GetByIdAsync(id);
            if (user == null)
                throw new KeyNotFoundException($"User with ID {id} not found");

            // Check email uniqueness if changing
            if (updateDto.Email != null && updateDto.Email != user.Email)
            {
                if (await _userRepository.EmailExistsAsync(updateDto.Email))
                    throw new ArgumentException("Email already exists");
                user.Email = updateDto.Email;
            }

            // Check username uniqueness if changing
            if (updateDto.Username != null && updateDto.Username != user.Username)
            {
                if (await _userRepository.UsernameExistsAsync(updateDto.Username))
                    throw new ArgumentException("Username already exists");
                user.Username = updateDto.Username;
            }

            if (updateDto.School != null)
                user.School = updateDto.School;

            var updatedUser = await _userRepository.UpdateAsync(user);
            return _mapper.Map<UserDto>(updatedUser);
        }

        public async Task<bool> DeleteUserAsync(int id)
        {
            var user = await _userRepository.GetByIdAsync(id);
            if (user == null)
                return false;

            return await _userRepository.RemoveAsync(user);
        }

        public async Task<bool> ChangePasswordAsync(int id, string currentPassword, string newPassword)
        {
            var user = await _userRepository.GetByIdAsync(id);
            if (user == null)
                throw new KeyNotFoundException($"User with ID {id} not found");

            // Verify current password
            if (!VerifyPasswordHash(currentPassword, user.PassHash, user.PassSalt))
                throw new ArgumentException("Current password is incorrect");

            // Create new password hash
            CreatePasswordHash(newPassword, out byte[] passwordHash, out byte[] passwordSalt);
            user.PassHash = passwordHash;
            user.PassSalt = passwordSalt;

            await _userRepository.UpdateAsync(user);
            return true;
        }

        public async Task<IEnumerable<UserDto>> GetAllUsersAsync()
        {
            var users = await _userRepository.GetAllAsync();
            return _mapper.Map<IEnumerable<UserDto>>(users);
        }

        private void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            // Generate 16-byte salt to match database schema varbinary(16)
            passwordSalt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(passwordSalt);
            }

            // Generate 64-byte hash to match database schema varbinary(64)
            using var hmac = new HMACSHA512(passwordSalt);
            passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        }

        private bool VerifyPasswordHash(string password, byte[] passwordHash, byte[] passwordSalt)
        {
            using var hmac = new HMACSHA512(passwordSalt);
            var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            return computedHash.SequenceEqual(passwordHash);
        }
    }
}
