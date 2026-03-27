using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class SquadRepository : GenericRepository<Squad>, ISquadRepository
    {
        public SquadRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "squads") 
        { }

        public override async Task<Squad?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM squads WHERE id = @Id";
            return await connection.QueryFirstOrDefaultAsync<Squad>(sql, new { Id = id });
        }

        public async Task<Squad?> GetUserSquadForGameweekAsync(int userId, int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    s.id, s.userId, s.gameweekId, s.createdAt, s.updatedAt,
                    sp.id, sp.squadId, sp.playerId, sp.isStarter, sp.isCaptain, sp.isVice, sp.playerCost,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl,
                    t.Id, t.Team, t.school, t.logoUrl
                FROM squads s
                LEFT JOIN squadPlayers sp ON s.id = sp.squadId
                LEFT JOIN players p ON sp.playerId = p.id
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE s.userId = @UserId AND s.gameweekId = @GameweekId";

            var squadDict = new Dictionary<int, Squad>();
            var squadPlayerDict = new Dictionary<int, SquadPlayer>();

            await connection.QueryAsync<Squad, SquadPlayer, Player, ConferenceTeam, Squad>(
                sql,
                (squad, squadPlayer, player, team) =>
                {
                    if (!squadDict.TryGetValue(squad.Id, out var currentSquad))
                    {
                        currentSquad = squad;
                        currentSquad.SquadPlayers = new List<SquadPlayer>();
                        squadDict.Add(squad.Id, currentSquad);
                    }

                    if (squadPlayer != null && squadPlayer.Id > 0)
                    {
                        if (!squadPlayerDict.ContainsKey(squadPlayer.Id))
                        {
                            if (player != null)
                            {
                                player.Team = team;
                                squadPlayer.Player = player;
                            }
                            currentSquad.SquadPlayers.Add(squadPlayer);
                            squadPlayerDict.Add(squadPlayer.Id, squadPlayer);
                        }
                    }

                    return currentSquad;
                },
                new { UserId = userId, GameweekId = gameweekId },
                splitOn: "id,id,Id"
            );

            return squadDict.Values.FirstOrDefault();
        }

        public async Task<IEnumerable<Squad>> GetUserSquadsAsync(int userId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    s.id, s.userId, s.gameweekId, s.createdAt, s.updatedAt,
                    g.id, g.startTime, g.endTime, g.isComplete,
                    sp.id, sp.squadId, sp.playerId, sp.isStarter, sp.isCaptain, sp.isVice, sp.playerCost,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl
                FROM squads s
                LEFT JOIN gameweeks g ON s.gameweekId = g.id
                LEFT JOIN squadPlayers sp ON s.id = sp.squadId
                LEFT JOIN players p ON sp.playerId = p.id
                WHERE s.userId = @UserId
                ORDER BY s.gameweekId DESC";

            var squadDict = new Dictionary<int, Squad>();
            var squadPlayerDict = new Dictionary<int, SquadPlayer>();

            await connection.QueryAsync<Squad, Gameweek, SquadPlayer, Player, Squad>(
                sql,
                (squad, gameweek, squadPlayer, player) =>
                {
                    if (!squadDict.TryGetValue(squad.Id, out var currentSquad))
                    {
                        currentSquad = squad;
                        currentSquad.Gameweek = gameweek;
                        currentSquad.SquadPlayers = new List<SquadPlayer>();
                        squadDict.Add(squad.Id, currentSquad);
                    }

                    if (squadPlayer != null && squadPlayer.Id > 0)
                    {
                        if (!squadPlayerDict.ContainsKey(squadPlayer.Id))
                        {
                            squadPlayer.Player = player;
                            currentSquad.SquadPlayers.Add(squadPlayer);
                            squadPlayerDict.Add(squadPlayer.Id, squadPlayer);
                        }
                    }

                    return currentSquad;
                },
                new { UserId = userId },
                splitOn: "id,id,id"
            );

            return squadDict.Values;
        }

        public async Task<bool> UserHasSquadForGameweekAsync(int userId, int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT COUNT(1) 
                FROM squads 
                WHERE userId = @UserId AND gameweekId = @GameweekId";
            
            var count = await connection.ExecuteScalarAsync<int>(sql, new { UserId = userId, GameweekId = gameweekId });
            return count > 0;
        }

        public async Task<bool> AddPlayerToSquadAsync(int squadId, int playerId, decimal playerCost, bool isStarter, bool isCaptain, bool isVice)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO squadPlayers (squadId, playerId, playerCost, isStarter, isCaptain, isVice)
                VALUES (@SquadId, @PlayerId, @PlayerCost, @IsStarter, @IsCaptain, @IsVice)";
            
            try
            {
                var rowsAffected = await connection.ExecuteAsync(sql, 
                    new { 
                        SquadId = squadId, 
                        PlayerId = playerId, 
                        PlayerCost = playerCost,
                        IsStarter = isStarter,
                        IsCaptain = isCaptain,
                        IsVice = isVice
                    });
                return rowsAffected > 0;
            }
            catch
            {
                return false;
            }
        }
        public async Task<bool> RemovePlayerFromSquadAsync(int squadId, int playerId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                DELETE FROM squadPlayers 
                WHERE squadId = @SquadId AND playerId = @PlayerId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, new { SquadId = squadId, PlayerId = playerId });
            return rowsAffected > 0;
        }

        public async Task<Squad?> GetSquadWithPlayersAsync(int squadId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    s.id, s.userId, s.gameweekId, s.createdAt, s.updatedAt,
                    sp.id, sp.squadId, sp.playerId, sp.isStarter, sp.isCaptain, sp.isVice, sp.playerCost,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl,
                    t.Id, t.Team, t.school, t.logoUrl
                FROM squads s
                LEFT JOIN squadPlayers sp ON s.id = sp.squadId
                LEFT JOIN players p ON sp.playerId = p.id
                LEFT JOIN conferenceTeams t ON p.teamId = t.Id
                WHERE s.id = @SquadId";

            Squad? resultSquad = null;
            var squadPlayerDict = new Dictionary<int, SquadPlayer>();

            await connection.QueryAsync<Squad, SquadPlayer, Player, ConferenceTeam, Squad>(
                sql,
                (squad, squadPlayer, player, team) =>
                {
                    if (resultSquad == null)
                    {
                        resultSquad = squad;
                        resultSquad.SquadPlayers = new List<SquadPlayer>();
                    }

                    if (squadPlayer != null && squadPlayer.Id > 0)
                    {
                        if (!squadPlayerDict.ContainsKey(squadPlayer.Id))
                        {
                            if (player != null)
                            {
                                player.Team = team;
                                squadPlayer.Player = player;
                            }
                            resultSquad.SquadPlayers.Add(squadPlayer);
                            squadPlayerDict.Add(squadPlayer.Id, squadPlayer);
                        }
                    }

                    return resultSquad;
                },
                new { SquadId = squadId },
                splitOn: "id,id,Id"
            );

            return resultSquad;
        }

        public override async Task<Squad> AddAsync(Squad entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO squads (userId, gameweekId, createdAt, updatedAt)
                VALUES (@UserId, @GameweekId, @CreatedAt, @UpdatedAt);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<Squad> UpdateAsync(Squad entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE squads 
                SET userId = @UserId,
                    gameweekId = @GameweekId,
                    updatedAt = @UpdatedAt
                WHERE id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(Squad entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM squads WHERE id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }
    }
}
