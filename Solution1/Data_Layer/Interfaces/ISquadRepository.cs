using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface ISquadRepository : IGenericRepository<Squad>
    {
        Task<Squad?> GetSquadWithPlayersAsync(int squadId);
        Task<Squad?> GetUserSquadForGameweekAsync(int userId, int gameweekId);
        Task<IEnumerable<Squad>> GetUserSquadsAsync(int userId);
        Task<bool> UserHasSquadForGameweekAsync(int userId, int gameweekId);
        Task<bool> AddPlayerToSquadAsync(int squadId, int playerId, decimal playerCost, bool isStarter, bool isCaptain, bool isVice);
        Task<bool> RemovePlayerFromSquadAsync(int squadId, int playerId);
    }
}