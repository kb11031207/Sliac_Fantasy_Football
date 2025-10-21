# SLIAC Fantasy Football API
## 10-Minute Presentation Slides

---

# Slide 1: Title
## SLIAC Fantasy Football API
### A Real-World Fantasy Sports Platform

**[Your Name]**
CSCI 316 - Professional Software Development
Principia College, Fall 2025

---

# Slide 2: What Is It?

## Complete Fantasy Football REST API
For St. Louis Intercollegiate Athletic Conference (SLIAC)

### Key Features
- 🔐 JWT Authentication & Authorization
- 🏆 League & Squad Management
- 📊 Real-time Player Statistics
- 🕷️ Automated Web Scraping
- ⚽ Fantasy Points Calculation

### Tech Stack
- ASP.NET Core 8.0 Web API
- Dapper ORM + SQL Server
- Python scrapers
- **30+ API endpoints**

---

# Slide 3: Architecture

## 3-Layer Design Pattern

```
┌─────────────────────────┐
│   API Layer             │  Controllers & HTTP
├─────────────────────────┤
│   Service Layer         │  Business Logic & DTOs
├─────────────────────────┤
│   Data Layer            │  Repositories & Dapper
├─────────────────────────┤
│   SQL Server Database   │  Persistence
└─────────────────────────┘
```

### Benefits
- ✅ Separation of concerns
- ✅ Testability (mock each layer)
- ✅ Maintainability (isolated changes)
- ✅ Scalability (swap implementations)

---

# Slide 4: SOLID - SRP & DIP

## Single Responsibility Principle ✅

**TokenService - One Job Only**
```csharp
public class TokenService : ITokenService
{
    // Only handles JWT tokens - nothing else
    public string GenerateAccessToken(...)
    public string GenerateRefreshToken()
    public ClaimsPrincipal? GetPrincipalFromExpiredToken(...)
}
```

## Dependency Inversion Principle ✅

**Depend on Abstractions**
```csharp
public class PlayerService : IPlayerService
{
    private readonly IPlayerRepository _playerRepository; // Interface!
    private readonly IMapper _mapper;

    // Dependencies injected via constructor
    public PlayerService(IPlayerRepository repo, IMapper mapper)
    {
        _playerRepository = repo;
        _mapper = mapper;
    }
}
```

---

# Slide 5: SOLID - OCP & ISP

## Open/Closed Principle ✅

**Extend Without Modifying**
```csharp
// Base class (CLOSED for modification)
public class GenericRepository<T> : IGenericRepository<T>
{
    public virtual async Task<T?> GetByIdAsync(int id) { ... }
}

// Extended class (OPEN for extension)
public class PlayerRepository : GenericRepository<Player>
{
    // Override with custom SQL
    public override async Task<Player?> GetByIdAsync(int id) { ... }

    // Add new methods
    public async Task<IEnumerable<Player>> GetByTeamAsync(...) { ... }
}
```

## Interface Segregation Principle ✅

**Clients Only See What They Need**
- `LoginDto` - Only email & password
- `RegisterUserDto` - Registration fields only
- `UpdateUserDto` - Update fields only

---

# Slide 6: Cool Feature #1
## 🕷️ PDF Scraping for Player Stats

### The Challenge
- SLIAC publishes stats as **PDF box scores**
- Need: goals, assists, minutes, cards, saves

### The Solution
```python
# Two-step scraping process
1. Scrape box score page → get document link
2. Scrape document viewer → get S3 PDF URL
3. Download PDF
4. Parse tables with pdfplumber
5. Extract player stats
6. Generate SQL INSERT statements
```

### Why It's Cool
- ✅ Fully automated (runs weekly)
- ✅ Handles complex PDF parsing
- ✅ Generates ready-to-execute SQL
- ✅ Saves hours of manual data entry!

**Location:** `scraper/fixtures/3_update_player_stats.py`

---

# Slide 7: Cool Feature #2
## 🛡️ Complex Squad Validation

### SLIAC Fantasy Football Rules
```csharp
MAX_SQUAD_SIZE = 15              // 15 total players
MAX_PLAYERS_PER_TEAM = 3         // Max 3 from same team
BUDGET_LIMIT = 100.0             // 100 budget cap

Squad Composition:
  2 Goalkeepers
  5 Defenders
  5 Midfielders
  3 Forwards
```

### Advanced Validations
- ✅ Formation validation (min 3 DEF, 2 MID, 1 FWD)
- ✅ Budget enforcement
- ✅ Captain/Vice must be starters
- ✅ Can't change after gameweek starts
- ✅ No duplicate players

**Location:** `Service_layer/Services/SquadService.cs`

---

# Slide 8: Cool Feature #3
## 🔐 JWT Authentication

### Security Features
- **Access Tokens** - 30 min expiration
- **Refresh Tokens** - 7 day expiration
- **Account Lockout** - 5 failed attempts → 15 min lockout
- **Password Hashing** - HMACSHA512 with salt

### Flow
```
1. Register → Hash password with salt
2. Login → Return access + refresh tokens
3. Access expires → Use refresh token
4. Get new access → No re-login needed
5. Refresh expires → Must login again
```

### Security Wins
- ✅ Passwords never stored plain text
- ✅ Claims-based authorization
- ✅ Brute force protection
- ✅ Stateless & scalable

---

# Slide 9: Design Choices

## Key Decisions & Trade-offs

| Choice | Why? | Trade-off |
|--------|------|-----------|
| **Dapper** vs EF | Performance, SQL control | Manual queries |
| **JWT** vs Sessions | Stateless, mobile-ready | Token complexity |
| **3-Layer** Architecture | Clear separation | More boilerplate |
| **Python** Scrapers | Rich libraries | Separate stack |
| **SQL Server** | Relational data, ACID | Schema rigidity |

### Best Choice
**3-layer architecture with DI**
- Easy testing
- Clear organization
- Swappable components

### Questionable Choice
**Hardcoded scoring rules**
- Violates Open/Closed Principle
- Must recompile to change rules

---

# Slide 10: Lessons Learned

## What Went Well ✅

### 1. SOLID Principles Work
- DI made testing trivial
- Interfaces allowed easy mocking

### 2. Separation of Concerns Rocks
- Developed API & scraper independently
- Bugs easy to isolate

### 3. DTOs Protect Data
- Never exposed password hashes
- Different DTOs for different operations

## What Was Challenging ⚠️

### 1. PDF Parsing
- Inconsistent formats across teams
- **Solution:** Multiple parsing strategies

### 2. Dapper Learning Curve
- Manual SQL vs EF magic
- **Solution:** Generic repository pattern

### 3. Auth Complexity
- Refresh token rotation
- Claims extraction

---

# Slide 11: What I'd Do Differently

## 1. Extract Scoring Rules
**Current:** Hardcoded constants
**Better:** Configuration interface
```csharp
public interface IPointsRulesConfiguration
{
    int GetGoalPoints(byte position);
}
```

## 2. Split UserRepository
**Current:** Bloated interface (12 methods)
**Better:** Role-specific interfaces
- `IUserLookupRepository`
- `IUserSecurityRepository`
- `IUserTokenRepository`

## 3. Integration Tests Earlier
- Started with unit tests only
- Should have added API tests from day 1

## 4. Background Jobs
- Currently: Manual scraper execution
- Better: Scheduled jobs (Hangfire)

---

# Slide 12: Demo & Questions

## Live Demo
**Swagger UI:** `https://localhost:7139/swagger`

### Try These Endpoints
- `POST /api/users/register` - Create account
- `POST /api/users/login` - Get JWT
- `GET /api/gameweeks/current` - Auth required
- `POST /api/squads/user/{userId}` - Create squad

## Documentation
- ✅ `README.md` - Setup & API guide
- ✅ `JWT_AUTHENTICATION_GUIDE.md` - Auth details
- ✅ `scraper/README.md` - Scraper docs

---

# Questions?

## Thank You!

**Project Stats:**
- 30+ API endpoints
- 10+ database tables
- 200+ players scraped
- 3-layer architecture
- JWT authentication
- PDF parsing system
