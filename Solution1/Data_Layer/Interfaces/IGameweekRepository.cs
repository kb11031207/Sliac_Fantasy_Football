using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface IGameweekRepository : IGenericRepository<Gameweek>
    {
        Task<Gameweek?> GetCurrentGameweekAsync();
        Task<Gameweek?> GetGameweekWithFixturesAsync(int gameweekId);
        Task<IEnumerable<Gameweek>> GetCompletedGameweeksAsync();
    }
}





