using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesRepManager.API.Data;

namespace SalesRepManager.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SalesRepresentativesController : ControllerBase
    {
        private readonly SalesRepDbContext _context;

        public SalesRepresentativesController(SalesRepDbContext context)
        {
            _context = context;
        }

        // GET: api/SalesRepresentatives
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SalesRepresentative>>> GetSalesRepresentatives()
        {
            return await _context.SalesRepresentatives.ToListAsync();
        }

        // GET: api/SalesRepresentatives/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SalesRepresentative>> GetSalesRepresentative(int id)
        {
            var salesRepresentative = await _context.SalesRepresentatives.FindAsync(id);

            if (salesRepresentative == null)
            {
                return NotFound();
            }

            return salesRepresentative;
        }

        // PUT: api/SalesRepresentatives/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSalesRepresentative(int id, SalesRepresentative salesRepresentative)
        {
            if (id != salesRepresentative.Id)
            {
                return BadRequest();
            }

            _context.Entry(salesRepresentative).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SalesRepresentativeExists(id))
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

        // POST: api/SalesRepresentatives
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<SalesRepresentative>> PostSalesRepresentative(SalesRepresentative salesRepresentative)
        {
            _context.SalesRepresentatives.Add(salesRepresentative);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSalesRepresentative", new { id = salesRepresentative.Id }, salesRepresentative);
        }

        // DELETE: api/SalesRepresentatives/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSalesRep(int id)
        {
            var rep = await _context.SalesRepresentatives.FindAsync(id);
            if (rep == null)
                return NotFound();

            try
            {
                _context.SalesRepresentatives.Remove(rep);
                await _context.SaveChangesAsync();
                return NoContent();
            }
            catch (DbUpdateException ex)
            {
                // Log the exception if needed
                return StatusCode(500, "Deletion failed due to related data.");
            }
        }

        private bool SalesRepresentativeExists(int id)
        {
            return _context.SalesRepresentatives.Any(e => e.Id == id);
        }
    }
}
