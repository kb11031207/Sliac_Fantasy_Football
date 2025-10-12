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
        /// Get squad by ID
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
        /// Get user's squads
        /// </summary>
        [HttpGet("user/{userId}")]
        [ProducesResponseType(typeof(IEnumerable<SquadDto>), 200)]
        public async Task<IActionResult> GetUserSquads(int userId)
        {
            var squads = await _squadService.GetUserSquadsAsync(userId);
            return Ok(squads);
        }

        /// <summary>
        /// Get user's squad for specific gameweek
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
        /// Create new squad
        /// </summary>
        [HttpPost("user/{userId}")]
        [ProducesResponseType(typeof(SquadDto), 201)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> CreateSquad(int userId, [FromBody] CreateSquadDto createDto)
        {
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
        /// Update existing squad
        /// </summary>
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(SquadDto), 200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> UpdateSquad(int id, [FromBody] UpdateSquadDto updateDto)
        {
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
        /// Delete squad
        /// </summary>
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> DeleteSquad(int id)
        {
            var result = await _squadService.DeleteSquadAsync(id);
            if (!result)
                return NotFound($"Squad with ID {id} not found");

            return NoContent();
        }
    }
}



