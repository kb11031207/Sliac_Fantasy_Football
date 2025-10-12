using System.Data;
using Dapper;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class UserRepository : GenericRepository<User>, IUserRepository
    {
        public UserRepository(IDbConnectionFactory connectionFactory) 
            : base(connectionFactory, "users") 
        { }

        public override async Task<User?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM users WHERE id = @Id";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Id = id });
        }

        public async Task<User?> GetByEmailAsync(string email)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM users WHERE email = @Email";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Email = email });
        }

        public async Task<User?> GetByUsernameAsync(string username)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM users WHERE username = @Username";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Username = username });
        }

        public async Task<User?> GetUserWithSquadsAsync(int userId)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                SELECT 
                    u.id, u.email, u.username, u.school, u.passHash, u.passSalt,
                    s.id, s.userId, s.gameweekId, s.createdAt, s.updatedAt,
                    sp.id, sp.squadId, sp.playerId, sp.isStarter, sp.isCaptain, sp.isVice, sp.playerCost,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl
                FROM users u
                LEFT JOIN squads s ON u.id = s.userId
                LEFT JOIN squadPlayers sp ON s.id = sp.squadId
                LEFT JOIN players p ON sp.playerId = p.id
                WHERE u.id = @UserId";

            var userDict = new Dictionary<int, User>();
            var squadDict = new Dictionary<int, Squad>();
            var squadPlayerDict = new Dictionary<int, SquadPlayer>();

            await connection.QueryAsync<User, Squad, SquadPlayer, Player, User>(
                sql,
                (user, squad, squadPlayer, player) =>
                {
                    // Build the user object
                    if (!userDict.TryGetValue(user.Id, out var currentUser))
                    {
                        currentUser = user;
                        currentUser.Squads = new List<Squad>();
                        userDict.Add(user.Id, currentUser);
                    }

                    // Build squads
                    if (squad != null && squad.Id > 0)
                    {
                        if (!squadDict.TryGetValue(squad.Id, out var currentSquad))
                        {
                            currentSquad = squad;
                            currentSquad.SquadPlayers = new List<SquadPlayer>();
                            currentUser.Squads.Add(currentSquad);
                            squadDict.Add(squad.Id, currentSquad);
                        }

                        // Build squad players
                        if (squadPlayer != null && squadPlayer.Id > 0)
                        {
                            var spKey = squadPlayer.Id;
                            if (!squadPlayerDict.ContainsKey(spKey))
                            {
                                if (player != null)
                                {
                                    squadPlayer.Player = player;
                                }
                                currentSquad.SquadPlayers.Add(squadPlayer);
                                squadPlayerDict.Add(spKey, squadPlayer);
                            }
                        }
                    }

                    return currentUser;
                },
                new { UserId = userId },
                splitOn: "id,id,id,id"
            );

            return userDict.Values.FirstOrDefault();
        }

        public override async Task<User> AddAsync(User entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                INSERT INTO users (email, username, school, passHash, passSalt)
                VALUES (@Email, @Username, @School, @PassHash, @PassSalt);
                SELECT CAST(SCOPE_IDENTITY() as int)";
            
            var id = await connection.ExecuteScalarAsync<int>(sql, entity);
            entity.Id = id;
            return entity;
        }

        public override async Task<User> UpdateAsync(User entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                UPDATE users 
                SET email = @Email, 
                    username = @Username, 
                    school = @School,
                    passHash = @PassHash,
                    passSalt = @PassSalt
                WHERE id = @Id";
            
            await connection.ExecuteAsync(sql, entity);
            return entity;
        }

        public override async Task<bool> RemoveAsync(User entity)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "DELETE FROM users WHERE id = @Id";
            var rowsAffected = await connection.ExecuteAsync(sql, new { entity.Id });
            return rowsAffected > 0;
        }

        public async Task<bool> EmailExistsAsync(string email)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT COUNT(1) FROM users WHERE email = @Email";
            var count = await connection.ExecuteScalarAsync<int>(sql, new { Email = email });
            return count > 0;
        }

        public async Task<bool> UsernameExistsAsync(string username)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT COUNT(1) FROM users WHERE username = @Username";
            var count = await connection.ExecuteScalarAsync<int>(sql, new { Username = username });
            return count > 0;
        }

        public async Task<User?> GetByRefreshTokenAsync(string refreshToken)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = "SELECT * FROM users WHERE RefreshToken = @RefreshToken";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { RefreshToken = refreshToken });
        }

        public async Task<bool> UpdateRefreshTokenAsync(int userId, string refreshToken, DateTime expiryTime)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE users 
                SET RefreshToken = @RefreshToken,
                    RefreshTokenExpiryTime = @ExpiryTime
                WHERE id = @UserId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, 
                new { UserId = userId, RefreshToken = refreshToken, ExpiryTime = expiryTime });
            return rowsAffected > 0;
        }

        public async Task<bool> IncrementFailedLoginAttemptsAsync(int userId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE users 
                SET FailedLoginAttempts = FailedLoginAttempts + 1
                WHERE id = @UserId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, new { UserId = userId });
            return rowsAffected > 0;
        }

        public async Task<bool> ResetFailedLoginAttemptsAsync(int userId)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE users 
                SET FailedLoginAttempts = 0,
                    LockoutEnd = NULL
                WHERE id = @UserId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, new { UserId = userId });
            return rowsAffected > 0;
        }

        public async Task<bool> SetLockoutEndAsync(int userId, DateTime lockoutEnd)
        {
            using var connection = _connectionFactory.CreateConnection();
            const string sql = @"
                UPDATE users 
                SET LockoutEnd = @LockoutEnd
                WHERE id = @UserId";
            
            var rowsAffected = await connection.ExecuteAsync(sql, new { UserId = userId, LockoutEnd = lockoutEnd });
            return rowsAffected > 0;
        }
    }
}
