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
    }
}
