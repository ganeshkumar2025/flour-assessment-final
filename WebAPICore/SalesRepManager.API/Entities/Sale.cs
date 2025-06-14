using SalesRepManager.API.Entities;
using SalesRepManager.API.Helper;
using System.Text.Json.Serialization;

namespace SalesRepManager.API.Data
{
    public class Sale
    {
        public int Id { get; set; }
        public int SalesRepId { get; set; }
        public SalesRepresentative? SalesRep { get; set; }

        public int ProductId { get; set; }
        public Product? Product { get; set; }

        public int Quantity { get; set; }
        [JsonConverter(typeof(JsonDateOnlyConverter))]
        public DateTime SaleDate { get; set; }
        public decimal Amount { get; set; }
    }
}
