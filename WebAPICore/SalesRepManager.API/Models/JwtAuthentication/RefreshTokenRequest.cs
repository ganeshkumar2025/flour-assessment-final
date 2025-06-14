namespace SalesRepManager.API.Models.JwtAuthentication
{
    public class RefreshTokenRequest
    {
        
            public int Id { get; set; }
            public string? RefreshToken { get; set; }
            public DateTime CreatedAt { get; set; }         // ✅ Always set this
            public DateTime ExpiryDate { get; set; }
            public bool IsRevoked { get; set; }
            public DateTime? RevokedAt { get; set; }        // ✅ Nullable
            public int UserId { get; set; }
            public User User { get; set; }
        
    }
}
