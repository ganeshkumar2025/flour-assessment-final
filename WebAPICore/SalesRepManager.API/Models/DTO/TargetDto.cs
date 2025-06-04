namespace SalesRepManager.API.Models.DTO
{
    public class TargetDto
    {
        public int Id { get; set; }
        public string SalesRepName { get; set; } = string.Empty;
        public string ProductName { get; set; } = string.Empty;
        public DateTime TargetMonth { get; set; }
        public decimal TargetAmount { get; set; }
    }
}
