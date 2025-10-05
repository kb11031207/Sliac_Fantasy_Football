using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class LeagueRepository : GenericRepository<League>, ILeagueRepository
    {
        public LeagueRepository(ApplicationDbContext context) : base(context) { }

        public async Task<IEnumerable<League>> GetByOwnerAsync(int ownerId)
        {
            return await _dbSet
                .Where(l => l.Owner == ownerId)
                .ToListAsync();
        }

        public async Task<IEnumerable<League>> GetUserLeaguesAsync(int userId)
        {
            return await _context.UsersXLeagues
                .Where(ul => ul.UserId == userId)
                .Include(ul => ul.League)
                .Select(ul => ul.League)
                .ToListAsync();
        }

        public async Task<IEnumerable<League>> GetPublicLeaguesAsync()
        {
            return await _dbSet
                .Where(l => l.Type == true) // Type = 1 (public)
                .ToListAsync();
        }

        public async Task<bool> AddUserToLeagueAsync(int userId, int leagueId)
        {
            var userLeague = new UserLeague
            {
                UserId = userId,
                LeagueId = leagueId
            };

            await _context.UsersXLeagues.AddAsync(userLeague);
            var result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public async Task<bool> RemoveUserFromLeagueAsync(int userId, int leagueId)
        {
            var userLeague = await _context.UsersXLeagues
                .FirstOrDefaultAsync(ul => ul.UserId == userId && ul.LeagueId == leagueId);

            if (userLeague == null) return false;

            _context.UsersXLeagues.Remove(userLeague);
            var result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public async Task<bool> IsUserInLeagueAsync(int userId, int leagueId)
        {
            return await _context.UsersXLeagues
                .AnyAsync(ul => ul.UserId == userId && ul.LeagueId == leagueId);
        }
    }
}

