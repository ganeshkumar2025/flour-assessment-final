using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Data;
using SalesRepManager.API.Models.DTO;

namespace SalesRepManager.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SalesController : ControllerBase
    {
        private readonly SalesRepDbContext _context;

        public SalesController(SalesRepDbContext context)
        {
            _context = context;
        }

        // GET: api/Sales
        [HttpGet]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SalesDto>>> GetSales()
        {
            var sales = await _context.Sales
        .Include(s => s.SalesRep)
        .Include(s => s.Product)
        .Select(s => new SalesDto
        {
            Id = s.Id,
            SalesRepName = s.SalesRep != null
                ? $"{s.SalesRep.FirstName ?? ""} {s.SalesRep.LastName ?? ""}".Trim()
                : "N/A",
            ProductName = s.Product != null
                ? s.Product.Name ?? "N/A"
                : "N/A",
            Quantity = s.Quantity,
            SaleDate = s.SaleDate,
            Amount = s.Amount
        })
        .ToListAsync();

        return Ok(sales);
        }

        // GET: api/Sales/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Sale>> GetSale(int id)
        {
            var sale = await _context.Sales.FindAsync(id);

            if (sale == null)
            {
                return NotFound();
            }

            return sale;
        }

        // PUT: api/Sales/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSale(int id, Sale sale)
        {
            if (id != sale.Id)
            {
                return BadRequest();
            }

            _context.Entry(sale).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SaleExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Sales
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Sale>> PostSale(Sale sale)
        {
            _context.Sales.Add(sale);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSale", new { id = sale.Id }, sale);
        }

        // DELETE: api/Sales/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSale(int id)
        {
            var sale = await _context.Sales.FindAsync(id);
            if (sale == null)
            {
                return NotFound();
            }

            _context.Sales.Remove(sale);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SaleExists(int id)
        {
            return _context.Sales.Any(e => e.Id == id);
        }
    }
}
