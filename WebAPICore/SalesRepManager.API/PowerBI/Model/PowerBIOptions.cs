﻿namespace SalesRepManager.API.PowerBI.Model
{
    public class PowerBIOptions
    {
        public string TenantId { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string WorkspaceId { get; set; }
        public string ReportId { get; set; }
    }
}
