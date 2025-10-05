using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface ILeagueRepository : IGenericRepository<League>
    {
        Task<IEnumerable<League>> GetByOwnerAsync(int ownerId);
        Task<IEnumerable<League>> GetUserLeaguesAsync(int userId);
        Task<IEnumerable<League>> GetPublicLeaguesAsync();
        Task<bool> AddUserToLeagueAsync(int userId, int leagueId);
        Task<bool> RemoveUserFromLeagueAsync(int userId, int leagueId);
        Task<bool> IsUserInLeagueAsync(int userId, int leagueId);
    }
}

