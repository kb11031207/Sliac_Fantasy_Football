using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface IPlayerService
    {
        Task<PlayerDto?> GetPlayerByIdAsync(int id);
        Task<IEnumerable<PlayerDto>> GetAllPlayersAsync();
        Task<IEnumerable<PlayerDto>> GetPlayersByTeamAsync(int teamId);
        Task<IEnumerable<PlayerDto>> GetPlayersByPositionAsync(byte position);
        Task<IEnumerable<PlayerDto>> SearchPlayersAsync(PlayerFilterDto filter);
        Task<PlayerStatsDto?> GetPlayerGameweekStatsAsync(int playerId, int gameweekId);
    }
}



