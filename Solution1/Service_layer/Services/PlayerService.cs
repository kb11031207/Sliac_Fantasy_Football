using AutoMapper;
using Data_Layer.Interfaces;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class PlayerService : IPlayerService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IMapper _mapper;

        public PlayerService(IPlayerRepository playerRepository, IMapper mapper)
        {
            _playerRepository = playerRepository;
            _mapper = mapper;
        }

        public async Task<PlayerDto?> GetPlayerByIdAsync(int id)
        {
            var player = await _playerRepository.GetByIdAsync(id);
            return _mapper.Map<PlayerDto>(player);
        }

        public async Task<IEnumerable<PlayerDto>> GetAllPlayersAsync()
        {
            var players = await _playerRepository.GetAllAsync();
            return _mapper.Map<IEnumerable<PlayerDto>>(players);
        }

        public async Task<IEnumerable<PlayerDto>> GetPlayersByTeamAsync(int teamId)
        {
            var players = await _playerRepository.GetByTeamAsync(teamId);
            return _mapper.Map<IEnumerable<PlayerDto>>(players);
        }

        public async Task<IEnumerable<PlayerDto>> GetPlayersByPositionAsync(byte position)
        {
            var players = await _playerRepository.GetByPositionAsync(position);
            return _mapper.Map<IEnumerable<PlayerDto>>(players);
        }

        public async Task<IEnumerable<PlayerDto>> SearchPlayersAsync(PlayerFilterDto filter)
        {
            var players = await _playerRepository.GetAllAsync();

            // Apply filters
            if (filter.TeamId.HasValue)
                players = players.Where(p => p.TeamId == filter.TeamId.Value);

            if (filter.Position.HasValue)
                players = players.Where(p => p.Position == filter.Position.Value);

            if (filter.MinCost.HasValue)
                players = players.Where(p => p.Cost >= filter.MinCost.Value);

            if (filter.MaxCost.HasValue)
                players = players.Where(p => p.Cost <= filter.MaxCost.Value);

            return _mapper.Map<IEnumerable<PlayerDto>>(players);
        }

        public async Task<PlayerStatsDto?> GetPlayerGameweekStatsAsync(int playerId, int gameweekId)
        {
            // This would query PlayerGameweekStats table
            // For now, returning null as placeholder
            await Task.CompletedTask;
            return null;
        }
    }
}

