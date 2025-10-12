using System.Data;

namespace Data_Layer
{
    public interface IDbConnectionFactory
    {
        IDbConnection CreateConnection();
    }
}

