
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Models.JwtAuthentication;
using SalesRepManager.API.Models.DTO;
using System.Composition;
using Humanizer;
using Microsoft.Extensions.Options;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly AppDbContext _context;
    private readonly ITokenService _tokenService;
    private readonly JwtOptions _jwtOptions;



    public AuthController(AppDbContext context, ITokenService tokenService, IOptions<JwtOptions> jwtOptions)
    {
        _context = context;
        _tokenService = tokenService;
        _jwtOptions = jwtOptions.Value;
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginDTO model)
    {

        try
        {
            if (!ModelState.IsValid)
            {
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                    Console.WriteLine("Model Error: " + error.ErrorMessage);

                return BadRequest(ModelState);
            }

            if (model == null || string.IsNullOrWhiteSpace(model.Email) || string.IsNullOrWhiteSpace(model.Password))
                return BadRequest("Invalid login request");

            var user = await _context.Users
                .Include(u => u.UserRoles)
                    .ThenInclude(ur => ur.Role)
                .FirstOrDefaultAsync(u => u.Email == model.Email);

            if (user == null || user.PasswordHash != model.Password)
                return Unauthorized("Invalid credentials");

            Console.WriteLine($"LOGIN ATTEMPT: Email={model?.Email}, Password={model?.Password}");

            var roles = user.UserRoles.Select(ur => ur.Role.Name).ToList();
            var accessToken = _tokenService.GenerateAccessToken(user, roles);

            // Check for existing refresh token
            var existingRefreshToken = await _context.RefreshTokens
                .Where(rt => rt.UserId == user.Id && !rt.IsRevoked && rt.ExpiryDate > DateTime.UtcNow)
                .OrderByDescending(rt => rt.ExpiryDate) // in case there are multiple
                .FirstOrDefaultAsync();

            string refreshToken;

            if (existingRefreshToken != null)
            {
                refreshToken = existingRefreshToken.Token;
            }
            else
            {
                refreshToken = _tokenService.GenerateRefreshToken();

                var newTokenEntity = new RefreshToken
                {
                    Token = refreshToken,
                    UserId = user.Id,
                    CreatedAt = DateTime.UtcNow,
                    ExpiryDate = DateTime.UtcNow.AddDays(7),
                    IsRevoked = false
                };

                _context.RefreshTokens.Add(newTokenEntity);
                await _context.SaveChangesAsync();
            }

            return Ok(new AuthResponse
            {
                Token = accessToken,
                RefreshToken = refreshToken,
                Expires = DateTime.UtcNow.AddMinutes(_jwtOptions.AccessTokenExpiryMinutes)
            });
        }
        catch (Exception ex)
        {
            Console.WriteLine("❌ Login failed: " + ex.Message);
            return StatusCode(500, "An internal error occurred: " + ex.Message);
        }
    }


    [HttpPost("refresh")]
    public async Task<IActionResult> Refresh([FromBody] RefreshTokenRequest model)
    {
        var storedToken = await _context.RefreshTokens
            .Include(rt => rt.User)
            .ThenInclude(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
            .FirstOrDefaultAsync(t => t.Token == model.RefreshToken && !t.IsRevoked && t.ExpiryDate > DateTime.UtcNow);

        if (storedToken == null)
            return Unauthorized("Invalid refresh token");

        var roles = storedToken.User.UserRoles.Select(ur => ur.Role.Name).ToList();
        var newAccessToken = _tokenService.GenerateAccessToken(storedToken.User, roles);

        return Ok(new { token = newAccessToken });
    }

    [HttpPost("logout")]
    public async Task<IActionResult> Logout([FromBody] RefreshTokenRequest model)
    {
        var token = await _context.RefreshTokens.FirstOrDefaultAsync(t => t.Token == model.RefreshToken);

        if (token != null)
        {
            token.IsRevoked = true;
            token.RevokedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();
        }

        return Ok();
    }
}
