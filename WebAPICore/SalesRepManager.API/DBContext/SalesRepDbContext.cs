//DbContext is the gateway between your application and your database in Entity Framework Core.
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Data;
using SalesRepManager.API.Entities;

namespace SalesRepManager.API.DBContext
{
    public class SalesRepDbContext : DbContext
    {
        public SalesRepDbContext(DbContextOptions<SalesRepDbContext> options) : base(options) { }

        public DbSet<SalesRepresentative> SalesRepresentatives { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Sale> Sales { get; set; }
        public DbSet<Target> Targets { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Target>()
                .HasOne(t => t.SalesRep)
                .WithMany()
                .HasForeignKey(t => t.SalesRepId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Target>()
                .HasOne(t => t.Product)
                .WithMany()
                .HasForeignKey(t => t.ProductId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
