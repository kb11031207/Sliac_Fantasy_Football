using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FixturesController : ControllerBase
    {
        private readonly IFixtureService _fixtureService;

        public FixturesController(IFixtureService fixtureService)
        {
            _fixtureService = fixtureService;
        }

        /// <summary>
        /// Get fixture by ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(FixtureDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetFixture(int id)
        {
            var fixture = await _fixtureService.GetFixtureByIdAsync(id);
            if (fixture == null)
                return NotFound($"Fixture with ID {id} not found");

            return Ok(fixture);
        }

        /// <summary>
        /// Get fixture details with player stats
        /// </summary>
        [HttpGet("{id}/details")]
        [ProducesResponseType(typeof(FixtureDetailsDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetFixtureDetails(int id)
        {
            var fixture = await _fixtureService.GetFixtureDetailsAsync(id);
            if (fixture == null)
                return NotFound($"Fixture with ID {id} not found");

            return Ok(fixture);
        }

        /// <summary>
        /// Get fixtures by gameweek
        /// </summary>
        [HttpGet("gameweek/{gameweekId}")]
        [ProducesResponseType(typeof(IEnumerable<FixtureDto>), 200)]
        public async Task<IActionResult> GetFixturesByGameweek(int gameweekId)
        {
            var fixtures = await _fixtureService.GetFixturesByGameweekAsync(gameweekId);
            return Ok(fixtures);
        }

        /// <summary>
        /// Get fixtures by team
        /// </summary>
        [HttpGet("team/{teamId}")]
        [ProducesResponseType(typeof(IEnumerable<FixtureDto>), 200)]
        public async Task<IActionResult> GetFixturesByTeam(int teamId)
        {
            var fixtures = await _fixtureService.GetFixturesByTeamAsync(teamId);
            return Ok(fixtures);
        }
    }
}



