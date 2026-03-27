using Data_Layer.Models;

namespace Data_Layer.Interfaces
{
    public interface IPlayerRepository : IGenericRepository<Player>
    {
        Task<IEnumerable<Player>> GetByTeamAsync(int teamId);
        Task<IEnumerable<Player>> GetByPositionAsync(byte position);
        Task<IEnumerable<Player>> GetByCostRangeAsync(decimal minCost, decimal maxCost);
        Task<IEnumerable<Player>> GetByIdsAsync(List<int> playerIds);
        Task<PlayerGameweekStatsAggregate?> GetPlayerGameweekStatsAggregateAsync(int playerId, int gameweekId);
        Task<IEnumerable<PlayerFixtureWithStats>> GetPlayerFixturesWithStatsAsync(int playerId, int gameweekId);
        
        // New methods for bulk stats aggregation
        Task<Dictionary<int, PlayerGameweekStatsAggregate>> GetPlayersStatsAggregateAsync(List<int> playerIds, int? gameweekId);
        Task<Dictionary<int, (int CleanSheetsCount, int GamesPlayed)>> GetPlayersStatsCountsAsync(List<int> playerIds, int? gameweekId);
        Task<Dictionary<int, List<int>>> GetPlayersGameweeksAsync(List<int> playerIds);
    }

    public class PlayerFixtureWithStats
    {
        public int FixtureId { get; set; }
        public string? HomeTeamName { get; set; }
        public string? AwayTeamName { get; set; }
        public byte? HomeScore { get; set; }
        public byte? AwayScore { get; set; }
        public DateTime Kickoff { get; set; }
        public byte MinutesPlayed { get; set; }
        public byte Goals { get; set; }
        public byte Assists { get; set; }
        public bool CleanSheet { get; set; }
        public byte GoalsConceded { get; set; }
        public byte YellowCards { get; set; }
        public byte RedCards { get; set; }
        public byte Saves { get; set; }
        public byte Shots { get; set; }
        public byte ShotsOnGoal { get; set; }
    }
}






