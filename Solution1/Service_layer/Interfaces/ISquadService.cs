using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface ISquadService
    {
        Task<SquadDto?> GetSquadByIdAsync(int id);
        Task<SquadDto?> GetUserSquadForGameweekAsync(int userId, int gameweekId);
        Task<SquadDto> CreateSquadAsync(int userId, CreateSquadDto createDto);
        Task<SquadDto> UpdateSquadAsync(int squadId, UpdateSquadDto updateDto);
        Task<IEnumerable<SquadDto>> GetUserSquadsAsync(int userId);
        Task<bool> DeleteSquadAsync(int id);
    }
}

