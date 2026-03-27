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
        private readonly IPointsCalculationService _pointsCalculationService;
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
            IPointsCalculationService pointsCalculationService,
            IMapper mapper)
        {
            _squadRepository = squadRepository;
            _playerRepository = playerRepository;
            _gameweekRepository = gameweekRepository;
            _pointsCalculationService = pointsCalculationService;
            _mapper = mapper;
        }

        public async Task<SquadDto?> GetSquadByIdAsync(int id)
        {
            var squad = await _squadRepository.GetSquadWithPlayersAsync(id);
            if (squad == null) return null;

            var squadDto = _mapper.Map<SquadDto>(squad);
            squadDto.TotalCost = squad.SquadPlayers.Sum(sp => sp.PlayerCost);
            
            // Calculate individual player points and total points
            await CalculateSquadPointsAsync(squadDto, squad.GameweekId);
            
            return squadDto;
        }

        public async Task<SquadDto?> GetUserSquadForGameweekAsync(int userId, int gameweekId)
        {
            var squad = await _squadRepository.GetUserSquadForGameweekAsync(userId, gameweekId);
            if (squad == null) return null;

            var squadDto = _mapper.Map<SquadDto>(squad);
            squadDto.TotalCost = squad.SquadPlayers.Sum(sp => sp.PlayerCost);
            
            // Calculate individual player points and total points
            await CalculateSquadPointsAsync(squadDto, gameweekId);
            
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
            
            // Calculate individual player points and total points
            await CalculateSquadPointsAsync(squadDto, createDto.GameweekId);

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
            
            // Calculate individual player points and total points
            await CalculateSquadPointsAsync(squadDto, squad.GameweekId);

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

        public async Task<CreateSquadDto> GenerateRandomSquadAsync(int gameweekId)
        {
            // Validate gameweek exists
            var gameweek = await _gameweekRepository.GetByIdAsync(gameweekId);
            if (gameweek == null)
                throw new ArgumentException("Gameweek not found");

            // Get all players by position
            var goalkeepers = (await _playerRepository.GetByPositionAsync(1)).ToList();
            var defenders = (await _playerRepository.GetByPositionAsync(2)).ToList();
            var midfielders = (await _playerRepository.GetByPositionAsync(3)).ToList();
            var forwards = (await _playerRepository.GetByPositionAsync(4)).ToList();

            if (goalkeepers.Count < REQUIRED_GOALKEEPERS ||
                defenders.Count < REQUIRED_DEFENDERS ||
                midfielders.Count < REQUIRED_MIDFIELDERS ||
                forwards.Count < REQUIRED_FORWARDS)
            {
                throw new ArgumentException("Not enough players available to generate a squad");
            }

            var random = new Random();
            List<Player> selectedPlayers = new List<Player>();
            Dictionary<int, int> teamCounts = new Dictionary<int, int>();
            decimal totalCost = 0m;
            int maxAttempts = 1000;
            int attempts = 0;

            // Try to generate a valid squad
            while (attempts < maxAttempts)
            {
                selectedPlayers.Clear();
                teamCounts.Clear();
                totalCost = 0m;

                // Select 2 goalkeepers
                var shuffledGKs = goalkeepers.OrderBy(x => random.Next()).ToList();
                foreach (var gk in shuffledGKs)
                {
                    if (selectedPlayers.Count(p => p.Position == 1) >= REQUIRED_GOALKEEPERS)
                        break;
                    AddPlayerIfValid(gk, selectedPlayers, teamCounts, ref totalCost);
                }

                if (selectedPlayers.Count(p => p.Position == 1) != REQUIRED_GOALKEEPERS)
                {
                    attempts++;
                    continue;
                }

                // Select 5 defenders
                var shuffledDEFs = defenders.OrderBy(x => random.Next()).ToList();
                foreach (var def in shuffledDEFs)
                {
                    if (selectedPlayers.Count(p => p.Position == 2) >= REQUIRED_DEFENDERS)
                        break;
                    AddPlayerIfValid(def, selectedPlayers, teamCounts, ref totalCost);
                }

                if (selectedPlayers.Count(p => p.Position == 2) != REQUIRED_DEFENDERS)
                {
                    attempts++;
                    continue;
                }

                // Select 5 midfielders
                var shuffledMIDs = midfielders.OrderBy(x => random.Next()).ToList();
                foreach (var mid in shuffledMIDs)
                {
                    if (selectedPlayers.Count(p => p.Position == 3) >= REQUIRED_MIDFIELDERS)
                        break;
                    AddPlayerIfValid(mid, selectedPlayers, teamCounts, ref totalCost);
                }

                if (selectedPlayers.Count(p => p.Position == 3) != REQUIRED_MIDFIELDERS)
                {
                    attempts++;
                    continue;
                }

                // Select 3 forwards
                var shuffledFWDs = forwards.OrderBy(x => random.Next()).ToList();
                foreach (var fwd in shuffledFWDs)
                {
                    if (selectedPlayers.Count(p => p.Position == 4) >= REQUIRED_FORWARDS)
                        break;
                    AddPlayerIfValid(fwd, selectedPlayers, teamCounts, ref totalCost);
                }

                // Check if we have a valid squad
                if (selectedPlayers.Count == MAX_SQUAD_SIZE && totalCost <= BUDGET_LIMIT)
                {
                    break;
                }

                attempts++;
            }

            if (selectedPlayers.Count != MAX_SQUAD_SIZE || totalCost > BUDGET_LIMIT)
            {
                throw new ArgumentException("Unable to generate a valid random squad. Try again or check available players.");
            }

            // Select 11 starters with valid formation
            var starters = SelectStarters(selectedPlayers, random);
            
            // Select captain and vice-captain from starters
            var captainCandidates = starters.Where(p => p.Position != 1).ToList(); // Don't pick GK as captain typically
            if (captainCandidates.Count < 2)
                captainCandidates = starters.ToList();

            var captain = captainCandidates.OrderBy(x => random.Next()).First();
            var viceCaptain = starters.Where(p => p.Id != captain.Id).OrderBy(x => random.Next()).First();

            return new CreateSquadDto
            {
                GameweekId = gameweekId,
                PlayerIds = selectedPlayers.Select(p => p.Id).ToList(),
                StarterIds = starters.Select(p => p.Id).ToList(),
                CaptainId = captain.Id,
                ViceCaptainId = viceCaptain.Id
            };
        }

        private bool AddPlayerIfValid(Player player, List<Player> selectedPlayers, Dictionary<int, int> teamCounts, ref decimal totalCost)
        {
            // Check team limit
            if (teamCounts.ContainsKey(player.TeamId) && teamCounts[player.TeamId] >= MAX_PLAYERS_PER_TEAM)
                return false;

            // Check budget
            if (totalCost + player.Cost > BUDGET_LIMIT)
                return false;

            // Check if already selected
            if (selectedPlayers.Any(p => p.Id == player.Id))
                return false;

            // Add player
            selectedPlayers.Add(player);
            if (!teamCounts.ContainsKey(player.TeamId))
                teamCounts[player.TeamId] = 0;
            teamCounts[player.TeamId]++;
            totalCost += player.Cost;
            return true;
        }

        private List<Player> SelectStarters(List<Player> squad, Random random)
        {
            var starters = new List<Player>();
            
            // Must have exactly 1 goalkeeper
            var gk = squad.Where(p => p.Position == 1).OrderBy(x => random.Next()).First();
            starters.Add(gk);

            var remaining = squad.Where(p => p.Id != gk.Id).ToList();
            var defenders = remaining.Where(p => p.Position == 2).ToList();
            var midfielders = remaining.Where(p => p.Position == 3).ToList();
            var forwards = remaining.Where(p => p.Position == 4).ToList();

            // Select defenders (3-5, ensuring we can fill 11)
            int defCount = Math.Min(5, Math.Max(3, random.Next(3, Math.Min(6, defenders.Count + 1))));
            var selectedDefs = defenders.OrderBy(x => random.Next()).Take(defCount).ToList();
            starters.AddRange(selectedDefs);

            // Select midfielders (2-5)
            var remainingAfterDefs = remaining.Where(p => !selectedDefs.Contains(p)).ToList();
            int availableMids = remainingAfterDefs.Count(p => p.Position == 3);
            int midCount = Math.Min(5, Math.Max(2, random.Next(2, Math.Min(6, availableMids + 1))));
            var selectedMids = remainingAfterDefs.Where(p => p.Position == 3).OrderBy(x => random.Next()).Take(midCount).ToList();
            starters.AddRange(selectedMids);

            // Calculate remaining spots needed
            int needed = 11 - starters.Count;
            
            // Must have at least 1 forward, so ensure we select at least 1
            var remainingAfterMids = remainingAfterDefs.Where(p => !selectedMids.Contains(p)).ToList();
            int availableForwards = remainingAfterMids.Count(p => p.Position == 4);
            
            if (needed > 0 && availableForwards > 0)
            {
                // Select at least 1 forward, up to needed spots
                int forwardCount = Math.Max(1, Math.Min(needed, availableForwards));
                var selectedForwards = remainingAfterMids.Where(p => p.Position == 4).OrderBy(x => random.Next()).Take(forwardCount).ToList();
                starters.AddRange(selectedForwards);
                needed -= selectedForwards.Count;
                
                // Fill any remaining spots with any position
                if (needed > 0)
                {
                    var remainingPlayers = remainingAfterMids.Where(p => !selectedForwards.Contains(p)).OrderBy(x => random.Next()).Take(needed).ToList();
                    starters.AddRange(remainingPlayers);
                }
            }
            else if (needed > 0)
            {
                // If no forwards available in remaining, fill with any position
                var remainingPlayers = remainingAfterMids.OrderBy(x => random.Next()).Take(needed).ToList();
                starters.AddRange(remainingPlayers);
            }

            // Final validation - ensure we have exactly 11
            if (starters.Count != 11)
            {
                // Fallback: take random 11 from squad
                starters = squad.OrderBy(x => random.Next()).Take(11).ToList();
            }

            // Ensure at least 1 forward in starters (validation requirement)
            if (!starters.Any(p => p.Position == 4) && forwards.Count > 0)
            {
                var forward = forwards.OrderBy(x => random.Next()).First();
                // Replace a non-GK, non-forward starter
                var toReplace = starters.Where(p => p.Position != 1 && p.Position != 4).OrderBy(x => random.Next()).FirstOrDefault();
                if (toReplace != null)
                {
                    starters.Remove(toReplace);
                    starters.Add(forward);
                }
            }

            return starters;
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

        private async Task CalculateSquadPointsAsync(SquadDto squadDto, int gameweekId)
        {
            var totalPoints = 0;

            foreach (var player in squadDto.Players)
            {
                int playerPoints = 0;

                // Only calculate points for starters
                if (player.IsStarter)
                {
                    // Calculate player's total points for this gameweek
                    playerPoints = await _pointsCalculationService.CalculatePlayerGameweekPointsAsync(
                        player.PlayerId, 
                        gameweekId);

                    // Captain gets double points
                    if (player.IsCaptain)
                    {
                        playerPoints *= 2;
                    }

                    // Add to total (only starters count toward total)
                    totalPoints += playerPoints;
                }

                // Set points for this player (even if 0 for bench players)
                player.Points = playerPoints;
            }

            squadDto.TotalPoints = totalPoints;
        }
    }
}




