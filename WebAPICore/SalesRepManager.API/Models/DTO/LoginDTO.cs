using System.ComponentModel.DataAnnotations;

namespace SalesRepManager.API.Models.DTO
{
    public class LoginDTO
    {
        [Required]
        [EmailAddress]
        public string? Email { get; set; }

        [Required]
        [MinLength(6)]
        public string? Password { get; set; }

        public string? TwoFactorCode { get; set; } // Optional, for future 2FA setup

        public bool RememberMe { get; set; } = false; // Optional, affects token expiry

        public string? DeviceId { get; set; } // Optional, useful for refresh token binding
    }
}