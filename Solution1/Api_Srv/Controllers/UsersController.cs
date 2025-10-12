using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        /// <summary>
        /// Get user by ID (requires authentication)
        /// </summary>
        [Authorize]
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(UserDto), 200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> GetUser(int id)
        {
            // Check if user is accessing their own data
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != id)
                return Forbid("You can only access your own user information");

            var user = await _userService.GetUserByIdAsync(id);
            if (user == null)
                return NotFound($"User with ID {id} not found");

            return Ok(user);
        }

        /// <summary>
        /// Get all users (public endpoint for testing)
        /// </summary>
        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<UserDto>), 200)]
        public async Task<IActionResult> GetAllUsers()
        {
            var users = await _userService.GetAllUsersAsync();
            return Ok(users);
        }

        /// <summary>
        /// Register new user (public endpoint)
        /// </summary>
        [AllowAnonymous]
        [HttpPost("register")]
        [ProducesResponseType(typeof(UserDto), 201)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> Register([FromBody] RegisterUserDto registerDto)
        {
            try
            {
                var user = await _userService.RegisterAsync(registerDto);
                return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// User login - returns JWT tokens (public endpoint)
        /// </summary>
        [AllowAnonymous]
        [HttpPost("login")]
        [ProducesResponseType(typeof(AuthResponseDto), 200)]
        [ProducesResponseType(401)]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            try
            {
                var authResponse = await _userService.AuthenticateWithTokensAsync(loginDto.Email, loginDto.Password);
                if (authResponse == null)
                    return Unauthorized(new { error = "Invalid email or password" });

                return Ok(authResponse);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Refresh access token using refresh token (public endpoint)
        /// </summary>
        [AllowAnonymous]
        [HttpPost("refresh-token")]
        [ProducesResponseType(typeof(RefreshTokenResponseDto), 200)]
        [ProducesResponseType(401)]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequestDto refreshTokenRequest)
        {
            var refreshResponse = await _userService.RefreshTokenAsync(
                refreshTokenRequest.AccessToken, 
                refreshTokenRequest.RefreshToken);

            if (refreshResponse == null)
                return Unauthorized(new { error = "Invalid or expired refresh token" });

            return Ok(refreshResponse);
        }

        /// <summary>
        /// Update user (requires authentication and user must be updating their own account)
        /// </summary>
        [Authorize]
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(UserDto), 200)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] UpdateUserDto updateDto)
        {
            // Check if user is updating their own account
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != id)
                return Forbid("You can only update your own account");

            try
            {
                var user = await _userService.UpdateUserAsync(id, updateDto);
                return Ok(user);
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { error = ex.Message });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Change password (requires authentication)
        /// </summary>
        [Authorize]
        [HttpPost("{id}/change-password")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> ChangePassword(int id, [FromBody] ChangePasswordDto changePasswordDto)
        {
            // Check if user is changing their own password
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != id)
                return Forbid("You can only change your own password");

            try
            {
                await _userService.ChangePasswordAsync(id, changePasswordDto.CurrentPassword, changePasswordDto.NewPassword);
                return Ok(new { message = "Password changed successfully" });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { error = ex.Message });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Delete user (requires authentication)
        /// </summary>
        [Authorize]
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> DeleteUser(int id)
        {
            // Check if user is deleting their own account
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != id)
                return Forbid("You can only delete your own account");

            var result = await _userService.DeleteUserAsync(id);
            if (!result)
                return NotFound($"User with ID {id} not found");

            return NoContent();
        }
    }
}
