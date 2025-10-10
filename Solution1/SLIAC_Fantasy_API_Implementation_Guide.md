# SLIAC Fantasy Football API Implementation Guide

## Overview
This guide provides step-by-step instructions for implementing a clean, layered architecture for the SLIAC Fantasy Football API following SOLID principles.

## Architecture Layers
1. **API Layer** - Controllers handling HTTP requests/responses
2. **Service Layer** - Business logic and validation
3. **Repository Layer** - Data access abstraction
4. **Database Layer** - Entity Framework Core with SQL Server

## Prerequisites
- .NET 8.0 SDK
- SQL Server (LocalDB or full instance)
- Visual Studio 2022 or VS Code
- Entity Framework Core tools

## Implementation Instructions

### Phase 1: Repository Layer Setup

#### 1.1 Create Repository Interfaces
Create folder structure: `Solution1/Data_Layer/Interfaces/`

**IGenericRepository.cs** - Base repository interface:
```csharp
using System.Linq.Expressions;

namespace Data_Layer.Interfaces
{
    public interface IGenericRepository<T> where T : class
    {
        Task<T?> GetByIdAsync(int id);
        Task<IEnumerable<T>> GetAllAsync();
        Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate);
        Task<T> AddAsync(T entity);
        Task<T> UpdateAsync(T entity);
        Task<bool> RemoveAsync(T entity);
        Task<bool> ExistsAsync(Expression<Func<T, bool>> predicate);
    }
}
```

**Specific Repository Interfaces**:
- IUserRepository.cs
- ILeagueRepository.cs
- IPlayerRepository.cs
- ISquadRepository.cs
- IFixtureRepository.cs
- IGameweekRepository.cs

#### 1.2 Implement Repository Classes
Create folder: `Solution1/Data_Layer/Repositories/`

**GenericRepository.cs**:
```csharp
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        protected readonly ApplicationDbContext _context;
        protected readonly DbSet<T> _dbSet;

        public GenericRepository(ApplicationDbContext context)
        {
            _context = context;
            _dbSet = context.Set<T>();
        }

        public virtual async Task<T?> GetByIdAsync(int id)
        {
            return await _dbSet.FindAsync(id);
        }

        public virtual async Task<IEnumerable<T>> GetAllAsync()
        {
            return await _dbSet.ToListAsync();
        }

        public virtual async Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate)
        {
            return await _dbSet.Where(predicate).ToListAsync();
        }

        public virtual async Task<T> AddAsync(T entity)
        {
            await _dbSet.AddAsync(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public virtual async Task<T> UpdateAsync(T entity)
        {
            _dbSet.Update(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public virtual async Task<bool> RemoveAsync(T entity)
        {
            _dbSet.Remove(entity);
            var result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public virtual async Task<bool> ExistsAsync(Expression<Func<T, bool>> predicate)
        {
            return await _dbSet.AnyAsync(predicate);
        }
    }
}
```

**UserRepository.cs** - Example specific implementation:
```csharp
using Microsoft.EntityFrameworkCore;
using Data_Layer.Models;
using Data_Layer.Interfaces;

namespace Data_Layer.Repositories
{
    public class UserRepository : GenericRepository<User>, IUserRepository
    {
        public UserRepository(ApplicationDbContext context) : base(context) { }

        public async Task<User?> GetByEmailAsync(string email)
        {
            return await _dbSet.FirstOrDefaultAsync(u => u.Email == email);
        }

        public async Task<User?> GetByUsernameAsync(string username)
        {
            return await _dbSet.FirstOrDefaultAsync(u => u.Username == username);
        }

        public async Task<User?> GetUserWithSquadsAsync(int userId)
        {
            return await _dbSet
                .Include(u => u.Squads)
                    .ThenInclude(s => s.SquadPlayers)
                        .ThenInclude(sp => sp.Player)
                .FirstOrDefaultAsync(u => u.Id == userId);
        }

        public async Task<bool> EmailExistsAsync(string email)
        {
            return await _dbSet.AnyAsync(u => u.Email == email);
        }

        public async Task<bool> UsernameExistsAsync(string username)
        {
            return await _dbSet.AnyAsync(u => u.Username == username);
        }
    }
}
```

### Phase 2: Service Layer Implementation

#### 2.1 Create DTOs (Data Transfer Objects)
Create folder: `Solution1/Service_layer/DTOs/`

**UserDTOs.cs**:
```csharp
using System.ComponentModel.DataAnnotations;

namespace Service_layer.DTOs
{
    public class UserDto
    {
        public int Id { get; set; }
        public string? Email { get; set; }
        public string? Username { get; set; }
        public string? School { get; set; }
    }

    public class RegisterUserDto
    {
        [Required, EmailAddress]
        public string Email { get; set; } = null!;
        
        [Required, MinLength(3), MaxLength(50)]
        public string Username { get; set; } = null!;
        
        [MaxLength(100)]
        public string? School { get; set; }
        
        [Required, MinLength(8)]
        public string Password { get; set; } = null!;
    }

    public class LoginDto
    {
        [Required, EmailAddress]
        public string Email { get; set; } = null!;
        
        [Required]
        public string Password { get; set; } = null!;
    }

    public class UpdateUserDto
    {
        [EmailAddress]
        public string? Email { get; set; }
        
        [MinLength(3), MaxLength(50)]
        public string? Username { get; set; }
        
        [MaxLength(100)]
        public string? School { get; set; }
    }
}
```

#### 2.2 Create Service Interfaces
Create folder: `Solution1/Service_layer/Interfaces/`

**IUserService.cs**:
```csharp
using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface IUserService
    {
        Task<UserDto?> GetUserByIdAsync(int id);
        Task<UserDto?> AuthenticateAsync(string email, string password);
        Task<UserDto> RegisterAsync(RegisterUserDto registerDto);
        Task<UserDto> UpdateUserAsync(int id, UpdateUserDto updateDto);
        Task<bool> DeleteUserAsync(int id);
        Task<bool> ChangePasswordAsync(int id, string currentPassword, string newPassword);
        Task<IEnumerable<UserDto>> GetAllUsersAsync();
    }
}
```

**ILeagueService.cs**:
```csharp
using Service_layer.DTOs;

namespace Service_layer.Interfaces
{
    public interface ILeagueService
    {
        Task<LeagueDto?> GetLeagueByIdAsync(int id);
        Task<LeagueDto> CreateLeagueAsync(CreateLeagueDto createDto, int ownerId);
        Task<bool> JoinLeagueAsync(int userId, int leagueId);
        Task<bool> LeaveLeagueAsync(int userId, int leagueId);
        Task<IEnumerable<LeagueDto>> GetUserLeaguesAsync(int userId);
        Task<IEnumerable<LeagueDto>> GetPublicLeaguesAsync();
        Task<LeagueStandingsDto> GetLeagueStandingsAsync(int leagueId, int gameweekId);
    }
}
```

#### 2.3 Implement Services
Create folder: `Solution1/Service_layer/Services/`

**UserService.cs**:
```csharp
using Microsoft.Extensions.Logging;
using System.Security.Cryptography;
using Service_layer.Interfaces;
using Service_layer.DTOs;
using Data_Layer.Interfaces;
using Data_Layer.Models;
using AutoMapper;

namespace Service_layer.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        private readonly ILogger<UserService> _logger;

        public UserService(IUserRepository userRepository, IMapper mapper, ILogger<UserService> logger)
        {
            _userRepository = userRepository;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<UserDto?> GetUserByIdAsync(int id)
        {
            var user = await _userRepository.GetByIdAsync(id);
            return _mapper.Map<UserDto>(user);
        }

        public async Task<UserDto?> AuthenticateAsync(string email, string password)
        {
            var user = await _userRepository.GetByEmailAsync(email);
            if (user == null)
            {
                _logger.LogWarning("Authentication failed: User not found for email {Email}", email);
                return null;
            }

            if (!VerifyPasswordHash(password, user.PassHash, user.PassSalt))
            {
                _logger.LogWarning("Authentication failed: Invalid password for user {Email}", email);
                return null;
            }

            _logger.LogInformation("User {Email} authenticated successfully", email);
            return _mapper.Map<UserDto>(user);
        }

        public async Task<UserDto> RegisterAsync(RegisterUserDto registerDto)
        {
            // Validate email uniqueness
            if (await _userRepository.EmailExistsAsync(registerDto.Email))
            {
                throw new ArgumentException("Email already exists");
            }

            // Validate username uniqueness
            if (await _userRepository.UsernameExistsAsync(registerDto.Username))
            {
                throw new ArgumentException("Username already exists");
            }

            // Create password hash
            CreatePasswordHash(registerDto.Password, out byte[] passwordHash, out byte[] passwordSalt);

            var user = new User
            {
                Email = registerDto.Email,
                Username = registerDto.Username,
                School = registerDto.School,
                PassHash = passwordHash,
                PassSalt = passwordSalt
            };

            var createdUser = await _userRepository.AddAsync(user);
            _logger.LogInformation("New user registered: {Email}", registerDto.Email);

            return _mapper.Map<UserDto>(createdUser);
        }

        private void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            using var hmac = new HMACSHA512();
            passwordSalt = hmac.Key;
            passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        }

        private bool VerifyPasswordHash(string password, byte[] passwordHash, byte[] passwordSalt)
        {
            using var hmac = new HMACSHA512(passwordSalt);
            var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            return computedHash.SequenceEqual(passwordHash);
        }

        // Implement other methods...
    }
}
```

### Phase 3: API Controllers

#### 3.1 Base Controller
Create `Solution1/Api_Srv/Controllers/BaseApiController.cs`:
```csharp
using Microsoft.AspNetCore.Mvc;

namespace Api_Srv.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Produces("application/json")]
    public abstract class BaseApiController : ControllerBase
    {
        protected readonly ILogger _logger;

        protected BaseApiController(ILogger logger)
        {
            _logger = logger;
        }
    }
}
```

#### 3.2 User Controller
```csharp
using Microsoft.AspNetCore.Mvc;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Controllers
{
    public class UsersController : BaseApiController
    {
        private readonly IUserService _userService;

        public UsersController(IUserService userService, ILogger<UsersController> logger) 
            : base(logger)
        {
            _userService = userService;
        }

        /// <summary>
        /// Get user by ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(UserDto), 200)]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetUser(int id)
        {
            var user = await _userService.GetUserByIdAsync(id);
            if (user == null)
                return NotFound($"User with ID {id} not found.");

            return Ok(user);
        }

        /// <summary>
        /// Register new user
        /// </summary>
        [HttpPost("register")]
        [ProducesResponseType(typeof(UserDto), 201)]
        [ProducesResponseType(400)]
        public async Task<IActionResult> Register([FromBody] RegisterUserDto registerDto)
        {
            try
            {
                var user = await _userService.RegisterAsync(registerDto);
                return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

        /// <summary>
        /// User login
        /// </summary>
        [HttpPost("login")]
        [ProducesResponseType(typeof(UserDto), 200)]
        [ProducesResponseType(401)]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            var user = await _userService.AuthenticateAsync(loginDto.Email, loginDto.Password);
            if (user == null)
                return Unauthorized(new { error = "Invalid email or password" });

            // TODO: Generate JWT token
            return Ok(user);
        }
    }
}
```

### Phase 4: Dependency Injection Configuration

#### 4.1 Update Program.cs
```csharp
using Microsoft.EntityFrameworkCore;
using Data_Layer;
using Data_Layer.Interfaces;
using Data_Layer.Repositories;
using Service_layer.Interfaces;
using Service_layer.Services;
using Service_layer.Mappings;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Configure Serilog
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .WriteTo.File("logs/sliac-api-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Host.UseSerilog();

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new() { Title = "SLIAC Fantasy API", Version = "v1" });
});

// Database Configuration
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// AutoMapper
builder.Services.AddAutoMapper(typeof(MappingProfile));

// Repository Registration
builder.Services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<ILeagueRepository, LeagueRepository>();
builder.Services.AddScoped<IPlayerRepository, PlayerRepository>();
builder.Services.AddScoped<ISquadRepository, SquadRepository>();
builder.Services.AddScoped<IFixtureRepository, FixtureRepository>();
builder.Services.AddScoped<IGameweekRepository, GameweekRepository>();

// Service Registration
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<ILeagueService, LeagueService>();
builder.Services.AddScoped<IPlayerService, PlayerService>();
builder.Services.AddScoped<ISquadService, SquadService>();
builder.Services.AddScoped<IFixtureService, FixtureService>();
builder.Services.AddScoped<IGameweekService, GameweekService>();

// CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyMethod()
                   .AllowAnyHeader();
        });
});

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseSerilogRequestLogging();
app.UseHttpsRedirection();
app.UseCors("AllowAll");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

// Apply migrations on startup
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    dbContext.Database.Migrate();
}

app.Run();
```

#### 4.2 Add appsettings.json Configuration
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=SliacFantasyDB;Trusted_Connection=True;MultipleActiveResultSets=true"
  },
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information"
      }
    }
  },
  "JwtSettings": {
    "Secret": "your-secret-key-here-make-it-long-and-secure",
    "Issuer": "SliacFantasyAPI",
    "Audience": "SliacFantasyClient",
    "ExpiryInDays": 7
  }
}
```

### Phase 5: Additional Components

#### 5.1 AutoMapper Profile
Create `Solution1/Service_layer/Mappings/MappingProfile.cs`:
```csharp
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
            CreateMap<RegisterUserDto, User>();
            CreateMap<UpdateUserDto, User>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

            // League mappings
            CreateMap<League, LeagueDto>();
            CreateMap<CreateLeagueDto, League>();

            // Player mappings
            CreateMap<Player, PlayerDto>()
                .ForMember(dest => dest.TeamName, opt => opt.MapFrom(src => src.Team.Team));

            // Add more mappings...
        }
    }
}
```

#### 5.2 Global Exception Handler
Create `Solution1/Api_Srv/Middleware/ExceptionMiddleware.cs`:
```csharp
using System.Net;
using System.Text.Json;

namespace Api_Srv.Middleware
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;

        public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unhandled exception occurred");
                await HandleExceptionAsync(context, ex);
            }
        }

        private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";
            
            var response = new
            {
                error = new
                {
                    message = "An error occurred while processing your request.",
                    detail = exception.Message
                }
            };

            switch (exception)
            {
                case ArgumentException:
                    context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    break;
                case KeyNotFoundException:
                    context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                    break;
                case UnauthorizedAccessException:
                    context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    break;
                default:
                    context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    break;
            }

            var jsonResponse = JsonSerializer.Serialize(response);
            await context.Response.WriteAsync(jsonResponse);
        }
    }
}
```

### Phase 6: Fantasy Football Specific Features

#### 6.1 Squad Management Service
```csharp
namespace Service_layer.Services
{
    public class SquadService : ISquadService
    {
        private readonly ISquadRepository _squadRepository;
        private readonly IPlayerRepository _playerRepository;
        private readonly IGameweekRepository _gameweekRepository;
        private readonly IMapper _mapper;

        // Squad constraints
        private const int MAX_SQUAD_SIZE = 15;
        private const int MAX_PLAYERS_PER_TEAM = 3;
        private const decimal BUDGET_LIMIT = 100m;
        private const int GOALKEEPERS = 2;
        private const int DEFENDERS = 5;
        private const int MIDFIELDERS = 5;
        private const int FORWARDS = 3;

        public async Task<SquadDto> CreateSquadAsync(int userId, CreateSquadDto createDto)
        {
            // Validate gameweek
            var gameweek = await _gameweekRepository.GetByIdAsync(createDto.GameweekId);
            if (gameweek == null || gameweek.Deadline < DateTime.UtcNow)
                throw new ArgumentException("Invalid or closed gameweek");

            // Check if user already has squad for this gameweek
            if (await _squadRepository.UserHasSquadForGameweekAsync(userId, createDto.GameweekId))
                throw new ArgumentException("Squad already exists for this gameweek");

            // Validate squad composition and budget
            await ValidateSquadAsync(createDto.PlayerIds);

            // Create squad
            var squad = new Squad
            {
                UserId = userId,
                GameweekId = createDto.GameweekId,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };

            var createdSquad = await _squadRepository.AddAsync(squad);

            // Add players to squad
            foreach (var playerId in createDto.PlayerIds)
            {
                await _squadRepository.AddPlayerToSquadAsync(createdSquad.Id, playerId);
            }

            return _mapper.Map<SquadDto>(createdSquad);
        }

        private async Task ValidateSquadAsync(List<int> playerIds)
        {
            if (playerIds.Count != MAX_SQUAD_SIZE)
                throw new ArgumentException($"Squad must contain exactly {MAX_SQUAD_SIZE} players");

            var players = await _playerRepository.GetByIdsAsync(playerIds);
            
            // Validate budget
            var totalCost = players.Sum(p => p.Cost);
            if (totalCost > BUDGET_LIMIT)
                throw new ArgumentException($"Squad cost exceeds budget limit of {BUDGET_LIMIT}");

            // Validate position constraints
            var positionCounts = players.GroupBy(p => p.Position)
                .ToDictionary(g => g.Key, g => g.Count());

            if (positionCounts.GetValueOrDefault(1) != GOALKEEPERS) // Position 1 = GK
                throw new ArgumentException($"Squad must contain exactly {GOALKEEPERS} goalkeepers");
            
            if (positionCounts.GetValueOrDefault(2) != DEFENDERS) // Position 2 = DEF
                throw new ArgumentException($"Squad must contain exactly {DEFENDERS} defenders");
            
            if (positionCounts.GetValueOrDefault(3) != MIDFIELDERS) // Position 3 = MID
                throw new ArgumentException($"Squad must contain exactly {MIDFIELDERS} midfielders");
            
            if (positionCounts.GetValueOrDefault(4) != FORWARDS) // Position 4 = FWD
                throw new ArgumentException($"Squad must contain exactly {FORWARDS} forwards");

            // Validate max players per team
            var teamCounts = players.GroupBy(p => p.TeamId)
                .ToDictionary(g => g.Key, g => g.Count());

            foreach (var teamCount in teamCounts)
            {
                if (teamCount.Value > MAX_PLAYERS_PER_TEAM)
                    throw new ArgumentException($"Cannot have more than {MAX_PLAYERS_PER_TEAM} players from the same team");
            }
        }
    }
}
```

#### 6.2 Points Calculation Service
Based on SLIAC scoring rules [[memory:9610674]]:
```csharp
namespace Service_layer.Services
{
    public class PointsCalculationService : IPointsCalculationService
    {
        private readonly IPlayerFixtureStatsRepository _statsRepository;

        // Scoring rules
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

        public async Task<int> CalculatePlayerPointsAsync(int playerId, int fixtureId)
        {
            var stats = await _statsRepository.GetPlayerFixtureStatsAsync(playerId, fixtureId);
            if (stats == null) return 0;

            var player = stats.Player;
            var points = 0;

            // Goals scored
            if (stats.Goals > 0)
            {
                points += stats.Goals * GetGoalPoints(player.Position);
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

            // Defender/GK specific
            if (player.Position == 1 || player.Position == 2) // GK or DEF
            {
                // Clean sheet
                if (stats.GoalsConceded == 0 && stats.MinutesPlayed >= 60)
                    points += CLEAN_SHEET_POINTS;

                // Goals conceded
                points += stats.GoalsConceded * GOAL_CONCEDED_POINTS;

                // GK saves bonus
                if (player.Position == 1 && stats.Saves >= GK_SAVES_BONUS_THRESHOLD)
                {
                    points += (stats.Saves / GK_SAVES_BONUS_THRESHOLD) * GK_SAVES_BONUS_POINTS;
                }
            }

            return points;
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
```

### Phase 7: Testing Strategy

#### 7.1 Unit Tests
Create `Solution1/Api_Srv.Tests/UserServiceTests.cs`:
```csharp
using Xunit;
using Moq;
using Service_layer.Services;
using Data_Layer.Interfaces;
using AutoMapper;
using Microsoft.Extensions.Logging;

namespace Api_Srv.Tests
{
    public class UserServiceTests
    {
        private readonly Mock<IUserRepository> _mockUserRepo;
        private readonly Mock<IMapper> _mockMapper;
        private readonly Mock<ILogger<UserService>> _mockLogger;
        private readonly UserService _userService;

        public UserServiceTests()
        {
            _mockUserRepo = new Mock<IUserRepository>();
            _mockMapper = new Mock<IMapper>();
            _mockLogger = new Mock<ILogger<UserService>>();
            _userService = new UserService(_mockUserRepo.Object, _mockMapper.Object, _mockLogger.Object);
        }

        [Fact]
        public async Task RegisterAsync_ShouldThrowException_WhenEmailExists()
        {
            // Arrange
            var registerDto = new RegisterUserDto { Email = "test@example.com" };
            _mockUserRepo.Setup(x => x.EmailExistsAsync(It.IsAny<string>()))
                .ReturnsAsync(true);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(() => 
                _userService.RegisterAsync(registerDto));
        }

        // Add more tests...
    }
}
```

### Phase 8: Security Implementation

#### 8.1 JWT Authentication
Create `Solution1/Service_layer/Services/TokenService.cs`:
```csharp
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace Service_layer.Services
{
    public class TokenService : ITokenService
    {
        private readonly IConfiguration _configuration;

        public TokenService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public string GenerateToken(int userId, string email, string username)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration["JwtSettings:Secret"]);
            
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.NameIdentifier, userId.ToString()),
                    new Claim(ClaimTypes.Email, email),
                    new Claim(ClaimTypes.Name, username)
                }),
                Expires = DateTime.UtcNow.AddDays(Convert.ToDouble(_configuration["JwtSettings:ExpiryInDays"])),
                Issuer = _configuration["JwtSettings:Issuer"],
                Audience = _configuration["JwtSettings:Audience"],
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), 
                    SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
```

## Required NuGet Packages

Add to each project as needed:

**Data_Layer.csproj**:
```xml
<PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.0" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="8.0.0" />
```

**Service_layer.csproj**:
```xml
<PackageReference Include="AutoMapper" Version="12.0.1" />
<PackageReference Include="FluentValidation" Version="11.8.0" />
<PackageReference Include="System.IdentityModel.Tokens.Jwt" Version="7.0.0" />
```

**Api_Srv.csproj**:
```xml
<PackageReference Include="AutoMapper.Extensions.Microsoft.DependencyInjection" Version="12.0.1" />
<PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.0" />
<PackageReference Include="Serilog.AspNetCore" Version="7.0.0" />
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
```

## Implementation Order

1. **Start with Repository Layer** - Implement all repository interfaces and classes
2. **Create DTOs and AutoMapper** - Set up data transfer objects and mappings
3. **Implement Core Services** - User, League, Player services first
4. **Build API Controllers** - Start with Users and Authentication
5. **Configure DI and Middleware** - Set up Program.cs and exception handling
6. **Add Authentication** - Implement JWT tokens
7. **Fantasy-specific Features** - Squad management, points calculation
8. **Testing** - Unit tests for services, integration tests for controllers
9. **Documentation** - API documentation with Swagger

## Best Practices

1. **Always use async/await** for database operations
2. **Log important operations** and errors
3. **Validate input** at both DTO and service levels
4. **Use transactions** for multi-step operations
5. **Return appropriate HTTP status codes**
6. **Handle exceptions gracefully**
7. **Use DTOs** - never expose entities directly
8. **Follow RESTful conventions** for API endpoints
9. **Implement pagination** for list endpoints
10. **Add caching** where appropriate

## Common Pitfalls to Avoid

1. Don't expose database entities in API responses
2. Don't put business logic in controllers
3. Don't skip input validation
4. Don't hardcode connection strings or secrets
5. Don't ignore proper error handling
6. Don't skip unit tests
7. Don't violate SOLID principles
8. Don't forget to dispose of resources
9. Don't ignore security considerations
10. Don't mix concerns between layers
