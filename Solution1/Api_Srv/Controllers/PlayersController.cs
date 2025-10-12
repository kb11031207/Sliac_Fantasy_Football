using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PlayersController : ControllerBase
    {
        private readonly IPlayerService _playerService;

        public PlayersController(IPlayerService playerService)
        {
            _playerService = playerService;
        }

        /// <summary>
        /// Get all players
        /// </summary>
        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<PlayerDto>), 200)]
        public async Task<IActionResult> GetAllPlayers()
        {
            var players = await _playerService.GetAllPlayersAsync();
            return Ok(players);
        }

        /// <summary>
        /// Get player by ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(PlayerDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetPlayer(int id)
        {
            var player = await _playerService.GetPlayerByIdAsync(id);
            if (player == null)
                return NotFound($"Player with ID {id} not found");

            return Ok(player);
        }

        /// <summary>
        /// Get players by team
        /// </summary>
        [HttpGet("team/{teamId}")]
        [ProducesResponseType(typeof(IEnumerable<PlayerDto>), 200)]
        public async Task<IActionResult> GetPlayersByTeam(int teamId)
        {
            var players = await _playerService.GetPlayersByTeamAsync(teamId);
            return Ok(players);
        }

        /// <summary>
        /// Get players by position (1=GK, 2=DEF, 3=MID, 4=FWD)
        /// </summary>
        [HttpGet("position/{position}")]
        [ProducesResponseType(typeof(IEnumerable<PlayerDto>), 200)]
        public async Task<IActionResult> GetPlayersByPosition(byte position)
        {
            var players = await _playerService.GetPlayersByPositionAsync(position);
            return Ok(players);
        }

        /// <summary>
        /// Search players with filters
        /// </summary>
        [HttpPost("search")]
        [ProducesResponseType(typeof(IEnumerable<PlayerDto>), 200)]
        public async Task<IActionResult> SearchPlayers([FromBody] PlayerFilterDto filter)
        {
            var players = await _playerService.SearchPlayersAsync(filter);
            return Ok(players);
        }

        /// <summary>
        /// Get player gameweek stats
        /// </summary>
        [HttpGet("{playerId}/gameweek/{gameweekId}/stats")]
        [ProducesResponseType(typeof(PlayerStatsDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetPlayerGameweekStats(int playerId, int gameweekId)
        {
            var stats = await _playerService.GetPlayerGameweekStatsAsync(playerId, gameweekId);
            if (stats == null)
                return NotFound($"Stats not found for player {playerId} in gameweek {gameweekId}");

            return Ok(stats);
        }
    }
}



