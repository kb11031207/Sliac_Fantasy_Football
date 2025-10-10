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
        /// Get league by ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(LeagueDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetLeague(int id)
        {
            var league = await _leagueService.GetLeagueByIdAsync(id);
            if (league == null)
                return NotFound($"League with ID {id} not found");

            return Ok(league);
        }

        /// <summary>
        /// Get league details with members
        /// </summary>
        [HttpGet("{id}/details")]
        [ProducesResponseType(typeof(LeagueDetailsDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetLeagueDetails(int id)
        {
            var league = await _leagueService.GetLeagueDetailsAsync(id);
            if (league == null)
                return NotFound($"League with ID {id} not found");

            return Ok(league);
        }

        /// <summary>
        /// Get all public leagues
        /// </summary>
        [HttpGet("public")]
        [ProducesResponseType(typeof(IEnumerable<LeagueDto>), 200)]
        public async Task<IActionResult> GetPublicLeagues()
        {
            var leagues = await _leagueService.GetPublicLeaguesAsync();
            return Ok(leagues);
        }

        /// <summary>
        /// Get user's leagues
        /// </summary>
        [HttpGet("user/{userId}")]
        [ProducesResponseType(typeof(IEnumerable<LeagueDto>), 200)]
        public async Task<IActionResult> GetUserLeagues(int userId)
        {
            var leagues = await _leagueService.GetUserLeaguesAsync(userId);
            return Ok(leagues);
        }

        /// <summary>
        /// Create new league
        /// </summary>
        [HttpPost("user/{userId}")]
        [ProducesResponseType(typeof(LeagueDto), 201)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> CreateLeague(int userId, [FromBody] CreateLeagueDto createDto)
        {
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
        /// Join a league
        /// </summary>
        [HttpPost("{leagueId}/join/{userId}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> JoinLeague(int leagueId, int userId)
        {
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
        /// Leave a league
        /// </summary>
        [HttpPost("{leagueId}/leave/{userId}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> LeaveLeague(int leagueId, int userId)
        {
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
        /// Get league standings for a gameweek
        /// </summary>
        [HttpGet("{leagueId}/standings/gameweek/{gameweekId}")]
        [ProducesResponseType(typeof(LeagueStandingsDto), 200)]
        public async Task<IActionResult> GetLeagueStandings(int leagueId, int gameweekId)
        {
            var standings = await _leagueService.GetLeagueStandingsAsync(leagueId, gameweekId);
            return Ok(standings);
        }
    }
}

