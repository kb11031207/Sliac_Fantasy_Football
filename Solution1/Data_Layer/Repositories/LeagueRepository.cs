using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class LeagueRepository : GenericRepository<League>, ILeagueRepository
    {
        public LeagueRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "leagues") 
        { }

        public override async Task<League?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM leagues WHERE Id = @Id";
            return await connection.QueryFirstOrDefaultAsync<League>(sql, new { Id = id });
        }

        public async Task<IEnumerable<League>> GetByOwnerAsync(int ownerId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM leagues WHERE owner = @OwnerId";
            return await connection.QueryAsync<League>(sql, new { OwnerId = ownerId });
        }

        public async Task<IEnumerable<League>> GetUserLeaguesAsync(int userId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT l.* 
                FROM leagues l
                INNER JOIN usersXleagues ul ON l.Id = ul.leagueId
                WHERE ul.userId = @UserId";
            return await connection.QueryAsync<League>(sql, new { UserId = userId });
        }

        public async Task<IEnumerable<League>> GetPublicLeaguesAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM leagues WHERE type = 1";
            return await connection.QueryAsync<League>(sql);
        }

        public async Task<bool> AddUserToLeagueAsync(int userId, int leagueId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO usersXleagues (userId, leagueId)
                VALUES (@UserId, @LeagueId)";
            
            try
            {
                var rowsAffected = await connection.ExecuteAsync(sql, new { UserId = userId, LeagueId = leagueId });
                return rowsAffected > 0;
            }
            catch
            {
                // Handles duplicate key constraint violations
                return false;
            }
        }

        public async Task<bool> RemoveUserFromLeagueAsync(int userId, int leagueId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                DELETE FROM usersXleagues 
                WHERE userId = @UserId AND leagueId = @LeagueId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, new { UserId = userId, LeagueId = leagueId });
            return rowsAffected > 0;
        }

        public async Task<bool> IsUserInLeagueAsync(int userId, int leagueId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                SELECT COUNT(1) 
                FROM usersXleagues 
                WHERE userId = @UserId AND leagueId = @LeagueId";
            
            var count = await connection.ExecuteScalarAsync<int>(sql, new { UserId = userId, LeagueId = leagueId });
            return count > 0;
        }

        public override async Task<League> AddAsync(League entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                INSERT INTO leagues (owner, type)
                VALUES (@Owner, @Type);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<League> UpdateAsync(League entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE leagues 
                SET owner = @Owner, 
                    type = @Type
                WHERE Id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(League entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM leagues WHERE Id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }
    }
}
