using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Dvoting.Pages
{
    public class VoterModel : PageModel
    {
        public IActionResult OnGet()
        {
            return Page();
        }
    }
}
