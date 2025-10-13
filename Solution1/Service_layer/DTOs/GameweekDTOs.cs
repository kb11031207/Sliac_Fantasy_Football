namespace Service_layer.DTOs
{
    public class GameweekDto
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public bool IsComplete { get; set; }
        public bool IsCurrent { get; set; }
    }

    public class GameweekDetailsDto
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public bool IsComplete { get; set; }
        public List<FixtureDto> Fixtures { get; set; } = new List<FixtureDto>();
    }
}





