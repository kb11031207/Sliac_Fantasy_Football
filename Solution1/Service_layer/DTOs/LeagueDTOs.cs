using System.ComponentModel.DataAnnotations;

namespace Service_layer.DTOs
{
    public class LeagueDto
    {
        public int Id { get; set; }
        public int Owner { get; set; }
        public string? OwnerUsername { get; set; }
        public bool Type { get; set; } // false = private, true = public
        public string TypeDisplay => Type ? "Public" : "Private";
        public int MemberCount { get; set; }
    }

    public class CreateLeagueDto
    {
        [Required(ErrorMessage = "League type is required")]
        public bool Type { get; set; } // false = private, true = public
    }

    public class LeagueDetailsDto
    {
        public int Id { get; set; }
        public int Owner { get; set; }
        public string? OwnerUsername { get; set; }
        public bool Type { get; set; }
        public List<LeagueMemberDto> Members { get; set; } = new List<LeagueMemberDto>();
    }

    public class LeagueMemberDto
    {
        public int UserId { get; set; }
        public string? Username { get; set; }
        public string? School { get; set; }
    }

    public class LeagueStandingsDto
    {
        public int LeagueId { get; set; }
        public int GameweekId { get; set; }
        public List<LeagueStandingEntry> Standings { get; set; } = new List<LeagueStandingEntry>();
    }

    public class LeagueStandingEntry
    {
        public int Rank { get; set; }
        public int UserId { get; set; }
        public string? Username { get; set; }
        public int TotalPoints { get; set; }
    }
}



