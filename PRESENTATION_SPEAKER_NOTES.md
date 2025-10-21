# Speaker Notes - SLIAC Fantasy Football API Presentation

## Slide 1: Title (30 seconds)
**What to say:**
"Good [morning/afternoon], everyone. Today I'm going to present my API project - the SLIAC Fantasy Football API. This is a real-world application that I built from scratch to manage fantasy football leagues for the St. Louis Intercollegiate Athletic Conference. Over the next 10 minutes, I'll walk you through the architecture, the SOLID principles I applied, some cool features I implemented, and what I learned along the way."

---

## Slide 2: What Is It? (1 minute)
**What to say:**
"So what exactly is this project? It's a complete REST API that powers a fantasy football platform for SLIAC soccer. Users can create accounts, join leagues, build squads of 15 players, and compete against each other based on real player performance.

The system has five main features:
- First, JWT authentication and authorization for secure user management
- Second, league and squad management with complex business rules
- Third, real-time player statistics pulled from actual SLIAC soccer matches
- Fourth, automated web scrapers that collect data from the SLIAC website
- And fifth, a fantasy points calculation system based on goals, assists, clean sheets, and more.

The tech stack is ASP.NET Core 8 for the API, Dapper as a micro-ORM with SQL Server for the database, and Python for the web scrapers. In total, there are over 30 API endpoints handling everything from user registration to squad creation."

---

## Slide 3: Architecture (1.5 minutes)
**What to say:**
"I built this using a 3-layer architecture pattern, which is a clean architecture approach.

At the top, you have the API layer - this is where the controllers live. They handle HTTP requests and responses but don't contain business logic.

In the middle is the Service layer - this is where all the business logic lives. Things like squad validation, points calculation, and data transformation with DTOs happen here.

At the bottom is the Data layer - this contains repositories that use Dapper to interact with SQL Server. All database queries are encapsulated here.

Why did I choose this architecture? Four main reasons:
- Separation of concerns - each layer has one job
- Testability - I can mock each layer independently for unit tests
- Maintainability - if I need to change a business rule, I know it's in the service layer
- Scalability - I could swap Dapper for Entity Framework, or SQL Server for PostgreSQL, and only the data layer would need to change.

The project is organized into four main folders: Api_Srv for controllers, Service_layer for business logic and DTOs, Data_Layer for repositories, and Database1 for the SQL schema and migrations."

---

## Slide 4: SOLID - SRP & DIP (1.5 minutes)
**What to say:**
"Let me show you how I applied SOLID principles. I'll start with Single Responsibility and Dependency Inversion.

For Single Responsibility Principle, look at this TokenService class. It has exactly one job: manage JWT tokens. It generates access tokens, generates refresh tokens, and validates expired tokens. That's it. It doesn't handle user management, password hashing, or database persistence. Each responsibility is separated into its own class. This makes the code easier to understand and maintain.

For Dependency Inversion Principle, look at PlayerService. Notice that it depends on IPlayerRepository - that's an interface, not a concrete class. It also depends on IMapper, another interface. These dependencies are injected through the constructor.

Why is this important? Because now I can easily test PlayerService by passing in mock implementations of IPlayerRepository. I don't need a real database connection to test my business logic. It also means I could swap out the repository implementation without changing PlayerService at all. The high-level module depends on abstractions, not concrete implementations - that's the Dependency Inversion Principle in action."

---

## Slide 5: SOLID - OCP & ISP (1.5 minutes)
**What to say:**
"Now let's look at the Open/Closed Principle and Interface Segregation Principle.

For Open/Closed, I used the GenericRepository pattern. I have a base GenericRepository class that implements common CRUD operations like GetByIdAsync. This base class is closed for modification - I don't want to change it every time I need new functionality.

But it's open for extension. PlayerRepository inherits from GenericRepository and overrides GetByIdAsync to include a JOIN to the ConferenceTeam table. It also adds new methods like GetByTeamAsync without touching the base class. Other repositories like UserRepository and SquadRepository do the same thing. This follows the Open/Closed Principle perfectly.

For Interface Segregation Principle, I use focused DTOs. Look at LoginDto - it only has Email and Password. RegisterUserDto has Email, Username, Password, and School. UpdateUserDto only has the fields you can update.

Why separate these? Because the login endpoint doesn't need to know about registration-specific data. Each DTO is tailored to its specific use case. Clients only depend on what they actually need, not a bloated interface with everything. This makes the code cleaner and prevents accidental data exposure."

---

## Slide 6: Cool Feature #1 - PDF Scraping (1.5 minutes)
**What to say:**
"Alright, let me show you some cool features. The first one is automated PDF scraping for player statistics.

Here's the challenge: SLIAC publishes match statistics as PDF box scores on their website. I need to extract individual player stats like goals, assists, minutes played, yellow cards, red cards, and goalkeeper saves. Manually entering this data for 200+ players every week would be insane.

So I built a Python scraper that automates the entire process. It's a two-step process: First, it scrapes the box score webpage to find the document viewer link. Second, it scrapes that viewer page to extract the actual PDF URL from AWS S3. Then it downloads the PDF, uses a library called pdfplumber to parse the tables, extracts all the player statistics, and generates SQL INSERT statements ready to execute.

Why is this cool? Because it runs completely automatically. During the season, I just run a script once a week and boom - all the latest stats are ready to import. It handles complex PDF formats, different table structures from different teams, and it even saves the PDFs for an audit trail.

The real impact? This saves hours of manual data entry every single week. And it's 100% accurate because it's pulling directly from official SLIAC sources.

You can see the code in scraper/fixtures/3_update_player_stats.py - it's about 800 lines of PDF parsing logic."

---

## Slide 7: Cool Feature #2 - Squad Validation (1 minute)
**What to say:**
"The second cool feature is complex squad validation with real fantasy football rules.

In SLIAC Fantasy Football, squads have strict constraints: 15 total players, with exactly 2 goalkeepers, 5 defenders, 5 midfielders, and 3 forwards. You can't have more than 3 players from the same team. And there's a budget cap of 100.0 - each player has a cost, and your total can't exceed 100.

But it gets more complex. When you select your starting 11, you must have a valid formation - at least 3 defenders, 2 midfielders, and 1 forward. Your captain and vice-captain must be starters, and they can't be the same player. And once a gameweek starts, you can't change your squad.

All of this is enforced in SquadService. When you try to create or update a squad, it validates every single rule. If any rule is broken, it throws a descriptive error telling you exactly what's wrong.

This is cool because it prevents invalid data from ever entering the database. Business rules are enforced at the service layer, not in the database or the UI. This is proper layered architecture - the service layer is the gatekeeper for business logic."

---

## Slide 8: Cool Feature #3 - JWT Auth (1 minute)
**What to say:**
"The third cool feature is the JWT authentication system with refresh tokens.

When you register, your password is hashed using HMACSHA512 with a random salt. We never store passwords in plain text - ever.

When you login, the API returns two tokens: an access token that expires in 30 minutes, and a refresh token that expires in 7 days. The access token is what you send with every API request to prove who you are.

Here's the cool part: when your access token expires, you don't have to login again. Your client sends the refresh token, and the API issues a new access token. Only when the refresh token expires do you have to actually login again.

There's also security features like account lockout. If you fail to login 5 times, your account is locked for 15 minutes to prevent brute force attacks.

Why is this cool? Because it's stateless and scalable. The server doesn't maintain sessions - everything needed is in the JWT token. This makes it perfect for mobile apps and distributed systems. And the claims-based authorization means I can extract the user ID directly from the token without a database lookup on every request.

All of this is implemented in UserService and TokenService - about 500 lines of authentication logic."

---

## Slide 9: Design Choices (1 minute)
**What to say:**
"Let me talk about some design choices I made and the trade-offs.

First, I chose Dapper over Entity Framework. Why? Dapper is lightweight and gives me full control over SQL queries. The performance is better because there's less abstraction. The trade-off is that I have to write SQL queries manually, which is more code.

Second, JWT over session cookies. JWT is stateless, scales horizontally, and works great with mobile apps. The trade-off is token management complexity - handling refresh tokens, expiration, and secure storage.

Third, 3-layer architecture. It gives clear separation of concerns and makes testing easy. The trade-off is more files and some boilerplate code.

Fourth, Python for scrapers. Python has amazing libraries like BeautifulSoup and pdfplumber. The trade-off is maintaining a separate tech stack alongside C#.

Fifth, SQL Server over NoSQL. My data is highly relational - users have squads, squads have players, players belong to teams. SQL Server gives me ACID compliance and enforces referential integrity. The trade-off is less flexibility when I need to change the schema.

The best choice I made was the 3-layer architecture with dependency injection. It made testing so much easier and the code is very organized.

The questionable choice was hardcoding the scoring rules in the PointsCalculationService. This violates the Open/Closed Principle because if the rules change, I have to modify the service and recompile."

---

## Slide 10: Lessons Learned (1.5 minutes)
**What to say:**
"Let me share what I learned from this project.

What went well? Three big things:

First, SOLID principles are genuinely powerful. Because I used dependency injection everywhere, unit testing became trivial. I could mock out repositories and test services in isolation. The interface-based design made this possible.

Second, separation of concerns really pays off. I could develop the API while the scraper was being built independently. When bugs appeared, I knew exactly which layer they were in. Controller bug? Check Api_Srv. Business logic bug? Check Service_layer. Database query bug? Check Data_Layer.

Third, DTOs prevent over-exposure of data. I never accidentally sent password hashes to clients because UserDto doesn't have those fields. Different DTOs for different operations meant I only sent what was needed.

What was challenging?

PDF parsing was brutal. Different teams use different PDF formats. Tables are structured inconsistently. I had to build multiple parsing strategies with fallbacks to handle edge cases.

Dapper had a learning curve. I'm used to Entity Framework where you just call Include() and relationships load automatically. With Dapper, I had to manually write JOIN queries. I solved this by creating a GenericRepository pattern, but it took time.

Authentication complexity was surprising. Refresh token rotation, account lockout timing, extracting claims from JWT in controllers - there were a lot of moving parts. I had to read a lot of documentation and test thoroughly."

---

## Slide 11: What I'd Do Differently (1 minute)
**What to say:**
"If I could start over, here's what I'd do differently:

First, I'd extract scoring rules to a configuration interface. Right now they're hardcoded constants in PointsCalculationService. If I created an IPointsRulesConfiguration interface, I could change the rules without recompiling. Maybe load them from appsettings.json or even from the database. This would properly follow the Open/Closed Principle.

Second, I'd split UserRepository. Right now, IUserRepository has 12 methods - it's bloated. Some methods are for lookups, some for security operations, some for token management. I should split this into three focused interfaces: IUserLookupRepository, IUserSecurityRepository, and IUserTokenRepository. This would better follow the Interface Segregation Principle.

Third, I'd add integration tests earlier in the project. I started with basic unit tests, which is good, but I should have added API integration tests from day one. Testing entire request/response flows would have caught authorization bugs sooner.

Fourth, I'd use background jobs for scraping. Right now I manually run Python scripts. It would be better to use a job scheduler like Hangfire or Quartz.NET to run the scrapers automatically on a schedule. That's more production-ready."

---

## Slide 12: Demo & Q&A (30 seconds)
**What to say:**
"If we have time, I can show you a quick demo of the API. I have Swagger UI running at localhost which provides interactive documentation for all 30+ endpoints.

You can try registering a new user, logging in to get a JWT token, then using that token to create a squad or join a league. All the authentication and authorization is enforced automatically.

All of the documentation is in the repo - there's a comprehensive README with setup instructions, a JWT authentication guide explaining the security implementation, and detailed scraper documentation explaining how the data collection works.

I'll stop there and open it up for questions. What would you like to know?"

---

## Potential Q&A Preparation

### Q: How did you test the authentication?
**A:** "I used Swagger UI's built-in authorization feature. I'd register a user, login to get the JWT token, then click the 'Authorize' button in Swagger and paste in the token. After that, all protected endpoints work. I also wrote unit tests for TokenService and UserService using Moq to mock the dependencies."

### Q: What happens if the web scraper fails?
**A:** "The scraper has built-in error handling. If it fails to download a PDF or parse a table, it logs the error and continues with the next fixture. It generates SQL for whatever it successfully scraped. I can review the logs and manually fix any failures. I also keep all the downloaded PDFs so I can debug parsing issues."

### Q: How do you handle database migrations?
**A:** "I use SQL scripts in the Database1 project. Each schema change is a new .sql file with a descriptive name like AddAuthenticationFields.sql or FixPlayersNameColumn.sql. They're applied manually in order. For a production system, I'd use a proper migration tool like Flyway or DbUp."

### Q: Why Dapper instead of Entity Framework?
**A:** "Performance and control. Dapper is just a micro-ORM that maps SQL results to objects. It doesn't have change tracking overhead or complex query generation. For read-heavy operations like fantasy football stats, the performance gain is significant. Plus I can write exactly the SQL I want, including complex JOINs and CTEs."

### Q: Is this production-ready?
**A:** "Almost. It has authentication, authorization, input validation, and proper error handling. What's missing for production: HTTPS enforcement, rate limiting, comprehensive logging (like Serilog), environment-based configuration, proper secret management (Azure Key Vault), and a CD/CI pipeline. But the core architecture is solid."

### Q: How long did this take to build?
**A:** "About [X weeks] total. The first week was database design and repository setup. Second week was the API endpoints and services. Third week was authentication and authorization. Fourth week was the web scrapers. The last week was testing, documentation, and bug fixes."
