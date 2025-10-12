using System.Security.Cryptography;
using AutoMapper;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public UserService(IUserRepository userRepository, IMapper mapper)
        {
            _userRepository = userRepository;
            _mapper = mapper;
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

            if (!VerifyPasswordHash(password, user.PassHash, user.PassSalt))
                return null;

            return _mapper.Map<UserDto>(user);
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

