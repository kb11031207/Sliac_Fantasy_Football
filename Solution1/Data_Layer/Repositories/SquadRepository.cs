using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class SquadRepository : GenericRepository<Squad>, ISquadRepository
    {
        public SquadRepository(ApplicationDbContext context) : base(context) { }

        public async Task<Squad?> GetUserSquadForGameweekAsync(int userId, int gameweekId)
        {
            return await _dbSet
                .Include(s => s.SquadPlayers)
                    .ThenInclude(sp => sp.Player)
                        .ThenInclude(p => p.Team)
                .FirstOrDefaultAsync(s => s.UserId == userId && s.GameweekId == gameweekId);
        }

        public async Task<IEnumerable<Squad>> GetUserSquadsAsync(int userId)
        {
            return await _dbSet
                .Where(s => s.UserId == userId)
                .Include(s => s.Gameweek)
                .Include(s => s.SquadPlayers)
                    .ThenInclude(sp => sp.Player)
                .ToListAsync();
        }

        public async Task<bool> UserHasSquadForGameweekAsync(int userId, int gameweekId)
        {
            return await _dbSet.AnyAsync(s => s.UserId == userId && s.GameweekId == gameweekId);
        }

        public async Task<bool> AddPlayerToSquadAsync(int squadId, int playerId, decimal playerCost)
        {
            var squadPlayer = new SquadPlayer
            {
                SquadId = squadId,
                PlayerId = playerId,
                PlayerCost = playerCost
            };

            await _context.SquadPlayers.AddAsync(squadPlayer);
            var result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public async Task<bool> RemovePlayerFromSquadAsync(int squadId, int playerId)
        {
            var squadPlayer = await _context.SquadPlayers
                .FirstOrDefaultAsync(sp => sp.SquadId == squadId && sp.PlayerId == playerId);

            if (squadPlayer == null) return false;

            _context.SquadPlayers.Remove(squadPlayer);
            var result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public async Task<Squad?> GetSquadWithPlayersAsync(int squadId)
        {
            return await _dbSet
                .Include(s => s.SquadPlayers)
                    .ThenInclude(sp => sp.Player)
                        .ThenInclude(p => p.Team)
                .FirstOrDefaultAsync(s => s.Id == squadId);
        }
    }
}

