using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface IPlayerRepository : IGenericRepository<Player>
    {
        Task<IEnumerable<Player>> GetByTeamAsync(int teamId);
        Task<IEnumerable<Player>> GetByPositionAsync(byte position);
        Task<IEnumerable<Player>> GetByCostRangeAsync(decimal minCost, decimal maxCost);
        Task<IEnumerable<Player>> GetByIdsAsync(List<int> playerIds);
    }
}





