using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class FixtureRepository : GenericRepository<Fixture>, IFixtureRepository
    {
        public FixtureRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "fixtures") 
        { }

        public override async Task<Fixture?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    f.Id, f.GameweekId, f.HomeTeamId, f.AwayTeamId, f.Kickoff,
                    ht.Id, ht.Team, ht.school, ht.logoUrl,
                    at.Id, at.Team, at.school, at.logoUrl,
                    fr.FixtureId, fr.HomeScore, fr.AwayScore
                FROM fixtures f
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                LEFT JOIN fixtureResults fr ON f.Id = fr.FixtureId
                WHERE f.Id = @Id";

            var fixtures = await connection.QueryAsync<Fixture, ConferenceTeam, ConferenceTeam, FixtureResult, Fixture>(
                sql,
                (fixture, homeTeam, awayTeam, result) =>
                {
                    fixture.HomeTeam = homeTeam;
                    fixture.AwayTeam = awayTeam;
                    fixture.Result = result;
                    return fixture;
                },
                new { Id = id },
                splitOn: "Id,Id,FixtureId"
            );

            return fixtures.FirstOrDefault();
        }

        public async Task<IEnumerable<Fixture>> GetByGameweekAsync(int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    f.Id, f.GameweekId, f.HomeTeamId, f.AwayTeamId, f.Kickoff,
                    ht.Id, ht.Team, ht.school, ht.logoUrl,
                    at.Id, at.Team, at.school, at.logoUrl,
                    fr.FixtureId, fr.HomeScore, fr.AwayScore
                FROM fixtures f
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                LEFT JOIN fixtureResults fr ON f.Id = fr.FixtureId
                WHERE f.GameweekId = @GameweekId
                ORDER BY f.Kickoff";

            return await connection.QueryAsync<Fixture, ConferenceTeam, ConferenceTeam, FixtureResult, Fixture>(
                sql,
                (fixture, homeTeam, awayTeam, result) =>
                {
                    fixture.HomeTeam = homeTeam;
                    fixture.AwayTeam = awayTeam;
                    fixture.Result = result;
                    return fixture;
                },
                new { GameweekId = gameweekId },
                splitOn: "Id,Id,FixtureId"
            );
        }

        public async Task<IEnumerable<Fixture>> GetByTeamAsync(int teamId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT 
                    f.Id, f.GameweekId, f.HomeTeamId, f.AwayTeamId, f.Kickoff,
                    ht.Id, ht.Team, ht.school, ht.logoUrl,
                    at.Id, at.Team, at.school, at.logoUrl,
                    fr.FixtureId, fr.HomeScore, fr.AwayScore
                FROM fixtures f
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                LEFT JOIN fixtureResults fr ON f.Id = fr.FixtureId
                WHERE f.HomeTeamId = @TeamId OR f.AwayTeamId = @TeamId
                ORDER BY f.Kickoff DESC";

            return await connection.QueryAsync<Fixture, ConferenceTeam, ConferenceTeam, FixtureResult, Fixture>(
                sql,
                (fixture, homeTeam, awayTeam, result) =>
                {
                    fixture.HomeTeam = homeTeam;
                    fixture.AwayTeam = awayTeam;
                    fixture.Result = result;
                    return fixture;
                },
                new { TeamId = teamId },
                splitOn: "Id,Id,FixtureId"
            );
        }

        public async Task<Fixture?> GetFixtureWithStatsAsync(int fixtureId)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            // First get the fixture with teams and result
            const string fixtureSql = @"
                SELECT 
                    f.Id, f.GameweekId, f.HomeTeamId, f.AwayTeamId, f.Kickoff,
                    ht.Id, ht.Team, ht.school, ht.logoUrl,
                    at.Id, at.Team, at.school, at.logoUrl,
                    fr.FixtureId, fr.HomeScore, fr.AwayScore
                FROM fixtures f
                LEFT JOIN conferenceTeams ht ON f.HomeTeamId = ht.Id
                LEFT JOIN conferenceTeams at ON f.AwayTeamId = at.Id
                LEFT JOIN fixtureResults fr ON f.Id = fr.FixtureId
                WHERE f.Id = @FixtureId";

            Fixture? fixture = null;
            
            var fixtures = await connection.QueryAsync<Fixture, ConferenceTeam, ConferenceTeam, FixtureResult, Fixture>(
                fixtureSql,
                (f, homeTeam, awayTeam, result) =>
                {
                    f.HomeTeam = homeTeam;
                    f.AwayTeam = awayTeam;
                    f.Result = result;
                    fixture = f;
                    return f;
                },
                new { FixtureId = fixtureId },
                splitOn: "Id,Id,FixtureId"
            );

            fixture = fixtures.FirstOrDefault();
            if (fixture == null) return null;

            // Now get the player stats
            const string statsSql = @"
                SELECT 
                    pfs.PlayerId, pfs.FixtureId, pfs.MinutesPlayed, pfs.Goals, pfs.Assists,
                    pfs.YellowCards, pfs.RedCards, pfs.CleanSheet, pfs.GoalsConceded,
                    pfs.OwnGoals, pfs.Saves,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl
                FROM playerFixtureStats pfs
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.FixtureId = @FixtureId";

            var stats = await connection.QueryAsync<PlayerFixtureStats, Player, PlayerFixtureStats>(
                statsSql,
                (stat, player) =>
                {
                    stat.Player = player;
                    return stat;
                },
                new { FixtureId = fixtureId },
                splitOn: "id"
            );

            fixture.PlayerStats = stats.ToList();
            return fixture;
        }

        public override async Task<Fixture> AddAsync(Fixture entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO fixtures (GameweekId, HomeTeamId, AwayTeamId, Kickoff)
                VALUES (@GameweekId, @HomeTeamId, @AwayTeamId, @Kickoff);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<Fixture> UpdateAsync(Fixture entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE fixtures 
                SET GameweekId = @GameweekId,
                    HomeTeamId = @HomeTeamId,
                    AwayTeamId = @AwayTeamId,
                    Kickoff = @Kickoff
                WHERE Id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(Fixture entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM fixtures WHERE Id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }
    }
}
