using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface IFixtureRepository : IGenericRepository<Fixture>
    {
        Task<IEnumerable<Fixture>> GetByGameweekAsync(int gameweekId);
        Task<IEnumerable<Fixture>> GetByTeamAsync(int teamId);
        Task<Fixture?> GetFixtureWithStatsAsync(int fixtureId);
    }
}



