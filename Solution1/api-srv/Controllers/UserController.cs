using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using api_srv.Data;
using api_srv.Models;
using api_srv.Models.DTOs;
using api_srv.Services;
using System.Text.RegularExpressions;

namespace api_srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IPasswordService _passwordService;
        private readonly IJwtService _jwtService;
        private readonly ILogger<UserController> _logger;

        public UserController(
            ApplicationDbContext context, 
            IPasswordService passwordService, 
            IJwtService jwtService,
            ILogger<UserController> logger)
        {
            _context = context;
            _passwordService = passwordService;
            _jwtService = jwtService;
            _logger = logger;
        }

        [HttpPost("register")]
        public async Task<ActionResult<AuthResponse>> Register([FromBody] RegisterRequest request)
        {
            try
            {
                // Sanitize inputs
                request.Email = SanitizeInput(request.Email).ToLowerInvariant();
                request.Username = SanitizeInput(request.Username);
                request.School = !string.IsNullOrEmpty(request.School) ? SanitizeInput(request.School) : null;

                // Additional validation
                if (!IsValidEmail(request.Email))
                {
                    return BadRequest(new { message = "Invalid email format" });
                }

                // Check if user already exists
                var existingUser = await _context.Users
                    .FirstOrDefaultAsync(u => u.Email == request.Email || u.Username == request.Username);

                if (existingUser != null)
                {
                    return Conflict(new { message = "User with this email or username already exists" });
                }

                // Hash password
                var (hash, salt) = _passwordService.HashPassword(request.Password);

                // Create new user
                var user = new User
                {
                    Email = request.Email,
                    Username = request.Username,
                    School = request.School,
                    PassHash = hash,
                    PassSalt = salt
                };

                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                // Generate JWT token
                var token = _jwtService.GenerateToken(user);
                var expiresAt = DateTime.UtcNow.AddHours(24);

                var response = new AuthResponse
                {
                    Token = token,
                    ExpiresAt = expiresAt,
                    User = new UserInfo
                    {
                        Id = user.Id,
                        Email = user.Email,
                        Username = user.Username,
                        School = user.School
                    }
                };

                _logger.LogInformation("User {Username} registered successfully", user.Username);
                return CreatedAtAction(nameof(Register), new { id = user.Id }, response);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred during user registration");
                return StatusCode(500, new { message = "An error occurred during registration" });
            }
        }

        [HttpPost("login")]
        public async Task<ActionResult<AuthResponse>> Login([FromBody] LoginRequest request)
        {
            try
            {
                // Sanitize input
                request.EmailOrUsername = SanitizeInput(request.EmailOrUsername).ToLowerInvariant();

                // Find user by email or username
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => 
                        u.Email == request.EmailOrUsername || 
                        u.Username!.ToLower() == request.EmailOrUsername);

                if (user == null)
                {
                    return Unauthorized(new { message = "Invalid credentials" });
                }

                // Verify password
                if (!_passwordService.VerifyPassword(request.Password, user.PassHash, user.PassSalt))
                {
                    return Unauthorized(new { message = "Invalid credentials" });
                }

                // Generate JWT token
                var token = _jwtService.GenerateToken(user);
                var expiresAt = DateTime.UtcNow.AddHours(24);

                var response = new AuthResponse
                {
                    Token = token,
                    ExpiresAt = expiresAt,
                    User = new UserInfo
                    {
                        Id = user.Id,
                        Email = user.Email!,
                        Username = user.Username!,
                        School = user.School
                    }
                };

                _logger.LogInformation("User {Username} logged in successfully", user.Username);
                return Ok(response);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred during login");
                return StatusCode(500, new { message = "An error occurred during login" });
            }
        }

        private static string SanitizeInput(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            // Remove any potentially harmful characters
            var sanitized = input.Trim();
            
            // Remove any HTML tags
            sanitized = Regex.Replace(sanitized, "<.*?>", string.Empty);
            
            // Remove any script tags or javascript
            sanitized = Regex.Replace(sanitized, @"<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>", string.Empty, RegexOptions.IgnoreCase);
            
            return sanitized;
        }

        private static bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            var emailRegex = new Regex(@"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
            return emailRegex.IsMatch(email);
        }
    }
}
