using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface ILeagueService
    {
        Task<LeagueDto?> GetLeagueByIdAsync(int id);
        Task<LeagueDto> CreateLeagueAsync(CreateLeagueDto createDto, int ownerId);
        Task<LeagueDto> UpdateLeagueAsync(int leagueId, UpdateLeagueDto updateDto);
        Task<bool> DeleteLeagueAsync(int leagueId);
        Task<bool> JoinLeagueAsync(int userId, int leagueId);
        Task<bool> LeaveLeagueAsync(int userId, int leagueId);
        Task<bool> RemoveMemberAsync(int userId, int leagueId);
        Task<bool> IsUserInLeagueAsync(int userId, int leagueId);
        Task<IEnumerable<LeagueDto>> GetUserLeaguesAsync(int userId);
        Task<IEnumerable<LeagueDto>> GetPublicLeaguesAsync();
        Task<LeagueDetailsDto?> GetLeagueDetailsAsync(int leagueId);
        Task<LeagueStandingsDto> GetLeagueStandingsAsync(int leagueId, int gameweekId);
    }
}
