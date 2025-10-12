using AutoMapper;
using Data_Layer.Models;
using Service_layer.DTOs;

namespace Service_layer.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // User mappings
            CreateMap<User, UserDto>();
            CreateMap<RegisterUserDto, User>()
                .ForMember(dest => dest.PassHash, opt => opt.Ignore())
                .ForMember(dest => dest.PassSalt, opt => opt.Ignore());
            CreateMap<UpdateUserDto, User>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

            // League mappings
            CreateMap<League, LeagueDto>()
                .ForMember(dest => dest.OwnerUsername, opt => opt.Ignore())
                .ForMember(dest => dest.MemberCount, opt => opt.Ignore());
            CreateMap<CreateLeagueDto, League>();

            // Player mappings
            CreateMap<Player, PlayerDto>()
                .ForMember(dest => dest.TeamName, opt => opt.MapFrom(src => src.Team.Team))
                .ForMember(dest => dest.School, opt => opt.MapFrom(src => src.Team.School));

            // Squad mappings
            CreateMap<Squad, SquadDto>()
                .ForMember(dest => dest.Players, opt => opt.MapFrom(src => src.SquadPlayers))
                .ForMember(dest => dest.TotalCost, opt => opt.Ignore())
                .ForMember(dest => dest.TotalPoints, opt => opt.Ignore());

            CreateMap<SquadPlayer, SquadPlayerDto>()
                .ForMember(dest => dest.PlayerName, opt => opt.MapFrom(src => src.Player.Name))
                .ForMember(dest => dest.Position, opt => opt.MapFrom(src => src.Player.Position))
                .ForMember(dest => dest.TeamName, opt => opt.MapFrom(src => src.Player.Team.Team))
                .ForMember(dest => dest.Points, opt => opt.Ignore());

            // Gameweek mappings
            CreateMap<Gameweek, GameweekDto>()
                .ForMember(dest => dest.IsCurrent, opt => opt.Ignore());
            CreateMap<Gameweek, GameweekDetailsDto>();

            // Fixture mappings
            CreateMap<Fixture, FixtureDto>()
                .ForMember(dest => dest.HomeTeamName, opt => opt.MapFrom(src => src.HomeTeam.Team))
                .ForMember(dest => dest.AwayTeamName, opt => opt.MapFrom(src => src.AwayTeam.Team))
                .ForMember(dest => dest.HomeScore, opt => opt.MapFrom(src => src.Result != null ? src.Result.HomeScore : (byte?)null))
                .ForMember(dest => dest.AwayScore, opt => opt.MapFrom(src => src.Result != null ? src.Result.AwayScore : (byte?)null))
                .ForMember(dest => dest.IsFinished, opt => opt.MapFrom(src => src.Result != null));

            CreateMap<Fixture, FixtureDetailsDto>()
                .ForMember(dest => dest.HomeTeamName, opt => opt.MapFrom(src => src.HomeTeam.Team))
                .ForMember(dest => dest.AwayTeamName, opt => opt.MapFrom(src => src.AwayTeam.Team))
                .ForMember(dest => dest.HomeScore, opt => opt.MapFrom(src => src.Result != null ? src.Result.HomeScore : (byte?)null))
                .ForMember(dest => dest.AwayScore, opt => opt.MapFrom(src => src.Result != null ? src.Result.AwayScore : (byte?)null))
                .ForMember(dest => dest.PlayerStats, opt => opt.MapFrom(src => src.PlayerStats));

            CreateMap<PlayerFixtureStats, PlayerFixtureStatsDto>()
                .ForMember(dest => dest.PlayerName, opt => opt.MapFrom(src => src.Player.Name))
                .ForMember(dest => dest.TeamId, opt => opt.MapFrom(src => src.Player.TeamId));

            // Player stats mappings
            CreateMap<PlayerGameweekStats, PlayerStatsDto>()
                .ForMember(dest => dest.PlayerName, opt => opt.MapFrom(src => src.Player.Name));
        }
    }
}



