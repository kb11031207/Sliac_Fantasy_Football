using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface IGameweekService
    {
        Task<GameweekDto?> GetGameweekByIdAsync(int id);
        Task<GameweekDto?> GetCurrentGameweekAsync();
        Task<IEnumerable<GameweekDto>> GetAllGameweeksAsync();
        Task<GameweekDetailsDto?> GetGameweekDetailsAsync(int id);
    }
}

