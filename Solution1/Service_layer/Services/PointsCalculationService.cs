using Data_Layer;
using Microsoft.EntityFrameworkCore;
using Service_layer.Interfaces;

namespace Service_layer.Services
{
    public class PointsCalculationService : IPointsCalculationService
    {
        private readonly ApplicationDbContext _context;

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

        public PointsCalculationService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<int> CalculatePlayerFixturePointsAsync(int playerId, int fixtureId)
        {
            var stats = await _context.PlayerFixtureStats
                .Include(pfs => pfs.Player)
                .FirstOrDefaultAsync(pfs => pfs.PlayerId == playerId && pfs.FixtureId == fixtureId);

            if (stats == null) return 0;

            var points = 0;

            // Goals scored (position-dependent)
            if (stats.Goals > 0)
            {
                points += stats.Goals * GetGoalPoints(stats.Player.Position);
            }

            // Assists
            points += stats.Assists * ASSIST_POINTS;

            // Playing time
            if (stats.MinutesPlayed >= 90)
                points += FULL_MATCH_POINTS;
            else if (stats.MinutesPlayed > 45)
                points += PARTIAL_MATCH_POINTS;

            // Cards
            points += stats.YellowCards * YELLOW_CARD_POINTS;
            points += stats.RedCards * RED_CARD_POINTS;

            // Defender/GK specific points
            if (stats.Player.Position == 1 || stats.Player.Position == 2) // GK or DEF
            {
                // Clean sheet (must play at least 60 minutes)
                if (stats.CleanSheet && stats.MinutesPlayed >= 60)
                    points += CLEAN_SHEET_POINTS;

                // Goals conceded
                points += stats.GoalsConceded * GOAL_CONCEDED_POINTS;

                // GK saves bonus
                if (stats.Player.Position == 1 && stats.Saves >= GK_SAVES_BONUS_THRESHOLD)
                {
                    points += (stats.Saves / GK_SAVES_BONUS_THRESHOLD) * GK_SAVES_BONUS_POINTS;
                }
            }

            return points;
        }

        public async Task<int> CalculatePlayerGameweekPointsAsync(int playerId, int gameweekId)
        {
            // Get all fixtures in the gameweek for this player
            var fixtures = await _context.Fixtures
                .Where(f => f.GameweekId == gameweekId)
                .Select(f => f.Id)
                .ToListAsync();

            var totalPoints = 0;
            foreach (var fixtureId in fixtures)
            {
                totalPoints += await CalculatePlayerFixturePointsAsync(playerId, fixtureId);
            }

            return totalPoints;
        }

        public async Task<int> CalculateSquadGameweekPointsAsync(int squadId)
        {
            var squad = await _context.Squads
                .Include(s => s.SquadPlayers)
                    .ThenInclude(sp => sp.Player)
                .FirstOrDefaultAsync(s => s.Id == squadId);

            if (squad == null) return 0;

            var totalPoints = 0;

            // Get starters only (11 players)
            var starters = squad.SquadPlayers.Where(sp => sp.IsStarter).ToList();

            foreach (var squadPlayer in starters)
            {
                var playerPoints = await CalculatePlayerGameweekPointsAsync(
                    squadPlayer.PlayerId, 
                    squad.GameweekId);

                // Captain gets double points
                if (squadPlayer.IsCaptain)
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

