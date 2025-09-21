namespace api_srv.Services
{
    public interface IPasswordService
    {
        (byte[] hash, byte[] salt) HashPassword(string password);
        bool VerifyPassword(string password, byte[] hash, byte[] salt);
    }
}
