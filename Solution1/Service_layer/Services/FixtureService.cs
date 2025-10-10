using AutoMapper;
using Data_Layer.Interfaces;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class FixtureService : IFixtureService
    {
        private readonly IFixtureRepository _fixtureRepository;
        private readonly IMapper _mapper;

        public FixtureService(IFixtureRepository fixtureRepository, IMapper mapper)
        {
            _fixtureRepository = fixtureRepository;
            _mapper = mapper;
        }

        public async Task<FixtureDto?> GetFixtureByIdAsync(int id)
        {
            var fixture = await _fixtureRepository.GetByIdAsync(id);
            return _mapper.Map<FixtureDto>(fixture);
        }

        public async Task<IEnumerable<FixtureDto>> GetFixturesByGameweekAsync(int gameweekId)
        {
            var fixtures = await _fixtureRepository.GetByGameweekAsync(gameweekId);
            return _mapper.Map<IEnumerable<FixtureDto>>(fixtures);
        }

        public async Task<IEnumerable<FixtureDto>> GetFixturesByTeamAsync(int teamId)
        {
            var fixtures = await _fixtureRepository.GetByTeamAsync(teamId);
            return _mapper.Map<IEnumerable<FixtureDto>>(fixtures);
        }

        public async Task<FixtureDetailsDto?> GetFixtureDetailsAsync(int fixtureId)
        {
            var fixture = await _fixtureRepository.GetFixtureWithStatsAsync(fixtureId);
            return _mapper.Map<FixtureDetailsDto>(fixture);
        }
    }
}

