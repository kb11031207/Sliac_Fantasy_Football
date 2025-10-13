using AutoMapper;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class SquadService : ISquadService
    {
        private readonly ISquadRepository _squadRepository;
        private readonly IPlayerRepository _playerRepository;
        private readonly IGameweekRepository _gameweekRepository;
        private readonly IMapper _mapper;

        // Squad constraints from SLIAC rules
        private const int MAX_SQUAD_SIZE = 15;
        private const int MAX_PLAYERS_PER_TEAM = 3;
        private const decimal BUDGET_LIMIT = 100m;
        private const int REQUIRED_GOALKEEPERS = 2;
        private const int REQUIRED_DEFENDERS = 5;
        private const int REQUIRED_MIDFIELDERS = 5;
        private const int REQUIRED_FORWARDS = 3;

        public SquadService(
            ISquadRepository squadRepository,
            IPlayerRepository playerRepository,
            IGameweekRepository gameweekRepository,
            IMapper mapper)
        {
            _squadRepository = squadRepository;
            _playerRepository = playerRepository;
            _gameweekRepository = gameweekRepository;
            _mapper = mapper;
        }

        public async Task<SquadDto?> GetSquadByIdAsync(int id)
        {
            var squad = await _squadRepository.GetSquadWithPlayersAsync(id);
            if (squad == null) return null;

            var squadDto = _mapper.Map<SquadDto>(squad);
            squadDto.TotalCost = squad.SquadPlayers.Sum(sp => sp.PlayerCost);
            
            return squadDto;
        }

        public async Task<SquadDto?> GetUserSquadForGameweekAsync(int userId, int gameweekId)
        {
            var squad = await _squadRepository.GetUserSquadForGameweekAsync(userId, gameweekId);
            if (squad == null) return null;

            var squadDto = _mapper.Map<SquadDto>(squad);
            squadDto.TotalCost = squad.SquadPlayers.Sum(sp => sp.PlayerCost);
            
            return squadDto;
        }

        public async Task<SquadDto> CreateSquadAsync(int userId, CreateSquadDto createDto)
        {
            // Validate gameweek exists
            var gameweek = await _gameweekRepository.GetByIdAsync(createDto.GameweekId);
            if (gameweek == null)
                throw new ArgumentException("Gameweek not found");

            // Check if gameweek has started (you might want to add deadline checking)
            if (gameweek.IsComplete)
                throw new ArgumentException("Cannot create squad for completed gameweek");

            // Check if user already has squad for this gameweek
            if (await _squadRepository.UserHasSquadForGameweekAsync(userId, createDto.GameweekId))
                throw new ArgumentException("Squad already exists for this gameweek");

            // Validate squad composition and budget
            await ValidateSquadAsync(createDto.PlayerIds);

            // Validate starters are subset of players
            if (!createDto.StarterIds.All(id => createDto.PlayerIds.Contains(id)))
                throw new ArgumentException("All starters must be from the selected players");

            // Validate captain and vice-captain are valid players
            if (!createDto.PlayerIds.Contains(createDto.CaptainId))
                throw new ArgumentException("Captain must be one of the selected players");

            if (!createDto.PlayerIds.Contains(createDto.ViceCaptainId))
                throw new ArgumentException("Vice-captain must be one of the selected players");

            // Validate captain and vice-captain are starters
            if (!createDto.StarterIds.Contains(createDto.CaptainId))
                throw new ArgumentException("Captain must be a starter");

            if (!createDto.StarterIds.Contains(createDto.ViceCaptainId))
                throw new ArgumentException("Vice-captain must be a starter");

            if (createDto.CaptainId == createDto.ViceCaptainId)
                throw new ArgumentException("Captain and vice-captain must be different players");

            // Validate starter formation (must have valid formation)
            await ValidateStarterFormationAsync(createDto.StarterIds);

            // Get players to capture their costs
            var players = await _playerRepository.GetByIdsAsync(createDto.PlayerIds);
            var playersList = players.ToList();

            // Create squad
            var squad = new Squad
            {
                UserId = userId,
                GameweekId = createDto.GameweekId,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            var createdSquad = await _squadRepository.AddAsync(squad);

            // Add players to squad with correct flags
            foreach (var playerId in createDto.PlayerIds)
            {
                var player = playersList.First(p => p.Id == playerId);
                
                bool isStarter = createDto.StarterIds.Contains(playerId);
                bool isCaptain = playerId == createDto.CaptainId;
                bool isVice = playerId == createDto.ViceCaptainId;
                
                await _squadRepository.AddPlayerToSquadAsync(
                    createdSquad.Id, 
                    playerId, 
                    player.Cost,
                    isStarter,
                    isCaptain,
                    isVice
                );
            }

            // Reload squad with players
            var fullSquad = await _squadRepository.GetSquadWithPlayersAsync(createdSquad.Id);
            var squadDto = _mapper.Map<SquadDto>(fullSquad);
            squadDto.TotalCost = fullSquad!.SquadPlayers.Sum(sp => sp.PlayerCost);

            return squadDto;
        }
        public async Task<SquadDto> UpdateSquadAsync(int squadId, UpdateSquadDto updateDto)
        {
            var squad = await _squadRepository.GetSquadWithPlayersAsync(squadId);
            if (squad == null)
                throw new KeyNotFoundException($"Squad with ID {squadId} not found");

            // Check if gameweek is still open for updates
            var gameweek = await _gameweekRepository.GetByIdAsync(squad.GameweekId);
            if (gameweek?.IsComplete == true)
                throw new ArgumentException("Cannot update squad for completed gameweek");

            // Validate new squad composition
            await ValidateSquadAsync(updateDto.PlayerIds);

            // Validate starters are subset of players
            if (!updateDto.StarterIds.All(id => updateDto.PlayerIds.Contains(id)))
                throw new ArgumentException("All starters must be from the selected players");

            // Validate captain and vice-captain are valid players
            if (!updateDto.PlayerIds.Contains(updateDto.CaptainId))
                throw new ArgumentException("Captain must be one of the selected players");

            if (!updateDto.PlayerIds.Contains(updateDto.ViceCaptainId))
                throw new ArgumentException("Vice-captain must be one of the selected players");

            // Validate captain and vice-captain are starters
            if (!updateDto.StarterIds.Contains(updateDto.CaptainId))
                throw new ArgumentException("Captain must be a starter");

            if (!updateDto.StarterIds.Contains(updateDto.ViceCaptainId))
                throw new ArgumentException("Vice-captain must be a starter");

            if (updateDto.CaptainId == updateDto.ViceCaptainId)
                throw new ArgumentException("Captain and vice-captain must be different players");

            // Validate starter formation
            await ValidateStarterFormationAsync(updateDto.StarterIds);

            // Remove all existing players
            foreach (var squadPlayer in squad.SquadPlayers.ToList())
            {
                await _squadRepository.RemovePlayerFromSquadAsync(squadId, squadPlayer.PlayerId);
            }

            // Add new players
            var players = await _playerRepository.GetByIdsAsync(updateDto.PlayerIds);
            var playersList = players.ToList();

            foreach (var playerId in updateDto.PlayerIds)
            {
                var player = playersList.First(p => p.Id == playerId);
                
                bool isStarter = updateDto.StarterIds.Contains(playerId);
                bool isCaptain = playerId == updateDto.CaptainId;
                bool isVice = playerId == updateDto.ViceCaptainId;
                
                await _squadRepository.AddPlayerToSquadAsync(
                    squadId, 
                    playerId, 
                    player.Cost,
                    isStarter,
                    isCaptain,
                    isVice
                );
            }

            // Update timestamp
            squad.UpdatedAt = DateTime.UtcNow;
            await _squadRepository.UpdateAsync(squad);

            // Reload and return
            var updatedSquad = await _squadRepository.GetSquadWithPlayersAsync(squadId);
            var squadDto = _mapper.Map<SquadDto>(updatedSquad);
            squadDto.TotalCost = updatedSquad!.SquadPlayers.Sum(sp => sp.PlayerCost);

            return squadDto;
        }

        public async Task<IEnumerable<SquadDto>> GetUserSquadsAsync(int userId)
        {
            var squads = await _squadRepository.GetUserSquadsAsync(userId);
            return _mapper.Map<IEnumerable<SquadDto>>(squads);
        }

        public async Task<bool> DeleteSquadAsync(int id)
        {
            var squad = await _squadRepository.GetByIdAsync(id);
            if (squad == null)
                return false;

            return await _squadRepository.RemoveAsync(squad);
        }

        private async Task ValidateSquadAsync(List<int> playerIds)
        {
            if (playerIds.Count != MAX_SQUAD_SIZE)
                throw new ArgumentException($"Squad must contain exactly {MAX_SQUAD_SIZE} players");

            // Check for duplicates
            if (playerIds.Distinct().Count() != playerIds.Count)
                throw new ArgumentException("Squad contains duplicate players");

            var players = await _playerRepository.GetByIdsAsync(playerIds);
            var playersList = players.ToList();

            if (playersList.Count != playerIds.Count)
                throw new ArgumentException("One or more players not found");

            // Validate budget
            var totalCost = playersList.Sum(p => p.Cost);
            if (totalCost > BUDGET_LIMIT)
                throw new ArgumentException($"Squad cost ({totalCost:C}) exceeds budget limit of {BUDGET_LIMIT:C}");

            // Validate position constraints
            var positionCounts = playersList.GroupBy(p => p.Position)
                .ToDictionary(g => g.Key, g => g.Count());

            if (positionCounts.GetValueOrDefault((byte)1) != REQUIRED_GOALKEEPERS)
                throw new ArgumentException($"Squad must contain exactly {REQUIRED_GOALKEEPERS} goalkeepers");

            if (positionCounts.GetValueOrDefault((byte)2) != REQUIRED_DEFENDERS)
                throw new ArgumentException($"Squad must contain exactly {REQUIRED_DEFENDERS} defenders");

            if (positionCounts.GetValueOrDefault((byte)3) != REQUIRED_MIDFIELDERS)
                throw new ArgumentException($"Squad must contain exactly {REQUIRED_MIDFIELDERS} midfielders");

            if (positionCounts.GetValueOrDefault((byte)4) != REQUIRED_FORWARDS)
                throw new ArgumentException($"Squad must contain exactly {REQUIRED_FORWARDS} forwards");

            // Validate max players per team
            var teamCounts = playersList.GroupBy(p => p.TeamId)
                .ToDictionary(g => g.Key, g => g.Count());

            foreach (var teamCount in teamCounts)
            {
                if (teamCount.Value > MAX_PLAYERS_PER_TEAM)
                    throw new ArgumentException($"Cannot have more than {MAX_PLAYERS_PER_TEAM} players from the same team");
            }
        }
        private async Task ValidateStarterFormationAsync(List<int> starterIds)
        {
            if (starterIds.Count != 11)
                throw new ArgumentException("Must have exactly 11 starters");

            var starters = await _playerRepository.GetByIdsAsync(starterIds);
            var startersList = starters.ToList();

            if (startersList.Count != starterIds.Count)
                throw new ArgumentException("One or more starter players not found");

            // Count positions in starting 11
            var positionCounts = startersList.GroupBy(p => p.Position)
                .ToDictionary(g => g.Key, g => g.Count());

            var goalkeepers = positionCounts.GetValueOrDefault((byte)1, 0);
            var defenders = positionCounts.GetValueOrDefault((byte)2, 0);
            var midfielders = positionCounts.GetValueOrDefault((byte)3, 0);
            var forwards = positionCounts.GetValueOrDefault((byte)4, 0);

            // Must have exactly 1 goalkeeper
            if (goalkeepers != 1)
                throw new ArgumentException("Starting 11 must have exactly 1 goalkeeper");

            // Must have at least 3 defenders
            if (defenders < 3)
                throw new ArgumentException("Starting 11 must have at least 3 defenders");

            // Must have at least 2 midfielders
            if (midfielders < 2)
                throw new ArgumentException("Starting 11 must have at least 2 midfielders");

            // Must have at least 1 forward
            if (forwards < 1)
                throw new ArgumentException("Starting 11 must have at least 1 forward");

            // Valid formations: 1-3-4-3, 1-3-5-2, 1-4-3-3, 1-4-4-2, 1-4-5-1, 1-5-3-2, 1-5-4-1
            var outfieldTotal = defenders + midfielders + forwards;
            if (outfieldTotal != 10)
                throw new ArgumentException("Starting 11 must have 1 goalkeeper and 10 outfield players");
        }
    }
}




