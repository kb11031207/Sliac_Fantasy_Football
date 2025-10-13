using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SquadsController : ControllerBase
    {
        private readonly ISquadService _squadService;

        public SquadsController(ISquadService squadService)
        {
            _squadService = squadService;
        }

        /// <summary>
        /// Get squad by ID (public - anyone can view squads)
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(SquadDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetSquad(int id)
        {
            var squad = await _squadService.GetSquadByIdAsync(id);
            if (squad == null)
                return NotFound($"Squad with ID {id} not found");

            return Ok(squad);
        }

        /// <summary>
        /// Get user's squads (public - anyone can view)
        /// </summary>
        [HttpGet("user/{userId}")]
        [ProducesResponseType(typeof(IEnumerable<SquadDto>), 200)]
        public async Task<IActionResult> GetUserSquads(int userId)
        {
            var squads = await _squadService.GetUserSquadsAsync(userId);
            return Ok(squads);
        }

        /// <summary>
        /// Get user's squad for specific gameweek (public - anyone can view)
        /// </summary>
        [HttpGet("user/{userId}/gameweek/{gameweekId}")]
        [ProducesResponseType(typeof(SquadDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetUserSquadForGameweek(int userId, int gameweekId)
        {
            var squad = await _squadService.GetUserSquadForGameweekAsync(userId, gameweekId);
            if (squad == null)
                return NotFound($"Squad not found for user {userId} in gameweek {gameweekId}");

            return Ok(squad);
        }

        /// <summary>
        /// Create new squad (requires authentication - user must be creating their own squad)
        /// </summary>
        [Authorize]
        [HttpPost("user/{userId}")]
        [ProducesResponseType(typeof(SquadDto), 201)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        public async Task<IActionResult> CreateSquad(int userId, [FromBody] CreateSquadDto createDto)
        {
            // Check if authenticated user is creating their own squad
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (currentUserId != userId)
                return Forbid("You can only create squads for your own account");

            try
            {
                var squad = await _squadService.CreateSquadAsync(userId, createDto);
                return CreatedAtAction(nameof(GetSquad), new { id = squad.Id }, squad);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// Update existing squad (requires authentication - only squad owner can update)
        /// </summary>
        [Authorize]
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(SquadDto), 200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> UpdateSquad(int id, [FromBody] UpdateSquadDto updateDto)
        {
            // Get squad to check ownership
            var existingSquad = await _squadService.GetSquadByIdAsync(id);
            if (existingSquad == null)
                return NotFound($"Squad with ID {id} not found");

            // Check if authenticated user owns the squad
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (existingSquad.UserId != currentUserId)
                return Forbid("You can only update your own squads");

            try
            {
                var squad = await _squadService.UpdateSquadAsync(id, updateDto);
                return Ok(squad);
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
        /// Delete squad (requires authentication - only squad owner can delete)
        /// </summary>
        [Authorize]
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(403)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> DeleteSquad(int id)
        {
            // Get squad to check ownership
            var existingSquad = await _squadService.GetSquadByIdAsync(id);
            if (existingSquad == null)
                return NotFound($"Squad with ID {id} not found");

            // Check if authenticated user owns the squad
            var currentUserId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            if (existingSquad.UserId != currentUserId)
                return Forbid("You can only delete your own squads");

            var result = await _squadService.DeleteSquadAsync(id);
            if (!result)
                return NotFound($"Squad with ID {id} not found");

            return NoContent();
        }
    }
}
