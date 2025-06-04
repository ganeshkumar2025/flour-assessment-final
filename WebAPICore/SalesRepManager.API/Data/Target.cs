namespace SalesRepManager.API.Data
{
    public class Target
    {
        public int Id { get; set; }
        public int SalesRepId { get; set; }
        public SalesRepresentative? SalesRep { get; set; }
        public int ProductId { get; set; }
        public Product? Product { get; set; }
        public DateTime TargetMonth { get; set; }
        public decimal TargetAmount { get; set; }
    }
}
