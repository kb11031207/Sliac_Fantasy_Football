using Microsoft.EntityFrameworkCore;
using api_srv.Models;

namespace api_srv.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<League> Leagues { get; set; }
        public DbSet<UserLeague> UserLeagues { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure composite key for UserLeague
            modelBuilder.Entity<UserLeague>()
                .HasKey(ul => new { ul.UserId, ul.LeagueId });

            // Configure unique constraints for User
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique()
                .HasDatabaseName("UQ_users_email");

            modelBuilder.Entity<User>()
                .HasIndex(u => u.Username)
                .IsUnique()
                .HasDatabaseName("UQ_users_username");

            // Configure relationships
            modelBuilder.Entity<League>()
                .HasOne(l => l.OwnerUser)
                .WithMany(u => u.OwnedLeagues)
                .HasForeignKey(l => l.Owner)
                .HasConstraintName("FK_leagues_Tousers");

            modelBuilder.Entity<UserLeague>()
                .HasOne(ul => ul.User)
                .WithMany(u => u.UserLeagues)
                .HasForeignKey(ul => ul.UserId)
                .HasConstraintName("FK_usersXleagues_Tousers");

            modelBuilder.Entity<UserLeague>()
                .HasOne(ul => ul.League)
                .WithMany(l => l.UserLeagues)
                .HasForeignKey(ul => ul.LeagueId)
                .HasConstraintName("FK_usersXleagues_Toleagues");

            base.OnModelCreating(modelBuilder);
        }
    }
}
