using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GameweeksController : ControllerBase
    {
        private readonly IGameweekService _gameweekService;

        public GameweeksController(IGameweekService gameweekService)
        {
            _gameweekService = gameweekService;
        }

        /// <summary>
        /// Get all gameweeks
        /// </summary>
        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<GameweekDto>), 200)]
        public async Task<IActionResult> GetAllGameweeks()
        {
            var gameweeks = await _gameweekService.GetAllGameweeksAsync();
            return Ok(gameweeks);
        }

        /// <summary>
        /// Get gameweek by ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(GameweekDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetGameweek(int id)
        {
            var gameweek = await _gameweekService.GetGameweekByIdAsync(id);
            if (gameweek == null)
                return NotFound($"Gameweek with ID {id} not found");

            return Ok(gameweek);
        }

        /// <summary>
        /// Get current gameweek
        /// </summary>
        [HttpGet("current")]
        [ProducesResponseType(typeof(GameweekDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetCurrentGameweek()
        {
            var gameweek = await _gameweekService.GetCurrentGameweekAsync();
            if (gameweek == null)
                return NotFound("No current gameweek found");

            return Ok(gameweek);
        }

        /// <summary>
        /// Get gameweek details with fixtures
        /// </summary>
        [HttpGet("{id}/details")]
        [ProducesResponseType(typeof(GameweekDetailsDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetGameweekDetails(int id)
        {
            var gameweek = await _gameweekService.GetGameweekDetailsAsync(id);
            if (gameweek == null)
                return NotFound($"Gameweek with ID {id} not found");

            return Ok(gameweek);
        }
    }
}





