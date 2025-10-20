# API Testing Guide

This directory contains unit tests for the SLIAC Fantasy Football API.

## Running Tests

```bash
cd Solution1
dotnet test Api_Srv.Tests/Api_Srv.Tests.csproj
```

## Test Structure

```
Api_Srv.Tests/
├── Controllers/          # Controller tests with mocked services
├── Services/            # Service layer business logic tests  
└── README.md           # This file
```

## Writing New Tests

### Controller Tests
Use Moq to mock service dependencies:

```csharp
[Fact]
public async Task ControllerMethod_ReturnsExpectedResult()
{
    // Arrange
    var mockService = new Mock<IYourService>();
    mockService.Setup(s => s.MethodAsync()).ReturnsAsync(expectedValue);
    var controller = new YourController(mockService.Object);

    // Act
    var result = await controller.YourMethod();

    // Assert
    result.Should().BeOfType<OkObjectResult>();
}
```

### Service Tests  
Test business logic directly:

```csharp
[Fact]
public void ServiceMethod_CalculatesCorrectly()
{
    // Arrange
    var service = new YourService(mockDependency);
    
    // Act
    var result = service.Calculate(input);
    
    // Assert
    result.Should().Be(expectedValue);
}
```

## Test Frameworks

- **xUnit**: Test framework
- **Moq**: Mocking framework  
- **FluentAssertions**: Readable test assertions

## Coverage Goals

- Core business logic (scoring calculations, validations)
- Controller action methods
- Service layer methods
- Edge cases and error scenarios

