using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using Execution_of_Darkness_Wikia.Data;
using Execution_of_Darkness_Wikia.Models;

namespace Execution_of_Darkness_Wikia.Services
{
    public class UserService
    {
        public User Authenticate(string usernameOrEmail, string password)
        {
            using (var db = new WikiDbContext())
            {
                var user = db.Users.FirstOrDefault(u => (u.Username == usernameOrEmail || u.Email == usernameOrEmail) && u.IsActive);
                if (user == null) return null;

                if (VerifyPassword(password, user.PasswordHash, user.Salt))
                {
                    user.LastLoginAt = DateTime.Now;
                    user.UpdatedAt = DateTime.Now;
                    db.SaveChanges();

                    // Retornar cópia desconectada para evitar problemas com o contexto fechado
                    return new User
                    {
                        Id = user.Id,
                        Username = user.Username,
                        Email = user.Email,
                        DisplayName = user.DisplayName,
                        IsAdmin = user.IsAdmin,
                        IsActive = user.IsActive,
                        LastLoginAt = user.LastLoginAt,
                        CreatedAt = user.CreatedAt,
                        UpdatedAt = user.UpdatedAt,
                        PasswordHash = user.PasswordHash,
                        Salt = user.Salt
                    };
                }
                return null;
            }
        }

        public User Register(string username, string email, string password, string displayName = null)
        {
            if (string.IsNullOrWhiteSpace(username))
                throw new Exception("O nome de usuário é obrigatório.");

            if (string.IsNullOrWhiteSpace(email))
                throw new Exception("O email é obrigatório.");

            if (string.IsNullOrWhiteSpace(password) || password.Length < 6)
                throw new Exception("A senha deve ter pelo menos 6 caracteres.");

            using (var db = new WikiDbContext())
            {
                if (db.Users.Any(u => u.Username == username))
                    throw new Exception("Este nome de usuário já está em uso.");

                if (db.Users.Any(u => u.Email == email))
                    throw new Exception("Este email já está cadastrado.");

                var salt = GenerateSalt();
                var hash = HashPassword(password, salt);

                var user = new User
                {
                    Username = username,
                    Email = email,
                    PasswordHash = hash,
                    Salt = salt,
                    DisplayName = displayName ?? username,
                    IsActive = true,
                    IsAdmin = false,
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now
                };

                db.Users.Add(user);
                db.SaveChanges();
                return user;
            }
        }

        private string GenerateSalt()
        {
            var rng = new RNGCryptoServiceProvider();
            var saltBytes = new byte[32];
            rng.GetBytes(saltBytes);
            return Convert.ToBase64String(saltBytes);
        }

        private string HashPassword(string password, string salt)
        {
            using (var sha256 = SHA256.Create())
            {
                var saltedPassword = password + salt;
                var hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(saltedPassword));
                return Convert.ToBase64String(hashBytes);
            }
        }

        private bool VerifyPassword(string password, string hash, string salt)
        {
            var computedHash = HashPassword(password, salt);
            return computedHash == hash;
        }
    }
}