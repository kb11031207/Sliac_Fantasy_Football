using Xunit;
using FluentAssertions;
using Moq;
using Service_layer.Interfaces;
using Service_layer.DTOs;

namespace Api_Srv.Tests
{
    /// <summary>
    /// Basic unit tests demonstrating test setup and structure
    /// These tests show how to use xUnit, Moq, and FluentAssertions
    /// </summary>
    public class BasicTests
    {
        [Fact]
        public void SimpleAssertion_Works()
        {
            // Arrange
            var expected = 42;
            
            // Act
            var actual = 40 + 2;
            
            // Assert
            actual.Should().Be(expected);
        }

        [Theory]
        [InlineData(1, 1, 2)]
        [InlineData(2, 3, 5)]
        [InlineData(10, 15, 25)]
        public void Addition_CalculatesCorrectly(int a, int b, int expected)
        {
            // Act
            var result = a + b;
            
            // Assert
            result.Should().Be(expected);
        }

        [Fact]
        public async Task MockExample_ReturnsExpectedValue()
        {
            // Arrange
            var mockService = new Mock<IUserService>();
            var expectedUser = new UserDto 
            { 
                Id = 1, 
                Username = "testuser", 
                Email = "test@example.com" 
            };
            
            mockService.Setup(s => s.GetUserByIdAsync(1))
                .ReturnsAsync(expectedUser);
            
            // Act
            var result = await mockService.Object.GetUserByIdAsync(1);
            
            // Assert
            result.Should().NotBeNull();
            result.Username.Should().Be("testuser");
            result.Email.Should().Be("test@example.com");
        }

        [Fact]
        public void StringOperations_Work()
        {
            // Arrange
            var input = "  hello world  ";
            
            // Act
            var result = input.Trim().ToUpper();
            
            // Assert
            result.Should().Be("HELLO WORLD");
            result.Should().StartWith("HELLO");
            result.Should().EndWith("WORLD");
            result.Should().Contain("HELLO");
        }

        [Fact]
        public void ListOperations_Work()
        {
            // Arrange
            var list = new List<int> { 1, 2, 3, 4, 5 };
            
            // Act & Assert
            list.Should().HaveCount(5);
            list.Should().Contain(3);
            list.Should().NotContain(10);
            list.Should().BeInAscendingOrder();
        }

        [Fact]
        public void NullCheck_Works()
        {
            // Arrange
            string? nullString = null;
            string nonNullString = "test";
            
            // Assert
            nullString.Should().BeNull();
            nonNullString.Should().NotBeNull();
        }

        [Fact]
        public void ExceptionHandling_Works()
        {
            // Arrange
            Action action = () => throw new ArgumentException("Test exception");
            
            // Act & Assert
            action.Should().Throw<ArgumentException>()
                .WithMessage("Test exception");
        }
    }
}

