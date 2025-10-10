using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface IFixtureService
    {
        Task<FixtureDto?> GetFixtureByIdAsync(int id);
        Task<IEnumerable<FixtureDto>> GetFixturesByGameweekAsync(int gameweekId);
        Task<IEnumerable<FixtureDto>> GetFixturesByTeamAsync(int teamId);
        Task<FixtureDetailsDto?> GetFixtureDetailsAsync(int fixtureId);
    }
}

