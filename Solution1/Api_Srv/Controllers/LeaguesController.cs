using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LeaguesController : ControllerBase
    {
        private readonly ILeagueService _leagueService;

        public LeaguesController(ILeagueService leagueService)
        {
            _leagueService = leagueService;
        }

        /// <summary>
        /// Get league by ID (requires authentication - only league members can access)
        /// </summary>
        [Authorize]
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(LeagueDto), 200)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetLeague(int id)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Check if user is a member of this league
            var isMember = await _leagueService.IsUserInLeagueAsync(currentUserId, id);
            if (!isMember)
                return Forbid("You must be a member of this league to view it");

            var league = await _leagueService.GetLeagueByIdAsync(id);
            if (league == null)
                return NotFound($"League with ID {id} not found");

            return Ok(league);
        }

        /// <summary>
        /// Get league details with members (requires authentication - only league members can access)
        /// </summary>
        [Authorize]
        [HttpGet("{id}/details")]
        [ProducesResponseType(typeof(LeagueDetailsDto), 200)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetLeagueDetails(int id)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Check if user is a member of this league
            var isMember = await _leagueService.IsUserInLeagueAsync(currentUserId, id);
            if (!isMember)
                return Forbid("You must be a member of this league to view details");

            var league = await _leagueService.GetLeagueDetailsAsync(id);
            if (league == null)
                return NotFound($"League with ID {id} not found");

            return Ok(league);
        }

        /// <summary>
        /// Get all public leagues (public endpoint)
        /// </summary>
        [HttpGet("public")]
        [ProducesResponseType(typeof(IEnumerable<LeagueDto>), 200)]
        public async Task<IActionResult> GetPublicLeagues()
        {
            var leagues = await _leagueService.GetPublicLeaguesAsync();
            return Ok(leagues);
        }

        /// <summary>
        /// Get user's leagues (public endpoint - anyone can view)
        /// </summary>
        [HttpGet("user/{userId}")]
        [ProducesResponseType(typeof(IEnumerable<LeagueDto>), 200)]
        public async Task<IActionResult> GetUserLeagues(int userId)
        {
            var leagues = await _leagueService.GetUserLeaguesAsync(userId);
            return Ok(leagues);
        }

        /// <summary>
        /// Create new league (requires authentication)
        /// </summary>
        [Authorize]
        [HttpPost("user/{userId}")]
        [ProducesResponseType(typeof(LeagueDto), 201)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> CreateLeague(int userId, [FromBody] CreateLeagueDto createDto)
        {
            // Check if authenticated user is creating their own league
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != userId)
                return Forbid("You can only create leagues for your own account");

            try
            {
                var league = await _leagueService.CreateLeagueAsync(createDto, userId);
                return CreatedAtAction(nameof(GetLeague), new { id = league.Id }, league);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Join a league (requires authentication)
        /// </summary>
        [Authorize]
        [HttpPost("{leagueId}/join/{userId}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> JoinLeague(int leagueId, int userId)
        {
            // Check if authenticated user is joining for themselves
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != userId)
                return Forbid("You can only join leagues for your own account");

            try
            {
                await _leagueService.JoinLeagueAsync(userId, leagueId);
                return Ok(new { message = "Successfully joined league" });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Leave a league (requires authentication)
        /// </summary>
        [Authorize]
        [HttpPost("{leagueId}/leave/{userId}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> LeaveLeague(int leagueId, int userId)
        {
            // Check if authenticated user is leaving for themselves
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != userId)
                return Forbid("You can only leave leagues for your own account");

            try
            {
                await _leagueService.LeaveLeagueAsync(userId, leagueId);
                return Ok(new { message = "Successfully left league" });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Get league standings for a gameweek (requires authentication - only league members can access)
        /// </summary>
        [Authorize]
        [HttpGet("{leagueId}/standings/gameweek/{gameweekId}")]
        [ProducesResponseType(typeof(LeagueStandingsDto), 200)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> GetLeagueStandings(int leagueId, int gameweekId)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Check if user is a member of this league
            var isMember = await _leagueService.IsUserInLeagueAsync(currentUserId, leagueId);
            if (!isMember)
                return Forbid("You must be a member of this league to view standings");

            var standings = await _leagueService.GetLeagueStandingsAsync(leagueId, gameweekId);
            return Ok(standings);
        }

        /// <summary>
        /// Update league settings (requires authentication - only league owner can update)
        /// </summary>
        [Authorize]
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(LeagueDto), 200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> UpdateLeague(int id, [FromBody] UpdateLeagueDto updateDto)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Get league to check ownership
            var existingLeague = await _leagueService.GetLeagueByIdAsync(id);
            if (existingLeague == null)
                return NotFound($"League with ID {id} not found");

            // Only league owner can update
            if (existingLeague.Owner != currentUserId)
                return Forbid("Only the league owner can edit this league");

            try
            {
                var league = await _leagueService.UpdateLeagueAsync(id, updateDto);
                return Ok(league);
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
        /// Delete league (requires authentication - only league owner can delete)
        /// </summary>
        [Authorize]
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> DeleteLeague(int id)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Get league to check ownership
            var existingLeague = await _leagueService.GetLeagueByIdAsync(id);
            if (existingLeague == null)
                return NotFound($"League with ID {id} not found");

            // Only league owner can delete
            if (existingLeague.Owner != currentUserId)
                return Forbid("Only the league owner can delete this league");

            var result = await _leagueService.DeleteLeagueAsync(id);
            if (!result)
                return NotFound($"League with ID {id} not found");

            return NoContent();
        }

        /// <summary>
        /// Remove/kick member from league (requires authentication - only league owner can kick)
        /// </summary>
        [Authorize]
        [HttpPost("{leagueId}/kick/{userId}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> KickMember(int leagueId, int userId)
        {
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            
            // Get league to check ownership
            var league = await _leagueService.GetLeagueByIdAsync(leagueId);
            if (league == null)
                return NotFound($"League with ID {leagueId} not found");

            // Only league owner can kick members
            if (league.Owner != currentUserId)
                return Forbid("Only the league owner can remove members");

            try
            {
                await _leagueService.RemoveMemberAsync(userId, leagueId);
                return Ok(new { message = "Member removed successfully" });
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
    }
}
