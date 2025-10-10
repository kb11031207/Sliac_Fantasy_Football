using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class PlayerRepository : GenericRepository<Player>, IPlayerRepository
    {
        public PlayerRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<Player>> GetByTeamAsync(int teamId)
        {
            return await _dbSet
                .Where(p => p.TeamId == teamId)
                .Include(p => p.Team)
                .ToListAsync();
        }

        public async Task<IEnumerable<Player>> GetByPositionAsync(byte position)
        {
            return await _dbSet
                .Where(p => p.Position == position)
                .Include(p => p.Team)
                .ToListAsync();
        }

        public async Task<IEnumerable<Player>> GetByCostRangeAsync(decimal minCost, decimal maxCost)
        {
            return await _dbSet
                .Where(p => p.Cost >= minCost && p.Cost <= maxCost)
                .Include(p => p.Team)
                .ToListAsync();
        }

        public async Task<IEnumerable<Player>> GetByIdsAsync(List<int> playerIds)
        {
            return await _dbSet
                .Where(p => playerIds.Contains(p.Id))
                .Include(p => p.Team)
                .ToListAsync();
        }

        public override async Task<IEnumerable<Player>> GetAllAsync()
        {
            return await _dbSet
                .Include(p => p.Team)
                .ToListAsync();
        }
    }
}

