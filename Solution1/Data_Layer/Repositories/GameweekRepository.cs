using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class GameweekRepository : GenericRepository<Gameweek>, IGameweekRepository
    {
        public GameweekRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "gameweeks") 
        { }

        public override async Task<Gameweek?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM gameweeks WHERE id = @Id";
            return await connection.QueryFirstOrDefaultAsync<Gameweek>(sql, new { Id = id });
        }

        public async Task<Gameweek?> GetCurrentGameweekAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT TOP 1 * 
                FROM gameweeks 
                WHERE startTime <= @Now 
                  AND (endTime IS NULL OR endTime >= @Now)
                ORDER BY startTime DESC";
            
            return await connection.QueryFirstOrDefaultAsync<Gameweek>(sql, new { Now = DateTime.UtcNow });
        }

        public async Task<Gameweek?> GetGameweekWithFixturesAsync(int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    g.id, g.startTime, g.endTime, g.isComplete,
                    f.Id, f.GameweekId, f.HomeTeamId, f.AwayTeamId, f.Kickoff,
                    ht.Id, ht.Team, ht.school, ht.logoUrl,
                    at.Id, at.Team, at.school, at.logoUrl
                FROM gameweeks g
                LEFT JOIN fixtures f ON g.id = f.GameweekId
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                WHERE g.id = @GameweekId";

            Gameweek? gameweek = null;
            var fixtureDict = new Dictionary<int, Fixture>();

            await connection.QueryAsync<Gameweek, Fixture, ConferenceTeam, ConferenceTeam, Gameweek>(
                sql,
                (gw, fixture, homeTeam, awayTeam) =>
                {
                    if (gameweek == null)
                    {
                        gameweek = gw;
                        gameweek.Fixtures = new List<Fixture>();
                    }

                    if (fixture != null && fixture.Id > 0)
                    {
                        if (!fixtureDict.ContainsKey(fixture.Id))
                        {
                            fixture.HomeTeam = homeTeam;
                            fixture.AwayTeam = awayTeam;
                            gameweek.Fixtures.Add(fixture);
                            fixtureDict.Add(fixture.Id, fixture);
                        }
                    }

                    return gameweek;
                },
                new { GameweekId = gameweekId },
                splitOn: "Id,Id,Id"
            );

            return gameweek;
        }

        public async Task<IEnumerable<Gameweek>> GetCompletedGameweeksAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT * 
                FROM gameweeks 
                WHERE isComplete = 1
                ORDER BY startTime DESC";
            
            return await connection.QueryAsync<Gameweek>(sql);
        }

        public override async Task<Gameweek> AddAsync(Gameweek entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO gameweeks (startTime, endTime, isComplete)
                VALUES (@StartTime, @EndTime, @IsComplete);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<Gameweek> UpdateAsync(Gameweek entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE gameweeks 
                SET startTime = @StartTime,
                    endTime = @EndTime,
                    isComplete = @IsComplete
                WHERE id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(Gameweek entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM gameweeks WHERE id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }
    }
}
