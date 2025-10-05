using Microsoft.EntityFrameworkCore;
using Data_Layer;
using Data_Layer.Interfaces;
using Data_Layer.Repositories;
using Service_layer.Interfaces;
using Service_layer.Services;
using Service_layer.Mappings;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new() 
    { 
        Title = "SLIAC Fantasy Football API", 
        Version = "v1",
        Description = "API for managing SLIAC Fantasy Football leagues, squads, and players"
    });
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
builder.Services.AddScoped<IPointsCalculationService, PointsCalculationService>();

// CORS Configuration
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
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "SLIAC Fantasy API v1");
    });
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");
app.UseAuthorization();
app.MapControllers();

// Apply migrations on startup (optional - comment out in production)
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    try
    {
        dbContext.Database.Migrate();
    }
    catch (Exception ex)
    {
        var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "An error occurred while migrating the database.");
    }
}

app.Run();
