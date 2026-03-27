using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class PlayerRepository : GenericRepository<Player>, IPlayerRepository
    {
        public PlayerRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "players") 
        { }

        public override async Task<Player?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE p.Id = @Id";
            
            var players = await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                new { Id = id },
                splitOn: "Id"
            );
            
            return players.FirstOrDefault();
        }

        public override async Task<IEnumerable<Player>> GetAllAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id";
            
            return await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                splitOn: "Id"
            );
        }

        public async Task<IEnumerable<Player>> GetByTeamAsync(int teamId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE p.teamId = @TeamId";
            
            return await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                new { TeamId = teamId },
                splitOn: "Id"
            );
        }

        public async Task<IEnumerable<Player>> GetByPositionAsync(byte position)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE p.position = @Position";
            
            return await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                new { Position = position },
                splitOn: "Id"
            );
        }

        public async Task<IEnumerable<Player>> GetByCostRangeAsync(decimal minCost, decimal maxCost)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE p.cost >= @MinCost AND p.cost <= @MaxCost";
            
            return await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                new { MinCost = minCost, MaxCost = maxCost },
                splitOn: "Id"
            );
        }

        public async Task<IEnumerable<Player>> GetByIdsAsync(List<int> playerIds)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT p.*, t.Id, t.Team, t.school, t.logoUrl
                FROM players p
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE p.Id IN @PlayerIds";
            
            return await connection.QueryAsync<Player, ConferenceTeam, Player>(
                sql,
                (player, team) =>
                {
                    player.Team = team;
                    return player;
                },
                new { PlayerIds = playerIds },
                splitOn: "Id"
            );
        }

        public async Task<PlayerGameweekStatsAggregate?> GetPlayerGameweekStatsAggregateAsync(int playerId, int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    p.id AS PlayerId,
                    p.name AS PlayerName,
                    @GameweekId AS GameweekId,
                    CAST(SUM(CAST(pfs.MinutesPlayed AS INT)) AS TINYINT) AS MinutesPlayed,
                    CAST(SUM(CAST(pfs.Goals AS INT)) AS TINYINT) AS Goals,
                    CAST(SUM(CAST(pfs.Assists AS INT)) AS TINYINT) AS Assists,
                    CAST(MAX(CAST(pfs.CleanSheet AS INT)) AS BIT) AS CleanSheet,
                    CAST(SUM(CAST(pfs.GoalsConceded AS INT)) AS TINYINT) AS GoalsConceded,
                    CAST(SUM(CAST(pfs.YellowCards AS INT)) AS TINYINT) AS YellowCards,
                    CAST(SUM(CAST(pfs.RedCards AS INT)) AS TINYINT) AS RedCards,
                    CAST(SUM(CAST(pfs.Saves AS INT)) AS TINYINT) AS Saves,
                    CAST(SUM(CAST(pfs.Shots AS INT)) AS TINYINT) AS Shots,
                    CAST(SUM(CAST(pfs.ShotsOnGoal AS INT)) AS TINYINT) AS ShotsOnGoal
                FROM playerFixtureStats pfs
                INNER JOIN fixtures f ON pfs.FixtureId = f.Id
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.PlayerId = @PlayerId 
                    AND f.GameweekId = @GameweekId
                    AND (f.HomeTeamId = p.teamId OR f.AwayTeamId = p.teamId)
                GROUP BY p.id, p.name";

            var result = await connection.QueryFirstOrDefaultAsync<PlayerGameweekStatsAggregate>(sql, 
                new { PlayerId = playerId, GameweekId = gameweekId });
            
            return result;
        }

        public async Task<IEnumerable<PlayerFixtureWithStats>> GetPlayerFixturesWithStatsAsync(int playerId, int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    f.Id AS FixtureId,
                    ht.Team AS HomeTeamName,
                    at.Team AS AwayTeamName,
                    fr.HomeScore,
                    fr.AwayScore,
                    f.Kickoff,
                    pfs.MinutesPlayed,
                    pfs.Goals,
                    pfs.Assists,
                    pfs.CleanSheet,
                    pfs.GoalsConceded,
                    pfs.YellowCards,
                    pfs.RedCards,
                    pfs.Saves,
                    pfs.Shots,
                    pfs.ShotsOnGoal
                FROM playerFixtureStats pfs
                INNER JOIN fixtures f ON pfs.FixtureId = f.Id
                INNER JOIN players p ON pfs.PlayerId = p.id
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                LEFT JOIN fixtureResults fr ON f.Id = fr.FixtureId
                WHERE pfs.PlayerId = @PlayerId 
                    AND f.GameweekId = @GameweekId
                    AND (f.HomeTeamId = p.teamId OR f.AwayTeamId = p.teamId)
                ORDER BY f.Kickoff";

            var results = await connection.QueryAsync<PlayerFixtureWithStats>(sql, 
                new { PlayerId = playerId, GameweekId = gameweekId });
            
            return results;
        }

        public override async Task<Player> AddAsync(Player entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO players (position, name, playerNum, teamId, cost, pictureUrl)
                VALUES (@Position, @Name, @PlayerNum, @TeamId, @Cost, @PictureUrl);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<Player> UpdateAsync(Player entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE players 
                SET position = @Position,
                    name = @Name,
                    playerNum = @PlayerNum,
                    teamId = @TeamId,
                    cost = @Cost,
                    pictureUrl = @PictureUrl
                WHERE Id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(Player entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM players WHERE Id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }

        public async Task<Dictionary<int, PlayerGameweekStatsAggregate>> GetPlayersStatsAggregateAsync(List<int> playerIds, int? gameweekId)
        {
            if (playerIds == null || !playerIds.Any())
                return new Dictionary<int, PlayerGameweekStatsAggregate>();

            using var connection = _connectionFactory.CreateConnection();
            
            // Build SQL query - conditionally filter by gameweek using NULL check
            const string sql = @"
                SELECT 
                    p.id AS PlayerId,
                    p.name AS PlayerName,
                    COALESCE(@GameweekId, 0) AS GameweekId,
                    CAST(SUM(CAST(pfs.MinutesPlayed AS INT)) AS TINYINT) AS MinutesPlayed,
                    CAST(SUM(CAST(pfs.Goals AS INT)) AS TINYINT) AS Goals,
                    CAST(SUM(CAST(pfs.Assists AS INT)) AS TINYINT) AS Assists,
                    CAST(MAX(CAST(pfs.CleanSheet AS INT)) AS BIT) AS CleanSheet,
                    CAST(SUM(CAST(pfs.GoalsConceded AS INT)) AS TINYINT) AS GoalsConceded,
                    CAST(SUM(CAST(pfs.YellowCards AS INT)) AS TINYINT) AS YellowCards,
                    CAST(SUM(CAST(pfs.RedCards AS INT)) AS TINYINT) AS RedCards,
                    CAST(SUM(CAST(pfs.Saves AS INT)) AS TINYINT) AS Saves,
                    CAST(SUM(CAST(pfs.Shots AS INT)) AS TINYINT) AS Shots,
                    CAST(SUM(CAST(pfs.ShotsOnGoal AS INT)) AS TINYINT) AS ShotsOnGoal
                FROM playerFixtureStats pfs
                INNER JOIN fixtures f ON pfs.FixtureId = f.Id
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.PlayerId IN @PlayerIds
                    AND (f.HomeTeamId = p.teamId OR f.AwayTeamId = p.teamId)
                    AND (@GameweekId IS NULL OR f.GameweekId = @GameweekId)
                GROUP BY p.id, p.name";

            var parameters = new { PlayerIds = playerIds, GameweekId = gameweekId };

            var results = await connection.QueryAsync<PlayerGameweekStatsAggregate>(sql, parameters);
            
            // Convert to dictionary for easy lookup
            var statsDict = results.ToDictionary(r => r.PlayerId, r => r);
            
            // Ensure all requested players are in the dictionary (with zero stats if they have no stats)
            foreach (var playerId in playerIds)
            {
                if (!statsDict.ContainsKey(playerId))
                {
                    statsDict[playerId] = new PlayerGameweekStatsAggregate
                    {
                        PlayerId = playerId,
                        PlayerName = string.Empty, // Will be filled from player data
                        GameweekId = gameweekId ?? 0,
                        MinutesPlayed = 0,
                        Goals = 0,
                        Assists = 0,
                        CleanSheet = false,
                        GoalsConceded = 0,
                        YellowCards = 0,
                        RedCards = 0,
                        Saves = 0,
                        Shots = 0,
                        ShotsOnGoal = 0
                    };
                }
            }
            
            return statsDict;
        }

        public async Task<Dictionary<int, (int CleanSheetsCount, int GamesPlayed)>> GetPlayersStatsCountsAsync(List<int> playerIds, int? gameweekId)
        {
            if (playerIds == null || !playerIds.Any())
                return new Dictionary<int, (int, int)>();

            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                SELECT 
                    p.id AS PlayerId,
                    SUM(CAST(pfs.CleanSheet AS INT)) AS CleanSheetsCount,
                    COUNT(DISTINCT f.Id) AS GamesPlayed
                FROM playerFixtureStats pfs
                INNER JOIN fixtures f ON pfs.FixtureId = f.Id
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.PlayerId IN @PlayerIds
                    AND (f.HomeTeamId = p.teamId OR f.AwayTeamId = p.teamId)
                    AND (@GameweekId IS NULL OR f.GameweekId = @GameweekId)
                GROUP BY p.id";

            var parameters = new { PlayerIds = playerIds, GameweekId = gameweekId };

            var results = await connection.QueryAsync<(int PlayerId, int CleanSheetsCount, int GamesPlayed)>(sql, parameters);
            
            var countsDict = results.ToDictionary(r => r.PlayerId, r => (r.CleanSheetsCount, r.GamesPlayed));
            
            // Ensure all requested players are in the dictionary (with zero counts if they have no stats)
            foreach (var playerId in playerIds)
            {
                if (!countsDict.ContainsKey(playerId))
                {
                    countsDict[playerId] = (0, 0);
                }
            }
            
            return countsDict;
        }

        public async Task<Dictionary<int, List<int>>> GetPlayersGameweeksAsync(List<int> playerIds)
        {
            if (playerIds == null || !playerIds.Any())
                return new Dictionary<int, List<int>>();

            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                SELECT DISTINCT
                    p.id AS PlayerId,
                    f.GameweekId
                FROM playerFixtureStats pfs
                INNER JOIN fixtures f ON pfs.FixtureId = f.Id
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.PlayerId IN @PlayerIds
                    AND (f.HomeTeamId = p.teamId OR f.AwayTeamId = p.teamId)
                ORDER BY p.id, f.GameweekId";

            var parameters = new { PlayerIds = playerIds };

            var results = await connection.QueryAsync<(int PlayerId, int GameweekId)>(sql, parameters);
            
            var gameweeksDict = results
                .GroupBy(r => r.PlayerId)
                .ToDictionary(g => g.Key, g => g.Select(r => r.GameweekId).ToList());
            
            // Ensure all requested players are in the dictionary (with empty list if they have no gameweeks)
            foreach (var playerId in playerIds)
            {
                if (!gameweeksDict.ContainsKey(playerId))
                {
                    gameweeksDict[playerId] = new List<int>();
                }
            }
            
            return gameweeksDict;
        }
    }
}
