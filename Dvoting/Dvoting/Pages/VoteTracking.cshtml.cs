using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Dvoting.Pages
{
    public class VoteTrackingModel : PageModel
    {
        public IActionResult OnGet()
        {
            return Page();
        }
    }
}
