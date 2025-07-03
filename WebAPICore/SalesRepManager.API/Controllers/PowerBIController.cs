using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Microsoft.PowerBI.Api;
using Microsoft.PowerBI.Api.Models;
using Microsoft.Rest;
using SalesRepManager.API.PowerBI.Model;
using System;
using System.Threading.Tasks;

namespace SalesRepManager.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PowerBIController : ControllerBase
    {
        private readonly PowerBIOptions _options;

        public PowerBIController(IOptions<PowerBIOptions> options)
        {
            _options = options.Value;
        }

        [HttpGet("embedConfig")]
        public async Task<IActionResult> GetEmbedConfig()
        {
            try
            {
                // Step 1: Authenticate with Azure AD
                var authorityUrl = $"https://login.microsoftonline.com/{_options.TenantId}";
                var resourceUrl = "https://analysis.windows.net/powerbi/api";
                var authContext = new AuthenticationContext(authorityUrl);

                var credentials = new ClientCredential(_options.ClientId, _options.ClientSecret);
                var authResult = await authContext.AcquireTokenAsync(resourceUrl, credentials);

                if (authResult == null)
                    return StatusCode(500, "Failed to authenticate with Azure AD");

                // Step 2: Connect to Power BI Service
                var tokenCredentials = new TokenCredentials(authResult.AccessToken, "Bearer");
                var pbiClient = new PowerBIClient(new Uri("https://api.powerbi.com/"), tokenCredentials);

                var report = await pbiClient.Reports.GetReportInGroupAsync(
                    Guid.Parse(_options.WorkspaceId), Guid.Parse(_options.ReportId));

                // Step 3: Generate Embed Token
                var tokenRequest = new GenerateTokenRequest(accessLevel: "view");
                var tokenResponse = await pbiClient.Reports.GenerateTokenAsync(
                    Guid.Parse(_options.WorkspaceId), Guid.Parse(_options.ReportId), tokenRequest);

                return Ok(new
                {
                    embedUrl = report.EmbedUrl,
                    reportId = report.Id,
                    accessToken = tokenResponse.Token
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Power BI embed failed: {ex.Message}");
            }
        }
    }
}
