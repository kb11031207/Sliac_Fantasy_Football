# SLIAC Fantasy Football API - 10-Minute Presentation

## Slide 1: Title Slide (30 seconds)
**SLIAC Fantasy Football API**
*A Real-World Fantasy Sports Platform*

- Your Name
- CSCI 316 - Professional Software Development
- Principia College, Fall 2025

---

## Slide 2: Project Overview (1 minute)
**What Is It?**

A complete fantasy football REST API for the St. Louis Intercollegiate Athletic Conference (SLIAC)

**Key Features:**
- JWT Authentication & Authorization
- League & Squad Management
- Real-time Player Statistics
- Automated Web Scraping
- Fantasy Points Calculation

**Technology Stack:**
- ASP.NET Core 8.0 Web API
- Dapper (micro-ORM) + SQL Server
- Python web scrapers
- 30+ API endpoints

---

## Slide 3: Architecture - 3-Layer Design (1.5 minutes)
**Clean Architecture Pattern**

```
API Layer (Controllers)
    ↓
Service Layer (Business Logic)
    ↓
Data Layer (Repositories)
    ↓
Database (SQL Server)
```

**Why This Design?**
- **Separation of Concerns**: Each layer has one responsibility
- **Testability**: Can mock layers independently
- **Maintainability**: Changes isolated to specific layers
- **Scalability**: Can swap implementations without affecting other layers

**Project Structure:**
- `Api_Srv/` - Controllers & HTTP handling
- `Service_layer/` - DTOs, business logic, validation
- `Data_Layer/` - Dapper repositories, database access
- `Database1/` - SQL schema & migrations

---

## Slide 4: SOLID Principles - Part 1 (1.5 minutes)
**Single Responsibility Principle (SRP)**

✅ **Good Example: TokenService**
```csharp
public class TokenService : ITokenService
{
    // Only handles JWT token operations
    public string GenerateAccessToken(...)
    public string GenerateRefreshToken()
    public ClaimsPrincipal? GetPrincipalFromExpiredToken(...)
}
```
*Focused responsibility - no user management, no persistence*

**Dependency Inversion Principle (DIP)**

✅ **Good Example: Constructor Injection**
```csharp
public class PlayerService : IPlayerService
{
    private readonly IPlayerRepository _playerRepository; // Interface, not concrete
    private readonly IMapper _mapper;

    public PlayerService(IPlayerRepository playerRepository, IMapper mapper)
    {
        _playerRepository = playerRepository;
        _mapper = mapper;
    }
}
```
*Depends on abstractions, easily testable with mocks*

---

## Slide 5: SOLID Principles - Part 2 (1.5 minutes)
**Open/Closed Principle (OCP)**

✅ **Good Example: GenericRepository Extension**
```csharp
// Base class - closed for modification
public class GenericRepository<T> : IGenericRepository<T>
{
    public virtual async Task<T?> GetByIdAsync(int id) { ... }
}

// Extended for specific needs - open for extension
public class PlayerRepository : GenericRepository<Player>
{
    public override async Task<Player?> GetByIdAsync(int id)
    {
        // Custom SQL with JOIN to ConferenceTeam
    }

    public async Task<IEnumerable<Player>> GetByTeamAsync(int teamId)
    {
        // New functionality without modifying base
    }
}
```

**Interface Segregation Principle (ISP)**

✅ **Good Example: Focused DTOs**
```csharp
public class LoginDto              // Only login fields
{
    public string Email { get; set; }
    public string Password { get; set; }
}

public class RegisterUserDto      // Registration-specific
{
    public string Email { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public string School { get; set; }
}
```
*Clients only depend on what they need*

---

## Slide 6: Cool Feature #1 - PDF Scraping for Stats (1.5 minutes)
**Automated Data Collection from PDFs**

**The Challenge:**
- SLIAC publishes match statistics as PDF box scores
- Need to extract: goals, assists, minutes, cards, saves, clean sheets

**The Solution:**
```python
# scraper/fixtures/3_update_player_stats.py
def get_pdf_url_from_boxscore(boxscore_url):
    # Two-step process:
    # 1. Scrape box score page → get document link
    # 2. Scrape document viewer → get S3 PDF URL
    pdf_url = extract_s3_link(boxscore_url)

def extract_player_stats_from_pdf(pdf_path):
    # Parse PDF tables with pdfplumber
    # Extract player names and match stats
    # Generate SQL INSERT statements
```

**Why It's Cool:**
- Fully automated - runs weekly during season
- Handles complex PDF formats and parsing
- Generates ready-to-execute SQL
- Downloads and stores PDFs for audit trail

**Real Impact:** Saves hours of manual data entry per week!

---

## Slide 7: Cool Feature #2 - Complex Squad Validation (1 minute)
**Business Rules Enforcement**

**SLIAC Fantasy Football Constraints:**
```csharp
private const int MAX_SQUAD_SIZE = 15;           // 15 total players
private const int MAX_PLAYERS_PER_TEAM = 3;      // Max 3 from same team
private const decimal BUDGET_LIMIT = 100m;       // 100.0 budget cap
private const int REQUIRED_GOALKEEPERS = 2;      // 2 GK, 5 DEF, 5 MID, 3 FWD
private const int REQUIRED_DEFENDERS = 5;
private const int REQUIRED_MIDFIELDERS = 5;
private const int REQUIRED_FORWARDS = 3;
```

**Validation Examples:**
- Formation validation (min 3 DEF, 2 MID, 1 FWD in starting 11)
- Budget calculation with player costs
- Captain/Vice-captain must be starters and different
- Can't modify squad after gameweek starts

**Implementation:** Service_layer/Services/SquadService.cs:75-99

---

## Slide 8: Cool Feature #3 - JWT with Refresh Tokens (1 minute)
**Secure Authentication System**

**Features:**
- Access tokens (30 min expiration)
- Refresh tokens (7 day expiration)
- Account lockout after 5 failed attempts
- HMACSHA512 password hashing

**Flow:**
```
1. User registers → Password hashed with salt
2. User logs in → Returns access token + refresh token
3. Access token expires → Client uses refresh token
4. New access token issued → No re-login required
5. Refresh token expires → Must login again
```

**Security Highlights:**
- Passwords never stored in plain text
- Tokens stored securely in database
- Claims-based authorization (user ID in JWT)
- Brute force protection (15-min lockout)

**Location:** Service_layer/Services/UserService.cs & TokenService.cs

---

## Slide 9: Design Choices & Trade-offs (1 minute)
**Key Decisions Made**

| Choice | Why? | Trade-off |
|--------|------|-----------|
| **Dapper over Entity Framework** | Lightweight, full SQL control, better performance | Manual SQL queries (more code) |
| **JWT over Session Cookies** | Stateless, scalable, mobile-friendly | Token management complexity |
| **3-Layer Architecture** | Clear separation, testable, maintainable | More files/boilerplate |
| **Python for Scrapers** | Rich libraries (BeautifulSoup, pdfplumber) | Separate tech stack to maintain |
| **SQL Server over NoSQL** | Relational data (users, leagues, squads), ACID compliance | Less flexible schema changes |
| **AutoMapper for DTOs** | Reduces boilerplate mapping code | Learning curve, hidden mappings |

**Best Choice Made:** 3-layer architecture with dependency injection
- Made testing easier
- Allowed easy mocking
- Clear code organization

**Questionable Choice:** Hardcoded scoring rules (violates Open/Closed Principle)

---

## Slide 10: Lessons Learned (1.5 minutes)
**What Went Well ✅**

1. **SOLID Principles are Powerful**
   - Dependency injection made unit testing trivial
   - Interface-based design allowed easy mocking

2. **Separation of Concerns Pays Off**
   - Could develop API while scraper was being built
   - Easy to troubleshoot - knew exactly where bugs were

3. **DTOs Prevent Over-exposure**
   - Never sent password hashes to clients
   - Different DTOs for different operations

**What Was Challenging ⚠️**

1. **PDF Parsing**
   - Different PDF formats from different teams
   - Had to handle inconsistent table structures
   - Solution: Multiple parsing strategies with fallbacks

2. **Dapper Learning Curve**
   - Manual SQL queries vs EF's magic
   - No automatic relationship loading
   - Solution: Created generic repository pattern

3. **Authentication Complexity**
   - Refresh token rotation
   - Account lockout timing
   - Claims extraction in controllers

---

## Slide 11: What I'd Do Differently (1 minute)
**If I Started Over...**

**1. Extract Scoring Rules to Configuration**
```csharp
// Current: Hardcoded in PointsCalculationService
private const int FORWARD_GOAL_POINTS = 5;

// Better: Configuration interface
public interface IPointsRulesConfiguration
{
    int GetGoalPoints(byte position);
}
```
*Would allow rule changes without recompiling*

**2. Split UserRepository**
```csharp
// Current: One bloated interface (12 methods)
public interface IUserRepository { /* everything */ }

// Better: Role-specific interfaces
public interface IUserLookupRepository { ... }
public interface IUserSecurityRepository { ... }
public interface IUserTokenRepository { ... }
```
*Better follows Interface Segregation Principle*

**3. Add Integration Tests Earlier**
- Currently have basic unit tests
- Should have added API integration tests from the start
- Would have caught authorization bugs sooner

**4. Use Background Jobs for Scraping**
- Currently manual script execution
- Better: Scheduled background jobs (Hangfire/Quartz)

---

## Slide 12: Demo & Q&A (30 seconds)
**Live API Demo** (if time permits)

Swagger UI at `https://localhost:7139/swagger`

**Key Endpoints:**
- `POST /api/users/register` - Create account
- `POST /api/users/login` - Get JWT token
- `GET /api/gameweeks/current` - Current gameweek (requires auth)
- `POST /api/squads/user/{userId}` - Create squad (requires auth)

**GitHub Repository:**
[Your repo link]

**Documentation:**
- README.md - Setup & API guide
- JWT_AUTHENTICATION_GUIDE.md - Auth implementation
- scraper/README.md - Web scraper documentation

---

**Questions?**

Thank you!
