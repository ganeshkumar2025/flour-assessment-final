namespace SalesRepManager.API.Models.DTO
{
    public class SalesDto
    {
        public int Id { get; set; }
        public string SalesRepName { get; set; } = "N/A";
        public string ProductName { get; set; } = "N/A";
        public int Quantity { get; set; }
        public DateTime? SaleDate { get; set; }
        public decimal Amount { get; set; }
    }
}
