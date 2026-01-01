# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj files and restore dependencies (this layer is cached if csproj files don't change)
COPY ["Api_Srv/Api_Srv.csproj", "Api_Srv/"]
COPY ["Data_Layer/Data_Layer.csproj", "Data_Layer/"]
COPY ["Service_layer/Service_layer.csproj", "Service_layer/"]
RUN dotnet restore "Api_Srv/Api_Srv.csproj"

# Copy everything else and build
COPY . .
WORKDIR "/src/Api_Srv"
RUN dotnet build "Api_Srv.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "Api_Srv.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Copy published app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "Api_Srv.dll"]

