# SLIAC Fantasy Football API

A comprehensive fantasy football API for the St. Louis Intercollegiate Athletic Conference (SLIAC), built with ASP.NET Core 8.0, Dapper ORM, and JWT authentication.

## 📋 Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Database Setup](#database-setup)
- [Running the API](#running-the-api)
- [API Documentation](#api-documentation)
- [Testing](#testing)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Scoring Rules](#scoring-rules)
- [Contributing](#contributing)

## ✨ Features

- **JWT Authentication & Authorization** - Secure user registration and login
- **League Management** - Create and manage fantasy football leagues
- **Squad Management** - Build and update player squads 
- **Gameweek Tracking** - Track fixtures and results across gameweeks
- **Player Statistics** - Comprehensive player performance data
- **Swagger/OpenAPI Documentation** - Interactive API documentation

## 🏗️ Architecture

The project follows a clean, layered architecture:

```
Solution1/
├── Api_Srv/              # API Layer (Controllers)
├── Service_layer/        # Business Logic Layer
├── Data_Layer/          # Data Access Layer (Repositories)
└── Database1/           # Database Schema & Scripts
```

### Technology Stack
- **Framework**: ASP.NET Core 8.0
- **ORM**: Dapper (micro-ORM)
- **Database**: SQL Server
- **Authentication**: JWT Bearer Tokens
- **Documentation**: Swagger/OpenAPI
- **Mapping**: AutoMapper
- **Web Scraping**: Custom Python scrapers for SLIAC data

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0) or later
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (2019 or later recommended)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) or [Visual Studio Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)
- [Python 3.8+](https://www.python.org/downloads/) (for running scrapers)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd CSCI_316_Proj
```

### 2. Restore NuGet Packages

Navigate to the solution directory:

```bash
cd Solution1
dotnet restore
```

### 3. Configure Database Connection

Update the connection string in `Solution1/Api_Srv/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=YOUR_SERVER;Initial Catalog=fantasy_proj;Integrated Security=True;Trust Server Certificate=True;Multiple Active Result Sets=True"
  }
}
```

Replace `YOUR_SERVER` with your SQL Server instance name (e.g., `localhost`, `.\SQLEXPRESS`, or `(localdb)\MSSQLLocalDB`).

### 4. Configure JWT Settings

The JWT settings in `appsettings.json` are pre-configured. For production, update the `Secret` key:

```json
{
  "JwtSettings": {
    "Secret": "YOUR_SECURE_SECRET_KEY_HERE_MINIMUM_32_CHARACTERS",
    "Issuer": "SliacFantasyAPI",
    "Audience": "SliacFantasyClient",
    "AccessTokenExpirationMinutes": 30,
    "RefreshTokenExpirationDays": 7
  }
}
```

## 🗄️ Database Setup

### Method 1: Using SQL Scripts (Recommended)

1. Create a new database named `fantasy_proj` in SQL Server
2. Run the database scripts in the following order:

```bash
# Navigate to Database1 directory
cd Solution1/Database1

# Run scripts in this order:
# 1. Create tables
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/conferenceTeams.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/players.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/users.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/leagues.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/usersXleagues.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/squads.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/squadPlayers.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/gameweeks.sql
sqlcmd -S YOUR_SERVER -d fantasy_proj -i dbo/Tables/fixtures.sql

# 2. Add authentication fields
sqlcmd -S YOUR_SERVER -d fantasy_proj -i AddAuthenticationFields.sql
```

### Method 2: Using Visual Studio

1. Open `Solution1.sln` in Visual Studio
2. Right-click on `Database1` project
3. Select **Publish**
4. Choose your SQL Server instance
5. Click **Publish**

### 3. Populate Initial Data

Run the data population scripts:

```bash
# Conference teams
sqlcmd -S YOUR_SERVER -d fantasy_proj -i conferenceTeams.sql

# Players
sqlcmd -S YOUR_SERVER -d fantasy_proj -i players.sql
```

### 4. Run Web Scrapers (Optional - for latest data)

```bash
cd scraper

# Scrape teams
cd teams
pip install -r requirements.txt
python sliac_teams_scraper.py

# Scrape players
cd ../players
pip install -r requirements.txt
python sliac_players_scraper.py

# Scrape fixtures
cd ../fixtures
pip install -r requirements.txt
python 1_setup_fixtures.py
python 2_update_results.py
python 3_update_player_stats.py
```

## 🏃 Running the API

### Using Visual Studio

1. Open `Solution1.sln`
2. Set `Api_Srv` as the startup project
3. Press `F5` or click the **Run** button

### Using Command Line

```bash
cd Solution1/Api_Srv
dotnet run
```

The API will start on:
- **HTTPS**: `https://localhost:7139`
- **HTTP**: `http://localhost:5139`

## 📚 API Documentation

### Swagger UI

Once the API is running, navigate to:

```
https://localhost:7139/swagger
```

The Swagger UI provides:
- Interactive API documentation
- Request/response schemas
- Try-it-out functionality for all endpoints
- JWT authentication support

### Using Swagger with Authentication

1. Register a new user via `/api/users/register`
2. Login via `/api/users/login` to get a JWT token
3. Click the **Authorize** button in Swagger UI
4. Enter: `Bearer YOUR_TOKEN_HERE`
5. Click **Authorize**
6. Now you can test protected endpoints

## 🧪 Testing

### Running Unit Tests

```bash
cd Solution1/Api_Srv.Tests
dotnet test
```

### Manual API Testing

Use the provided `.http` file for testing:

```bash
# Open Api_Srv.http in Visual Studio or VS Code with REST Client extension
```

### Testing with Postman

1. Import the API into Postman using the Swagger JSON:
   ```
   https://localhost:7139/swagger/v1/swagger.json
   ```
2. Create a Postman environment with:
   - `baseUrl`: `https://localhost:7139`
   - `token`: (obtained from login)

### Example Test Workflow

```bash
# 1. Register a user
POST https://localhost:7139/api/users/register
Content-Type: application/json

{
  "username": "testuser",
  "email": "test@example.com",
  "password": "Test@123",
  "confirmPassword": "Test@123"
}

# 2. Login
POST https://localhost:7139/api/users/login
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "Test@123"
}

# 3. Get current gameweek (requires auth)
GET https://localhost:7139/api/gameweeks/current
Authorization: Bearer YOUR_TOKEN_HERE
```

## 📁 Project Structure

```
CSCI_316_Proj/
├── Solution1/
│   ├── Api_Srv/                          # API Layer
│   │   ├── Controllers/                  # API Controllers
│   │   │   ├── UsersController.cs       # User authentication
│   │   │   ├── LeaguesController.cs     # League management
│   │   │   ├── SquadsController.cs      # Squad management
│   │   │   ├── PlayersController.cs     # Player data
│   │   │   ├── FixturesController.cs    # Fixture data
│   │   │   └── GameweeksController.cs   # Gameweek data
│   │   ├── Program.cs                   # App configuration
│   │   └── appsettings.json            # Configuration
│   │
│   ├── Service_layer/                   # Business Logic
│   │   ├── Services/                    # Service implementations
│   │   ├── Interfaces/                  # Service contracts
│   │   └── DTOs/                        # Data Transfer Objects
│   │
│   ├── Data_Layer/                      # Data Access
│   │   ├── Repositories/                # Repository implementations
│   │   ├── Interfaces/                  # Repository contracts
│   │   └── Models/                      # Domain models
│   │
│   └── Database1/                       # Database
│       ├── dbo/Tables/                  # Table definitions
│       └── *.sql                        # SQL scripts
│
└── scraper/                             # Python web scrapers
    ├── teams/                           # Team scraper
    ├── players/                         # Player scraper
    └── fixtures/                        # Fixture scraper
```

## 🔌 API Endpoints

### Authentication
- `POST /api/users/register` - Register new user
- `POST /api/users/login` - Login user
- `POST /api/users/refresh` - Refresh JWT token

### Users
- `GET /api/users/{id}` - Get user by ID
- `GET /api/users/email/{email}` - Get user by email

### Leagues
- `GET /api/leagues` - Get all leagues
- `GET /api/leagues/{id}` - Get league by ID
- `POST /api/leagues` - Create league (auth required)
- `POST /api/leagues/{leagueId}/join` - Join league (auth required)
- `DELETE /api/leagues/{leagueId}/leave` - Leave league (auth required)
- `GET /api/leagues/{leagueId}/standings` - Get league standings

### Players
- `GET /api/players` - Get all players
- `GET /api/players/{id}` - Get player by ID
- `GET /api/players/team/{teamName}` - Get players by team
- `GET /api/players/position/{position}` - Get players by position

### Squads
- `GET /api/squads/user/{userId}` - Get user's squad
- `POST /api/squads` - Create squad (auth required)
- `PUT /api/squads/{id}` - Update squad (auth required)
- `POST /api/squads/{squadId}/players` - Add player to squad (auth required)
- `DELETE /api/squads/{squadId}/players/{playerId}` - Remove player (auth required)

### Fixtures
- `GET /api/fixtures` - Get all fixtures
- `GET /api/fixtures/{id}` - Get fixture by ID
- `GET /api/fixtures/gameweek/{gameweekNumber}` - Get fixtures by gameweek

### Gameweeks
- `GET /api/gameweeks` - Get all gameweeks
- `GET /api/gameweeks/{id}` - Get gameweek by ID
- `GET /api/gameweeks/current` - Get current gameweek
- `GET /api/gameweeks/{gameweekNumber}/scores` - Get user scores for gameweek

## 🕷️ Web Scraper

The project includes a comprehensive Python web scraper that collects SLIAC soccer data.

### What It Scrapes

1. **Teams** - Conference team information
2. **Players** - Player rosters from each team (200+ players)
3. **Fixtures** - Match schedules and gameweeks
4. **Results** - Match scores and outcomes
5. **Player Statistics** - Goals, assists, cards, minutes played, clean sheets, saves

### Quick Usage

```bash
# Initial setup (start of season)
cd scraper/teams && python sliac_teams_scraper.py
cd ../players && python sliac_players_scraper.py
cd ../fixtures && python 1_setup_fixtures.py

# Weekly updates (during season)
cd scraper/fixtures
python 2_update_results.py        # Update match results
python 3_update_player_stats.py   # Update player stats from PDFs
```

### Features

- ✅ Automatic SQL generation for database import
- ✅ JSON output for debugging and external use
- ✅ PDF parsing for detailed match statistics
- ✅ Error handling and logging
- ✅ Data validation

**Full Documentation**: See [`scraper/README.md`](scraper/README.md)

## ⚽ Scoring Rules

Points are calculated based on SLIAC Fantasy Football rules:

### Goals
- **Forward**: +5 points
- **Midfielder**: +6 points
- **Defender/Goalkeeper**: +8 points

### Other Actions
- **Assist**: +3 points
- **Playing full match (90+ mins)**: +2 points
- **Playing 45+ minutes**: +1 point
- **Yellow Card**: -1 point
- **Red Card**: -3 points

### Defensive
- **Clean Sheet (GK/Defender)**: +4 points
- **Goalkeeper Saves**: +1 point per 3 saves
- **Goals Conceded (GK/Defender)**: -1 point per goal

### Offensive
- **Shots on Goal (Position-Dependent)**:
  - **Defenders**: +1 point per shot on goal
  - **Midfielders**: +2 points per 3 shots on goal
  - **Forwards**: +1 point per 3 shots on goal

### Squad Rules
- Users must have a complete squad to join leagues
- If no changes are made, the squad carries forward to the next gameweek
- Points are automatically calculated after each match

## 🤝 Contributing

### Development Workflow

1. Create a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit
   ```bash
   git add .
   git commit -m "Description of changes"
   ```

3. Push to the branch
   ```bash
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request

### Code Style
- Follow C# naming conventions
- Use async/await for asynchronous operations
- Add XML documentation comments to public methods
- Keep controllers thin - business logic belongs in services

## 📝 License

This project is created for educational purposes as part of CSCI 316 - Professional Software Development at Principia College.

## 👥 Authors

Principia College - Fall 2025

## 🙏 Acknowledgments

- SLIAC Conference for statistical data
- Principia College Computer Science Department
- ASP.NET Core and Dapper communities

## 📞 Support

For issues and questions:
1. Check the [API Documentation](#api-documentation)
2. Review the [existing documentation](Solution1/) in the project
3. Contact the development team

---

**Last Updated**: October 2025  
**Version**: 1.0.0  
**API Version**: v1
