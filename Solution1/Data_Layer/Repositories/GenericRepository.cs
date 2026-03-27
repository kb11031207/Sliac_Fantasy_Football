using System.Data;
using System.Linq.Expressions;
using Dapper;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        protected readonly IDbConnectionFactory _connectionFactory;
        protected readonly string _tableName;

        public GenericRepository(IDbConnectionFactory connectionFactory, string tableName)
        {
            _connectionFactory = connectionFactory;
            _tableName = tableName;
        }

        public virtual async Task<T?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();
            var sql = $"SELECT * FROM {_tableName} WHERE Id = @Id";
            return await connection.QueryFirstOrDefaultAsync<T>(sql, new { Id = id });
        }

        public virtual async Task<IEnumerable<T>> GetAllAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            var sql = $"SELECT * FROM {_tableName}";
            return await connection.QueryAsync<T>(sql);
        }

        public virtual async Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate)
        {
            // Dapper doesn't support LINQ expressions directly
            // Override in derived repositories with specific SQL queries
            throw new NotImplementedException("Override this method in derived repository with specific SQL query");
        }

        public virtual async Task<T> AddAsync(T entity)
        {
            // Must be overridden in derived repositories with specific INSERT SQL
            throw new NotImplementedException("Override this method in derived repository with specific INSERT query");
        }

        public virtual async Task<T> UpdateAsync(T entity)
        {
            // Must be overridden in derived repositories with specific UPDATE SQL
            throw new NotImplementedException("Override this method in derived repository with specific UPDATE query");
        }

        public virtual async Task<bool> RemoveAsync(T entity)
        {
            // Must be overridden in derived repositories with specific DELETE SQL
            throw new NotImplementedException("Override this method in derived repository with specific DELETE query");
        }

        public virtual async Task<bool> ExistsAsync(Expression<Func<T, bool>> predicate)
        {
            // Must be overridden in derived repositories with specific EXISTS SQL
            throw new NotImplementedException("Override this method in derived repository with specific EXISTS query");
        }
    }
}
