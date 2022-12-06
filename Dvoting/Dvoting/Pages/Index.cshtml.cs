using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Nethereum.Web3;
using Newtonsoft.Json;
using System.Numerics;
using System.Threading.Tasks;
using Nethereum.Contracts;
using Nethereum.Hex.HexTypes;
using System.IO;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Dvoting.Pages
{
    [BindProperties]
    public class IndexModel : PageModel
    {


        public IndexModel()
        {  
        }

        public  IActionResult OnGet(int s=0)
        {
            if (s == 1)
            {
                TempData["success"] = "1";
            }else
            if (s == 2)
            {
                TempData["success"] = "2";
            }

            return Page();
        }

       
        


    }
}