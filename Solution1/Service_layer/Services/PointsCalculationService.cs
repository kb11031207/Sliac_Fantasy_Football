using System.Data;
using Dapper;
using Data_Layer;
using Data_Layer.Interfaces;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class PointsCalculationService : IPointsCalculationService
    {
        private readonly IDbConnectionFactory _connectionFactory;

        // SLIAC Scoring rules
        private const int FORWARD_GOAL_POINTS = 5;
        private const int MIDFIELDER_GOAL_POINTS = 6;
        private const int DEFENDER_GK_GOAL_POINTS = 8;
        private const int ASSIST_POINTS = 3;
        private const int FULL_MATCH_POINTS = 2;
        private const int PARTIAL_MATCH_POINTS = 1;
        private const int YELLOW_CARD_POINTS = -1;
        private const int RED_CARD_POINTS = -3;
        private const int CLEAN_SHEET_POINTS = 4;
        private const int GK_SAVES_BONUS_THRESHOLD = 3;
        private const int GK_SAVES_BONUS_POINTS = 1;
        private const int GOAL_CONCEDED_POINTS = -1;

        public PointsCalculationService(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<int> CalculatePlayerFixturePointsAsync(int playerId, int fixtureId)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                SELECT 
                    pfs.PlayerId, pfs.FixtureId, pfs.MinutesPlayed, pfs.Goals, pfs.Assists,
                    pfs.YellowCards, pfs.RedCards, pfs.CleanSheet, pfs.GoalsConceded,
                    pfs.OwnGoals, pfs.Saves,
                    p.id, p.position, p.name, p.playerNum, p.teamId, p.cost, p.pictureUrl
                FROM playerFixtureStats pfs
                INNER JOIN players p ON pfs.PlayerId = p.id
                WHERE pfs.PlayerId = @PlayerId AND pfs.FixtureId = @FixtureId";

            var stats = await connection.QueryAsync<dynamic>(sql, 
                new { PlayerId = playerId, FixtureId = fixtureId });

            var stat = stats.FirstOrDefault();
            if (stat == null) return 0;

            var points = 0;

            // Goals scored (position-dependent)
            if (stat.Goals > 0)
            {
                points += stat.Goals * GetGoalPoints((byte)stat.position);
            }

            // Assists
            points += stat.Assists * ASSIST_POINTS;

            // Playing time
            if (stat.MinutesPlayed >= 90)
                points += FULL_MATCH_POINTS;
            else if (stat.MinutesPlayed > 45)
                points += PARTIAL_MATCH_POINTS;

            // Cards
            points += stat.YellowCards * YELLOW_CARD_POINTS;
            points += stat.RedCards * RED_CARD_POINTS;

            // Defender/GK specific points
            if (stat.position == 1 || stat.position == 2) // GK or DEF
            {
                // Clean sheet (must play at least 60 minutes)
                if (stat.CleanSheet && stat.MinutesPlayed >= 60)
                    points += CLEAN_SHEET_POINTS;

                // Goals conceded
                points += stat.GoalsConceded * GOAL_CONCEDED_POINTS;

                // GK saves bonus
                if (stat.position == 1 && stat.Saves >= GK_SAVES_BONUS_THRESHOLD)
                {
                    points += (stat.Saves / GK_SAVES_BONUS_THRESHOLD) * GK_SAVES_BONUS_POINTS;
                }
            }

            return points;
        }

        public async Task<int> CalculatePlayerGameweekPointsAsync(int playerId, int gameweekId)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            // Get all fixtures in the gameweek
            const string sql = @"
                SELECT Id 
                FROM fixtures 
                WHERE GameweekId = @GameweekId";
            
            var fixtureIds = await connection.QueryAsync<int>(sql, new { GameweekId = gameweekId });

            var totalPoints = 0;
            foreach (var fixtureId in fixtureIds)
            {
                totalPoints += await CalculatePlayerFixturePointsAsync(playerId, fixtureId);
            }

            return totalPoints;
        }

        public async Task<int> CalculateSquadGameweekPointsAsync(int squadId)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            const string sql = @"
                SELECT 
                    s.id, s.userId, s.gameweekId,
                    sp.id, sp.squadId, sp.playerId, sp.isStarter, sp.isCaptain
                FROM squads s
                INNER JOIN squadPlayers sp ON s.id = sp.squadId
                WHERE s.id = @SquadId AND sp.isStarter = 1";

            var squadData = await connection.QueryAsync<dynamic>(sql, new { SquadId = squadId });
            
            if (!squadData.Any()) return 0;

            var gameweekId = squadData.First().gameweekId;
            var totalPoints = 0;

            foreach (var squadPlayer in squadData)
            {
                var playerPoints = await CalculatePlayerGameweekPointsAsync(
                    squadPlayer.playerId, 
                    gameweekId);

                // Captain gets double points
                if (squadPlayer.isCaptain)
                    playerPoints *= 2;

                totalPoints += playerPoints;
            }

            return totalPoints;
        }

        private int GetGoalPoints(byte position)
        {
            return position switch
            {
                4 => FORWARD_GOAL_POINTS,      // Forward
                3 => MIDFIELDER_GOAL_POINTS,   // Midfielder
                2 => DEFENDER_GK_GOAL_POINTS,  // Defender
                1 => DEFENDER_GK_GOAL_POINTS,  // Goalkeeper
                _ => 0
            };
        }
    }
}
