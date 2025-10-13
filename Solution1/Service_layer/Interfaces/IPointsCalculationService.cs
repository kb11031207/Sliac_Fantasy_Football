namespace Service_layer.Interfaces
{
    public interface IPointsCalculationService
    {
        Task<int> CalculatePlayerFixturePointsAsync(int playerId, int fixtureId);
        Task<int> CalculatePlayerGameweekPointsAsync(int playerId, int gameweekId);
        Task<int> CalculateSquadGameweekPointsAsync(int squadId);
    }
}





