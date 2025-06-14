
using Xunit;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Models;
using System.Collections.Generic;
using System.Threading.Tasks;
using SalesRepManager.API.Models.DTO;
using SalesRepManager.API.Models.JwtAuthentication;
using System.Runtime.Intrinsics.X86;
using Microsoft.Extensions.Options;
namespace SalesRepManager.Tests.Controllers
{
    public class AuthControllerTests
    {
        private AppDbContext GetInMemoryDbContext()
        {
            //Use EF Core InMemory DB
            var options = new DbContextOptionsBuilder<AppDbContext>()
                .UseInMemoryDatabase(databaseName: System.Guid.NewGuid().ToString())
                .Options;
            return new AppDbContext(options);
        }
        [Fact]
        public async Task Login_ValidUser_ReturnsAccessToken()
        {
            var context = GetInMemoryDbContext();
            var mockOptions = Options.Create(new JwtOptions
            {
                Key = "mock-key",
                Issuer = "mock-issuer",
                Audience = "mock-audience",
                AccessTokenExpiryMinutes = 30
            });
            var user = new User
            {
                Id = 1,
                Email = "admin@test.com",
                PasswordHash = "admin123",
                UserRoles = new List<UserRole>
            {
                new UserRole
                {
                    Role = new Role { Id = 1, Name = "Admin" }
                }
            }
            };

            context.Users.Add(user);
            context.SaveChanges();

            var mockTokenService = new Moq.Mock<ITokenService>();
            mockTokenService.Setup(t => t.GenerateAccessToken(Moq.It.IsAny<User>(), Moq.It.IsAny<IList<string>>()))
                            .Returns("mock-jwt");
            mockTokenService.Setup(t => t.GenerateRefreshToken())
                            .Returns("mock-refresh");

            var controller = new AuthController(context, mockTokenService.Object, mockOptions);
            var loginDto = new LoginDTO { Email = "admin@test.com", Password = "admin123" };

            // Act
            var result = await controller.Login(loginDto) as OkObjectResult;

            Assert.NotNull(result);
            var response = result.Value as AuthResponse;

            Assert.NotNull(response);
            Assert.Equal("mock-jwt", response.Token);
            Assert.Equal("mock-refresh", response.RefreshToken);
        }
        [Fact]
        public async Task Refresh_ValidToken_ReturnsNewAccessToken()
        {
            var context = GetInMemoryDbContext();
            var mockOptions = Options.Create(new JwtOptions
            {
                Key = "mock-key",
                Issuer = "mock-issuer",
                Audience = "mock-audience",
                AccessTokenExpiryMinutes = 30
            });
            var user = new User
            {
                Id = 2,
                Email = "user@test.com",
                PasswordHash = "pass",
                UserRoles = new List<UserRole>
            {
                new UserRole { Role = new Role { Name = "User" } }
            }
            };

            var token = new RefreshToken
            {
                Token = "valid-refresh",
                User = user,
                ExpiryDate = System.DateTime.UtcNow.AddMinutes(10)
            };

            context.Users.Add(user);
            context.RefreshTokens.Add(token);
            context.SaveChanges();

            var mockTokenService = new Moq.Mock<ITokenService>();
            mockTokenService.Setup(t => t.GenerateAccessToken(Moq.It.IsAny<User>(), Moq.It.IsAny<IList<string>>()))
                            .Returns("new-access-token");

            var controller = new AuthController(context, mockTokenService.Object, mockOptions);
            var result = await controller.Refresh(new RefreshTokenRequest { RefreshToken = "valid-refresh" }) as OkObjectResult;

            Assert.NotNull(result);
            Assert.Equal("new-access-token", (string)result.Value.GetType().GetProperty("token").GetValue(result.Value));
        }

        [Fact]
        public async Task Logout_RevokesRefreshToken()
        {
            var context = GetInMemoryDbContext();
            var mockOptions = Options.Create(new JwtOptions
            {
                Key = "mock-key",
                Issuer = "mock-issuer",
                Audience = "mock-audience",
                AccessTokenExpiryMinutes = 30
            });
            var user = new User { Id = 3, Email = "logout@test.com", PasswordHash = "logout" };
            var token = new RefreshToken
            {
                Token = "logout-token",
                User = user,
                ExpiryDate = System.DateTime.UtcNow.AddMinutes(10)
            };

            context.Users.Add(user);
            context.RefreshTokens.Add(token);
            context.SaveChanges();

            var mockTokenService = new Moq.Mock<ITokenService>();
            var controller = new AuthController(context, mockTokenService.Object, mockOptions);
            var result = await controller.Logout(new RefreshTokenRequest { RefreshToken = "logout-token" }) as OkResult;

            Assert.NotNull(result);
            var revokedToken = await context.RefreshTokens.FirstOrDefaultAsync(t => t.Token == "logout-token");
            Assert.True(revokedToken.IsRevoked);
        }

        [Fact]
        public async Task Login_MissingPassword_ReturnsBadRequest()
        {
            var context = GetInMemoryDbContext();
            var mockOptions = Options.Create(new JwtOptions
            {
                Key = "mock-key",
                Issuer = "mock-issuer",
                Audience = "mock-audience",
                AccessTokenExpiryMinutes = 30
            });
            var mockTokenService = new Moq.Mock<ITokenService>();
            var controller = new AuthController(context, mockTokenService.Object, mockOptions);
            controller.ModelState.AddModelError("Password", "Required");

            var result = await controller.Login(new LoginDTO { Email = "test@test.com" });
            var badResult = result as BadRequestObjectResult;

            Assert.NotNull(badResult);
        }
    }
}