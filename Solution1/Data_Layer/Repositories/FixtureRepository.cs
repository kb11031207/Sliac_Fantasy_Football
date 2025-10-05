using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class FixtureRepository : GenericRepository<Fixture>, IFixtureRepository
    {
        public FixtureRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<Fixture>> GetByGameweekAsync(int gameweekId)
        {
            return await _dbSet
                .Where(f => f.GameweekId == gameweekId)
                .Include(f => f.HomeTeam)
                .Include(f => f.AwayTeam)
                .Include(f => f.Result)
                .ToListAsync();
        }

        public async Task<IEnumerable<Fixture>> GetByTeamAsync(int teamId)
        {
            return await _dbSet
                .Where(f => f.HomeTeamId == teamId || f.AwayTeamId == teamId)
                .Include(f => f.HomeTeam)
                .Include(f => f.AwayTeam)
                .Include(f => f.Result)
                .OrderByDescending(f => f.Kickoff)
                .ToListAsync();
        }

        public async Task<Fixture?> GetFixtureWithStatsAsync(int fixtureId)
        {
            return await _dbSet
                .Include(f => f.HomeTeam)
                .Include(f => f.AwayTeam)
                .Include(f => f.Result)
                .Include(f => f.PlayerStats)
                    .ThenInclude(ps => ps.Player)
                .FirstOrDefaultAsync(f => f.Id == fixtureId);
        }
    }
}

