using System.Security.Cryptography;
using System.Text;

namespace api_srv.Services
{
    public class PasswordService : IPasswordService
    {
        public (byte[] hash, byte[] salt) HashPassword(string password)
        {
            // Generate a random salt
            using var rng = RandomNumberGenerator.Create();
            var salt = new byte[16];
            rng.GetBytes(salt);

            // Hash the password with the salt using PBKDF2
            using var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000, HashAlgorithmName.SHA256);
            var hash = pbkdf2.GetBytes(64);

            return (hash, salt);
        }

        public bool VerifyPassword(string password, byte[] hash, byte[] salt)
        {
            // Hash the provided password with the stored salt
            using var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000, HashAlgorithmName.SHA256);
            var testHash = pbkdf2.GetBytes(64);

            // Compare the hashes
            return CryptographicOperations.FixedTimeEquals(hash, testHash);
        }
    }
}
