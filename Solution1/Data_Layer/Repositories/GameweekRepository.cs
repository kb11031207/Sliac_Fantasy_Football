using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class GameweekRepository : GenericRepository<Gameweek>, IGameweekRepository
    {
        public GameweekRepository(ApplicationDbContext context) : base(context) { }

        public async Task<Gameweek?> GetCurrentGameweekAsync()
        {
            var now = DateTime.UtcNow;
            return await _dbSet
                .Where(g => g.StartTime <= now && (g.EndTime == null || g.EndTime >= now))
                .OrderByDescending(g => g.StartTime)
                .FirstOrDefaultAsync();
        }

        public async Task<Gameweek?> GetGameweekWithFixturesAsync(int gameweekId)
        {
            return await _dbSet
                .Include(g => g.Fixtures)
                    .ThenInclude(f => f.HomeTeam)
                .Include(g => g.Fixtures)
                    .ThenInclude(f => f.AwayTeam)
                .FirstOrDefaultAsync(g => g.Id == gameweekId);
        }

        public async Task<IEnumerable<Gameweek>> GetCompletedGameweeksAsync()
        {
            return await _dbSet
                .Where(g => g.IsComplete == true)
                .OrderByDescending(g => g.StartTime)
                .ToListAsync();
        }
    }
}

