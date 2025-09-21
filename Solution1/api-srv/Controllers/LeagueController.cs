using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using api_srv.Data;
using api_srv.Models;
using api_srv.Models.DTOs;
using api_srv.Services;
using System.Security.Claims;

namespace api_srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class LeagueController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<LeagueController> _logger;

        public LeagueController(ApplicationDbContext context, ILogger<LeagueController> logger)
        {
            _context = context;
            _logger = logger;
        }

        [HttpPost("create")]
        public async Task<ActionResult<League>> CreateLeague([FromBody] CreateLeagueRequest request)
        {
            try
            {
                // Get user ID from JWT token claims
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out int userId))
                {
                    return Unauthorized(new { message = "Invalid token" });
                }

                // Verify user exists
                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                {
                    return Unauthorized(new { message = "User not found" });
                }

                // Create new league
                var league = new League
                {
                    Owner = userId,
                    Type = request.Type
                };

                _context.Leagues.Add(league);
                await _context.SaveChangesAsync();

                // Automatically add the owner to the league
                var userLeague = new UserLeague
                {
                    UserId = userId,
                    LeagueId = league.Id
                };

                _context.UserLeagues.Add(userLeague);
                await _context.SaveChangesAsync();

                _logger.LogInformation("League {LeagueId} created by user {UserId}", league.Id, userId);

                return CreatedAtAction(nameof(CreateLeague), new { id = league.Id }, league);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred during league creation");
                return StatusCode(500, new { message = "An error occurred during league creation" });
            }
        }

        [HttpGet("my-leagues")]
        public async Task<ActionResult<IEnumerable<League>>> GetMyLeagues()
        {
            try
            {
                // Get user ID from JWT token claims
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out int userId))
                {
                    return Unauthorized(new { message = "Invalid token" });
                }

                // Get all leagues the user is part of
                var leagues = await _context.UserLeagues
                    .Where(ul => ul.UserId == userId)
                    .Include(ul => ul.League)
                    .ThenInclude(l => l.OwnerUser)
                    .Select(ul => ul.League)
                    .ToListAsync();

                return Ok(leagues);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while fetching user leagues");
                return StatusCode(500, new { message = "An error occurred while fetching leagues" });
            }
        }
    }
}
