using AutoMapper;
using Data_Layer.Interfaces;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class GameweekService : IGameweekService
    {
        private readonly IGameweekRepository _gameweekRepository;
        private readonly IMapper _mapper;

        public GameweekService(IGameweekRepository gameweekRepository, IMapper mapper)
        {
            _gameweekRepository = gameweekRepository;
            _mapper = mapper;
        }

        public async Task<GameweekDto?> GetGameweekByIdAsync(int id)
        {
            var gameweek = await _gameweekRepository.GetByIdAsync(id);
            if (gameweek == null) return null;

            var gameweekDto = _mapper.Map<GameweekDto>(gameweek);
            gameweekDto.IsCurrent = IsCurrentGameweek(gameweek);
            
            return gameweekDto;
        }

        public async Task<GameweekDto?> GetCurrentGameweekAsync()
        {
            var gameweek = await _gameweekRepository.GetCurrentGameweekAsync();
            if (gameweek == null) return null;

            var gameweekDto = _mapper.Map<GameweekDto>(gameweek);
            gameweekDto.IsCurrent = true;
            
            return gameweekDto;
        }

        public async Task<IEnumerable<GameweekDto>> GetAllGameweeksAsync()
        {
            var gameweeks = await _gameweekRepository.GetAllAsync();
            var gameweekDtos = _mapper.Map<IEnumerable<GameweekDto>>(gameweeks);
            
            var now = DateTime.UtcNow;
            foreach (var dto in gameweekDtos)
            {
                var gw = gameweeks.First(g => g.Id == dto.Id);
                dto.IsCurrent = IsCurrentGameweek(gw);
            }
            
            return gameweekDtos;
        }

        public async Task<GameweekDetailsDto?> GetGameweekDetailsAsync(int id)
        {
            var gameweek = await _gameweekRepository.GetGameweekWithFixturesAsync(id);
            if (gameweek == null) return null;

            return _mapper.Map<GameweekDetailsDto>(gameweek);
        }

        private bool IsCurrentGameweek(Data_Layer.Models.Gameweek gameweek)
        {
            var now = DateTime.UtcNow;
            return gameweek.StartTime <= now && 
                   (gameweek.EndTime == null || gameweek.EndTime >= now) && 
                   !gameweek.IsComplete;
        }
    }
}





