using AutoMapper;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using Service_layer.DTOs;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class PlayerService : IPlayerService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IMapper _mapper;
        private readonly IPointsCalculationService _pointsCalculationService;

        public PlayerService(IPlayerRepository playerRepository, IMapper mapper, IPointsCalculationService pointsCalculationService)
        {
            _playerRepository = playerRepository;
            _mapper = mapper;
            _pointsCalculationService = pointsCalculationService;
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

        public async Task<IEnumerable<PlayerWithStatsDto>> SearchPlayersAsync(PlayerFilterDto filter)
        {
            // Get all players (or optimize to filter at database level later)
            var players = await _playerRepository.GetAllAsync();

            // Apply existing filters
            if (filter.TeamId.HasValue)
                players = players.Where(p => p.TeamId == filter.TeamId.Value);

            if (filter.Position.HasValue)
                players = players.Where(p => p.Position == filter.Position.Value);

            if (filter.MinCost.HasValue)
                players = players.Where(p => p.Cost >= filter.MinCost.Value);

            if (filter.MaxCost.HasValue)
                players = players.Where(p => p.Cost <= filter.MaxCost.Value);

            var playersList = players.ToList();

            // Determine if we need stats aggregation
            bool needsStats = filter.IncludeStats || 
                             (!string.IsNullOrEmpty(filter.SortBy) && 
                              (filter.SortBy.Equals("points", StringComparison.OrdinalIgnoreCase) ||
                               filter.SortBy.Equals("goals", StringComparison.OrdinalIgnoreCase) ||
                               filter.SortBy.Equals("assists", StringComparison.OrdinalIgnoreCase) ||
                               filter.SortBy.Equals("cleanSheets", StringComparison.OrdinalIgnoreCase) ||
                               filter.SortBy.Equals("saves", StringComparison.OrdinalIgnoreCase)));

            Dictionary<int, PlayerGameweekStatsAggregate>? statsDict = null;
            Dictionary<int, int>? pointsDict = null;
            Dictionary<int, int>? cleanSheetsCountDict = null;
            Dictionary<int, int>? gamesPlayedDict = null;

            if (needsStats && playersList.Any())
            {
                var playerIds = playersList.Select(p => p.Id).ToList();
                
                // Get aggregated stats
                statsDict = await _playerRepository.GetPlayersStatsAggregateAsync(playerIds, filter.GameweekId);

                // Get counts (clean sheets and games played)
                var countsDict = await _playerRepository.GetPlayersStatsCountsAsync(playerIds, filter.GameweekId);
                cleanSheetsCountDict = countsDict.ToDictionary(kvp => kvp.Key, kvp => kvp.Value.CleanSheetsCount);
                gamesPlayedDict = countsDict.ToDictionary(kvp => kvp.Key, kvp => kvp.Value.GamesPlayed);

                // Calculate points for each player
                pointsDict = new Dictionary<int, int>();

                if (filter.GameweekId.HasValue)
                {
                    // Calculate points for specific gameweek
                    foreach (var player in playersList)
                    {
                        var points = await _pointsCalculationService.CalculatePlayerGameweekPointsAsync(player.Id, filter.GameweekId.Value);
                        pointsDict[player.Id] = points;
                    }
                }
                else
                {
                    // Calculate points for overall season (all gameweeks)
                    // Get all gameweeks for each player
                    var playersGameweeksDict = await _playerRepository.GetPlayersGameweeksAsync(playerIds);
                    
                    foreach (var player in playersList)
                    {
                        int totalPoints = 0;
                        
                        if (playersGameweeksDict.TryGetValue(player.Id, out var gameweeks) && gameweeks.Any())
                        {
                            // Calculate points for each gameweek
                            foreach (var gameweekId in gameweeks)
                            {
                                var gameweekPoints = await _pointsCalculationService.CalculatePlayerGameweekPointsAsync(player.Id, gameweekId);
                                totalPoints += gameweekPoints;
                            }
                        }
                        
                        pointsDict[player.Id] = totalPoints;
                    }
                }
            }

            // Map players to PlayerWithStatsDto
            var playerDtos = new List<PlayerWithStatsDto>();
            foreach (var player in playersList)
            {
                var playerDto = _mapper.Map<PlayerDto>(player);
                var playerWithStats = new PlayerWithStatsDto
                {
                    Id = playerDto.Id,
                    Position = playerDto.Position,
                    Name = playerDto.Name,
                    PlayerNum = playerDto.PlayerNum,
                    TeamId = playerDto.TeamId,
                    TeamName = playerDto.TeamName,
                    School = playerDto.School,
                    Cost = playerDto.Cost,
                    PictureUrl = playerDto.PictureUrl,
                    Stats = null
                };

                // Add stats if IncludeStats is true
                if (filter.IncludeStats)
                {
                    if (statsDict != null && statsDict.TryGetValue(player.Id, out var stats))
                    {
                        playerWithStats.Stats = new PlayerStatsSummaryDto
                        {
                            TotalPoints = pointsDict?.GetValueOrDefault(player.Id, 0) ?? 0,
                            TotalGoals = stats.Goals,
                            TotalAssists = stats.Assists,
                            TotalCleanSheets = cleanSheetsCountDict?.GetValueOrDefault(player.Id, 0) ?? 0,
                            TotalSaves = stats.Saves,
                            GamesPlayed = gamesPlayedDict?.GetValueOrDefault(player.Id, 0) ?? 0
                        };
                    }
                    else
                    {
                        // Player has no stats - return zeros
                        playerWithStats.Stats = new PlayerStatsSummaryDto
                        {
                            TotalPoints = 0,
                            TotalGoals = 0,
                            TotalAssists = 0,
                            TotalCleanSheets = 0,
                            TotalSaves = 0,
                            GamesPlayed = 0
                        };
                    }
                }

                playerDtos.Add(playerWithStats);
            }

            // Apply sorting
            if (!string.IsNullOrEmpty(filter.SortBy))
            {
                bool isDescending = filter.SortOrder?.Equals("desc", StringComparison.OrdinalIgnoreCase) == true;

                playerDtos = filter.SortBy.ToLower() switch
                {
                    "points" => isDescending 
                        ? playerDtos.OrderByDescending(p => pointsDict?.GetValueOrDefault(p.Id, 0) ?? 0).ToList()
                        : playerDtos.OrderBy(p => pointsDict?.GetValueOrDefault(p.Id, 0) ?? 0).ToList(),
                    "goals" => isDescending
                        ? playerDtos.OrderByDescending(p => statsDict?.GetValueOrDefault(p.Id)?.Goals ?? 0).ToList()
                        : playerDtos.OrderBy(p => statsDict?.GetValueOrDefault(p.Id)?.Goals ?? 0).ToList(),
                    "assists" => isDescending
                        ? playerDtos.OrderByDescending(p => statsDict?.GetValueOrDefault(p.Id)?.Assists ?? 0).ToList()
                        : playerDtos.OrderBy(p => statsDict?.GetValueOrDefault(p.Id)?.Assists ?? 0).ToList(),
                    "cleansheets" => isDescending
                        ? playerDtos.OrderByDescending(p => cleanSheetsCountDict?.GetValueOrDefault(p.Id, 0) ?? 0).ToList()
                        : playerDtos.OrderBy(p => cleanSheetsCountDict?.GetValueOrDefault(p.Id, 0) ?? 0).ToList(),
                    "saves" => isDescending
                        ? playerDtos.OrderByDescending(p => statsDict?.GetValueOrDefault(p.Id)?.Saves ?? 0).ToList()
                        : playerDtos.OrderBy(p => statsDict?.GetValueOrDefault(p.Id)?.Saves ?? 0).ToList(),
                    "cost" => isDescending
                        ? playerDtos.OrderByDescending(p => p.Cost).ToList()
                        : playerDtos.OrderBy(p => p.Cost).ToList(),
                    "name" => isDescending
                        ? playerDtos.OrderByDescending(p => p.Name).ToList()
                        : playerDtos.OrderBy(p => p.Name).ToList(),
                    _ => playerDtos
                };
            }

            return playerDtos;
        }

        public async Task<PlayerStatsDto?> GetPlayerGameweekStatsAsync(int playerId, int gameweekId)
        {
            var aggregate = await _playerRepository.GetPlayerGameweekStatsAggregateAsync(playerId, gameweekId);
            
            if (aggregate == null)
                return null;

            // Calculate total points for the gameweek
            var totalPoints = await _pointsCalculationService.CalculatePlayerGameweekPointsAsync(playerId, gameweekId);

            // Get fixtures with stats for this player in this gameweek
            var fixturesWithStats = await _playerRepository.GetPlayerFixturesWithStatsAsync(playerId, gameweekId);
            
            // Map fixtures to DTOs and calculate points for each fixture
            var fixtureDtos = new List<PlayerGameweekFixtureDto>();
            foreach (var fixture in fixturesWithStats)
            {
                var fixturePoints = await _pointsCalculationService.CalculatePlayerFixturePointsAsync(playerId, fixture.FixtureId);
                
                fixtureDtos.Add(new PlayerGameweekFixtureDto
                {
                    FixtureId = fixture.FixtureId,
                    HomeTeamName = fixture.HomeTeamName,
                    AwayTeamName = fixture.AwayTeamName,
                    HomeScore = fixture.HomeScore,
                    AwayScore = fixture.AwayScore,
                    Kickoff = fixture.Kickoff,
                    MinutesPlayed = fixture.MinutesPlayed,
                    Goals = fixture.Goals,
                    Assists = fixture.Assists,
                    CleanSheet = fixture.CleanSheet,
                    GoalsConceded = fixture.GoalsConceded,
                    YellowCards = fixture.YellowCards,
                    RedCards = fixture.RedCards,
                    Saves = fixture.Saves,
                    Shots = fixture.Shots,
                    ShotsOnGoal = fixture.ShotsOnGoal,
                    PointsEarned = fixturePoints
                });
            }

            // Map to DTO
            return new PlayerStatsDto
            {
                PlayerId = aggregate.PlayerId,
                PlayerName = aggregate.PlayerName,
                GameweekId = aggregate.GameweekId,
                MinutesPlayed = aggregate.MinutesPlayed,
                Goals = aggregate.Goals,
                Assists = aggregate.Assists,
                CleanSheet = aggregate.CleanSheet,
                GoalsConceded = aggregate.GoalsConceded,
                YellowCards = aggregate.YellowCards,
                RedCards = aggregate.RedCards,
                Saves = aggregate.Saves,
                Shots = aggregate.Shots,
                ShotsOnGoal = aggregate.ShotsOnGoal,
                PointsEarned = totalPoints,
                Fixtures = fixtureDtos
            };
        }
    }
}








