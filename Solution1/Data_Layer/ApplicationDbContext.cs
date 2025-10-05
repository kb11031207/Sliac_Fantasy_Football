using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;

namespace Data_Layer
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<User> Users => Set<User>();
        public DbSet<League> Leagues => Set<League>();
        public DbSet<UserLeague> UsersXLeagues => Set<UserLeague>();
        public DbSet<ConferenceTeam> ConferenceTeams => Set<ConferenceTeam>();
        public DbSet<Player> Players => Set<Player>();
        public DbSet<Gameweek> Gameweeks => Set<Gameweek>();
        public DbSet<Squad> Squads => Set<Squad>();
        public DbSet<SquadPlayer> SquadPlayers => Set<SquadPlayer>();
        public DbSet<Fixture> Fixtures => Set<Fixture>();
        public DbSet<FixtureResult> FixtureResults => Set<FixtureResult>();
        public DbSet<PlayerFixtureStats> PlayerFixtureStats => Set<PlayerFixtureStats>();
        public DbSet<PlayerGameweekStats> PlayerGameweekStats => Set<PlayerGameweekStats>();
        public DbSet<UserGameweekScores> UserGameweekScores => Set<UserGameweekScores>();

        protected override void OnModelCreating(ModelBuilder b)
        {
            // Table name mappings to match SQL schema
            b.Entity<User>().ToTable("users");
            b.Entity<League>().ToTable("leagues");
            b.Entity<UserLeague>().ToTable("usersXleagues");
            b.Entity<ConferenceTeam>().ToTable("conferenceTeams");
            b.Entity<Player>().ToTable("players");
            b.Entity<Gameweek>().ToTable("gameweeks");
            b.Entity<Squad>().ToTable("squads");
            b.Entity<SquadPlayer>().ToTable("squadPlayers");
            b.Entity<Fixture>().ToTable("fixtures");
            b.Entity<FixtureResult>().ToTable("fixtureResults");
            b.Entity<PlayerFixtureStats>().ToTable("playerFixtureStats");
            b.Entity<PlayerGameweekStats>().ToTable("playerGameweekStats");
            b.Entity<UserGameweekScores>().ToTable("userGameweekScores");

            // keys and relationships matching your SQL schema
            b.Entity<User>(e =>
            {
                e.Property(u => u.Id).HasColumnName("id");
                e.Property(u => u.Email).HasColumnName("email");
                e.Property(u => u.Username).HasColumnName("username");
                e.Property(u => u.School).HasColumnName("school");
                e.Property(u => u.PassHash).HasColumnName("passHash");
                e.Property(u => u.PassSalt).HasColumnName("passSalt");
                e.HasIndex(x => x.Email).IsUnique();
                e.HasIndex(x => x.Username).IsUnique();
            });

            b.Entity<League>(e =>
            {
                e.Property(l => l.Owner).HasColumnName("owner");
                e.Property(l => l.Type).HasColumnName("type");
                e.HasOne<User>().WithMany(u => u.OwnedLeagues).HasForeignKey(l => l.Owner);
            });

            b.Entity<UserLeague>(e =>
            {
                e.Property(ul => ul.UserId).HasColumnName("userId");
                e.Property(ul => ul.LeagueId).HasColumnName("leagueId");
                e.HasKey(x => new { x.UserId, x.LeagueId });
                e.HasOne<User>().WithMany(u => u.UserLeagues).HasForeignKey(x => x.UserId);
                e.HasOne<League>().WithMany(l => l.UserLeagues).HasForeignKey(x => x.LeagueId);
            });

            b.Entity<ConferenceTeam>(e =>
            {
                e.Property(ct => ct.Team).HasColumnName("Team");
                e.Property(ct => ct.School).HasColumnName("school");
                e.Property(ct => ct.LogoUrl).HasColumnName("logoUrl");
            });

            b.Entity<Player>(e =>
            {
                e.Property(p => p.Position).HasColumnName("position");
                e.Property(p => p.Name).HasColumnName("name");
                e.Property(p => p.PlayerNum).HasColumnName("playerNum");
                e.Property(p => p.TeamId).HasColumnName("teamId");
                e.Property(p => p.Cost).HasColumnName("cost");
                e.Property(p => p.PictureUrl).HasColumnName("pictureUrl");
                e.HasOne(p => p.Team).WithMany(t => t.Players).HasForeignKey(p => p.TeamId);
                e.HasIndex(p => p.Position);
                e.HasIndex(p => p.TeamId);
                e.HasIndex(p => p.Cost);
            });

            b.Entity<Gameweek>(e =>
            {
                e.Property(g => g.StartTime).HasColumnName("startTime");
                e.Property(g => g.EndTime).HasColumnName("endTime");
                e.Property(g => g.IsComplete).HasColumnName("isComplete");
            });

            b.Entity<Squad>(e =>
            {
                e.Property(s => s.UserId).HasColumnName("userId");
                e.Property(s => s.GameweekId).HasColumnName("gameweekId");
                e.Property(s => s.CreatedAt).HasColumnName("createdAt");
                e.Property(s => s.UpdatedAt).HasColumnName("updatedAt");
                e.HasIndex(x => new { x.UserId, x.GameweekId }).IsUnique();
                e.HasOne(s => s.User).WithMany(u => u.Squads).HasForeignKey(s => s.UserId);
                e.HasOne(s => s.Gameweek).WithMany().HasForeignKey(s => s.GameweekId);
            });

            b.Entity<SquadPlayer>(e =>
            {
                e.Property(sp => sp.SquadId).HasColumnName("squadId");
                e.Property(sp => sp.PlayerId).HasColumnName("playerId");
                e.Property(sp => sp.IsStarter).HasColumnName("isStarter");
                e.Property(sp => sp.IsCaptain).HasColumnName("isCaptain");
                e.Property(sp => sp.IsVice).HasColumnName("isVice");
                e.Property(sp => sp.PlayerCost).HasColumnName("playerCost");
                e.HasOne(sp => sp.Squad).WithMany(s => s.SquadPlayers).HasForeignKey(sp => sp.SquadId);
                e.HasOne(sp => sp.Player).WithMany(p => p.SquadPlayers).HasForeignKey(sp => sp.PlayerId);
            });

            b.Entity<Fixture>(e =>
            {
                e.Property(f => f.GameweekId).HasColumnName("GameweekId");
                e.Property(f => f.HomeTeamId).HasColumnName("HomeTeamId");
                e.Property(f => f.AwayTeamId).HasColumnName("AwayTeamId");
                e.Property(f => f.Kickoff).HasColumnName("Kickoff");
                e.HasOne(f => f.HomeTeam)
                    .WithMany(t => t.HomeFixtures)
                    .HasForeignKey(f => f.HomeTeamId)
                    .OnDelete(DeleteBehavior.NoAction);
                
                e.HasOne(f => f.AwayTeam)
                    .WithMany(t => t.AwayFixtures)
                    .HasForeignKey(f => f.AwayTeamId)
                    .OnDelete(DeleteBehavior.NoAction);
                
                e.HasOne(f => f.Gameweek)
                    .WithMany(g => g.Fixtures)
                    .HasForeignKey(f => f.GameweekId);
            });

            b.Entity<FixtureResult>(e =>
            {
                e.Property(fr => fr.FixtureId).HasColumnName("FixtureId");
                e.Property(fr => fr.HomeScore).HasColumnName("HomeScore");
                e.Property(fr => fr.AwayScore).HasColumnName("AwayScore");
                e.HasKey(fr => fr.FixtureId);
                e.HasOne(fr => fr.Fixture)
                    .WithOne(f => f.Result)
                    .HasForeignKey<FixtureResult>(fr => fr.FixtureId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            b.Entity<PlayerFixtureStats>(e =>
            {
                e.Property(pfs => pfs.PlayerId).HasColumnName("PlayerId");
                e.Property(pfs => pfs.FixtureId).HasColumnName("FixtureId");
                e.Property(pfs => pfs.MinutesPlayed).HasColumnName("MinutesPlayed");
                e.Property(pfs => pfs.Goals).HasColumnName("Goals");
                e.Property(pfs => pfs.Assists).HasColumnName("Assists");
                e.Property(pfs => pfs.YellowCards).HasColumnName("YellowCards");
                e.Property(pfs => pfs.RedCards).HasColumnName("RedCards");
                e.Property(pfs => pfs.CleanSheet).HasColumnName("CleanSheet");
                e.Property(pfs => pfs.GoalsConceded).HasColumnName("GoalsConceded");
                e.Property(pfs => pfs.OwnGoals).HasColumnName("OwnGoals");
                e.Property(pfs => pfs.Saves).HasColumnName("Saves");
                e.HasKey(x => new { x.PlayerId, x.FixtureId });
                e.HasOne<Player>().WithMany().HasForeignKey(x => x.PlayerId);
                e.HasOne<Fixture>().WithMany().HasForeignKey(x => x.FixtureId);
            });

            b.Entity<PlayerGameweekStats>(e =>
            {
                e.Property(pgs => pgs.PlayerId).HasColumnName("PlayerId");
                e.Property(pgs => pgs.GameweekId).HasColumnName("GameweekId");
                e.Property(pgs => pgs.FixtureId).HasColumnName("FixtureId");
                e.Property(pgs => pgs.MinutesPlayed).HasColumnName("MinutesPlayed");
                e.Property(pgs => pgs.Goals).HasColumnName("Goals");
                e.Property(pgs => pgs.Assists).HasColumnName("Assists");
                e.Property(pgs => pgs.CleanSheet).HasColumnName("CleanSheet");
                e.Property(pgs => pgs.GoalsConceded).HasColumnName("GoalsConceded");
                e.Property(pgs => pgs.YellowCards).HasColumnName("YellowCards");
                e.Property(pgs => pgs.RedCards).HasColumnName("RedCards");
                e.Property(pgs => pgs.OwnGoals).HasColumnName("OwnGoals");
                e.Property(pgs => pgs.Saves).HasColumnName("Saves");
                e.Property(pgs => pgs.PointsEarned).HasColumnName("PointsEarned");
                e.HasOne<Player>().WithMany(p => p.GameweekStats).HasForeignKey(x => x.PlayerId);
                e.HasOne<Gameweek>().WithMany().HasForeignKey(x => x.GameweekId);
                e.HasOne<Fixture>().WithMany().HasForeignKey(x => x.FixtureId);
            });

            b.Entity<UserGameweekScores>(e =>
            {
                e.Property(ugs => ugs.UserId).HasColumnName("UserId");
                e.Property(ugs => ugs.GameweekId).HasColumnName("GameweekId");
                e.Property(ugs => ugs.TotalPoints).HasColumnName("TotalPoints");
                e.HasIndex(x => new { x.UserId, x.GameweekId }).IsUnique();
                e.HasOne<User>().WithMany().HasForeignKey(x => x.UserId);
                e.HasOne<Gameweek>().WithMany().HasForeignKey(x => x.GameweekId);
            });
        }
    }
}