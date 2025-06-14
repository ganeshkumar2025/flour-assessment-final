namespace SalesRepManager.API.Data
{
    public class SalesRepresentative
    {
        public int Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Region { get; set; }
        public DateTime HireDate { get; set; }
        public string? Status { get; set; }
    }
}
