using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Controllers;
using SalesRepManager.API.Data;
using SalesRepManager.API.DBContext;
using SalesRepManager.API.Entities;

namespace SalesRepManager.Tests
{
    public class SalesRepManagerTests
    {
        private DbContextOptions<SalesRepDbContext> GetInMemoryOptions(string dbName) =>
            new DbContextOptionsBuilder<SalesRepDbContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;

        [Fact]
        public async Task GetSalesRepresentative_ReturnsNotFound_WhenNotExists()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("SalesRepTest1"));
            var controller = new SalesRepresentativesController(context);
            var result = await controller.GetSalesRepresentative(999);
            result.Result.Should().BeOfType<NotFoundResult>();
        }

        [Fact]
        public async Task GetProduct_ReturnsProduct_WhenExists()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("ProductTest1"));
            var product = new Product { Name = "Test", Category = "Demo", Price = 100, IsActive = true };
            context.Products.Add(product); context.SaveChanges();
            var controller = new ProductsController(context);
            var result = await controller.GetProduct(product.Id);
            result.Value.Should().BeEquivalentTo(product);
        }

        [Fact]
        public async Task PostSale_ShouldReturnCreated_WhenDataIsValid()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("SalesTest1"));
            var rep = new SalesRepresentative { FirstName = "A", LastName = "B", Email = "a@b.com", PhoneNumber = "123", Region = "East", HireDate = System.DateTime.UtcNow, Status = "Active" };
            var product = new Product { Name = "P", Category = "C", Price = 99, IsActive = true };
            context.SalesRepresentatives.Add(rep); context.Products.Add(product); context.SaveChanges();

            var controller = new SalesController(context);
            var sale = new Sale
            {
                SalesRepId = rep.Id,
                ProductId = product.Id,
                Quantity = 2,
                SaleDate = System.DateTime.UtcNow,
                Amount = 198
            };

            var result = await controller.PostSale(sale);
            result.Result.Should().BeOfType<CreatedAtActionResult>();
        }

        [Fact]
        public async Task GetTarget_ReturnsNotFound_WhenIdInvalid()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("TargetTest1"));
            var controller = new TargetsController(context);
            var result = await controller.GetTarget(123);
            result.Result.Should().BeOfType<NotFoundResult>();
        }

        [Fact]
        public async Task PutProduct_ShouldUpdate_WhenProductExists()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("PutProductTest"));
            var product = new Product { Name = "Old", Category = "Cat", Price = 50, IsActive = true };
            context.Products.Add(product);
            context.SaveChanges();

            var controller = new ProductsController(context);
            product.Name = "Updated";
            var result = await controller.PutProduct(product.Id, product);
            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task DeleteSalesRep_ShouldRemove_WhenExists()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("DeleteSalesRepTest"));
            var rep = new SalesRepresentative { FirstName = "Del", LastName = "Test", Email = "del@test.com", PhoneNumber = "999", Region = "West", HireDate = System.DateTime.UtcNow, Status = "Inactive" };
            context.SalesRepresentatives.Add(rep);
            context.SaveChanges();

            var controller = new SalesRepresentativesController(context);
            var result = await controller.DeleteSalesRep(rep.Id);
            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task PostSale_ShouldReturnBadRequest_WhenFKsInvalid()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("BadSaleFKTest"));
            var controller = new SalesController(context);

            var sale = new Sale
            {
                SalesRepId = 9999, // invalid FK
                ProductId = 8888, // invalid FK
                Quantity = 1,
                SaleDate = System.DateTime.UtcNow,
                Amount = 100
            };

            var result = await controller.PostSale(sale);
            result.Result.Should().BeOfType<BadRequestResult>();
        }

        [Fact]
        public async Task PostProduct_ShouldReturnBadRequest_WhenNullPayload()
        {
            var context = new SalesRepDbContext(GetInMemoryOptions("NullProductPostTest"));
            var controller = new ProductsController(context);

            var result = await controller.PostProduct(null);
            result.Result.Should().BeOfType<BadRequestResult>();
        }

    }
}