using AutoMapper;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class LeagueService : ILeagueService
    {
        private readonly ILeagueRepository _leagueRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public LeagueService(ILeagueRepository leagueRepository, IUserRepository userRepository, IMapper mapper)
        {
            _leagueRepository = leagueRepository;
            _userRepository = userRepository;
            _mapper = mapper;
        }

        public async Task<LeagueDto?> GetLeagueByIdAsync(int id)
        {
            var league = await _leagueRepository.GetByIdAsync(id);
            if (league == null) return null;

            var leagueDto = _mapper.Map<LeagueDto>(league);
            
            // Get owner username
            var owner = await _userRepository.GetByIdAsync(league.Owner);
            leagueDto.OwnerUsername = owner?.Username;
            
            return leagueDto;
        }

        public async Task<LeagueDto> CreateLeagueAsync(CreateLeagueDto createDto, int ownerId)
        {
            // Verify owner exists
            var owner = await _userRepository.GetByIdAsync(ownerId);
            if (owner == null)
                throw new ArgumentException("Owner user not found");

            var league = new League
            {
                Owner = ownerId,
                Type = createDto.Type
            };

            var createdLeague = await _leagueRepository.AddAsync(league);
            
            // Automatically add owner to league
            await _leagueRepository.AddUserToLeagueAsync(ownerId, createdLeague.Id);

            var leagueDto = _mapper.Map<LeagueDto>(createdLeague);
            leagueDto.OwnerUsername = owner.Username;
            leagueDto.MemberCount = 1;
            
            return leagueDto;
        }

        public async Task<bool> JoinLeagueAsync(int userId, int leagueId)
        {
            // Verify user exists
            var user = await _userRepository.GetByIdAsync(userId);
            if (user == null)
                throw new ArgumentException("User not found");

            // Verify league exists
            var league = await _leagueRepository.GetByIdAsync(leagueId);
            if (league == null)
                throw new ArgumentException("League not found");

            // Check if user is already in league
            if (await _leagueRepository.IsUserInLeagueAsync(userId, leagueId))
                throw new ArgumentException("User is already in this league");

            // For private leagues, additional validation could be added here

            return await _leagueRepository.AddUserToLeagueAsync(userId, leagueId);
        }

        public async Task<bool> LeaveLeagueAsync(int userId, int leagueId)
        {
            // Verify user is in league
            if (!await _leagueRepository.IsUserInLeagueAsync(userId, leagueId))
                throw new ArgumentException("User is not in this league");

            // Check if user is the owner
            var league = await _leagueRepository.GetByIdAsync(leagueId);
            if (league?.Owner == userId)
                throw new ArgumentException("League owner cannot leave the league");

            return await _leagueRepository.RemoveUserFromLeagueAsync(userId, leagueId);
        }

        public async Task<IEnumerable<LeagueDto>> GetUserLeaguesAsync(int userId)
        {
            var leagues = await _leagueRepository.GetUserLeaguesAsync(userId);
            return _mapper.Map<IEnumerable<LeagueDto>>(leagues);
        }

        public async Task<IEnumerable<LeagueDto>> GetPublicLeaguesAsync()
        {
            var leagues = await _leagueRepository.GetPublicLeaguesAsync();
            return _mapper.Map<IEnumerable<LeagueDto>>(leagues);
        }

        public async Task<LeagueDetailsDto?> GetLeagueDetailsAsync(int leagueId)
        {
            var league = await _leagueRepository.GetByIdAsync(leagueId);
            if (league == null) return null;

            var leagueDetails = new LeagueDetailsDto
            {
                Id = league.Id,
                Owner = league.Owner,
                Type = league.Type
            };

            // Get owner info
            var owner = await _userRepository.GetByIdAsync(league.Owner);
            leagueDetails.OwnerUsername = owner?.Username;

            // Get members - this would require additional repository method
            // Placeholder for now
            leagueDetails.Members = new List<LeagueMemberDto>();

            return leagueDetails;
        }

        public async Task<LeagueStandingsDto> GetLeagueStandingsAsync(int leagueId, int gameweekId)
        {
            // This would query UserGameweekScores and calculate standings
            // Placeholder implementation
            await Task.CompletedTask;
            
            return new LeagueStandingsDto
            {
                LeagueId = leagueId,
                GameweekId = gameweekId,
                Standings = new List<LeagueStandingEntry>()
            };
        }
    }
}

