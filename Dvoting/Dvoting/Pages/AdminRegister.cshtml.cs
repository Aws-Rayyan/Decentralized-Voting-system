using Dvoting.Models;
using Dvoting.Pages.Shared;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Nethereum.Contracts;
using Nethereum.Hex.HexTypes;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using Newtonsoft.Json.Linq;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Numerics;


namespace Dvoting.Pages
{
    [BindProperties]
    public class AdminRegsiterModel : PageModel
    {

        readonly IConfiguration _configuration;

        public AdminRegsiterModel(IConfiguration Configuration)
        {
            _configuration = Configuration;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        public Register NewUser { get; set; } = new Register();


        public async Task<IActionResult> OnPost()
        {

            if (!ModelState.IsValid)
            {
                return Page();
            }
            if(NewUser.Password != NewUser.ConfirmPassword)
            {
                ModelState.AddModelError("", "Passwords Doesn't Match");
                return Page();
            }

            try
            {

                string connectionstring = _configuration.GetConnectionString("DefaultConnection");

                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    await connection.OpenAsync();
                    string sql = "SP_Register_User";
                    using (SqlCommand cmd = new SqlCommand(sql, connection))
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@Fname", NewUser.Fname));
                        cmd.Parameters.Add(new SqlParameter("@Lname", NewUser.Lname));
                        cmd.Parameters.Add(new SqlParameter("@NationalID", NewUser.NationalID));
                        cmd.Parameters.Add(new SqlParameter("@DOB", NewUser.DOB.Date));
                        cmd.Parameters.Add(new SqlParameter("@User_password", NewUser.Password));
                        cmd.Parameters.Add(new SqlParameter("@Status", SqlDbType.Int, 20, ParameterDirection.Output, false, 0, 10, "Status", DataRowVersion.Default, null));
                 
                        await cmd.ExecuteNonQueryAsync();

                        int Status = Convert.ToInt32(cmd.Parameters["@Status"].Value);

                        if (Status != 1)
                        {
                            if (Status == 2)
                            {
                                ModelState.AddModelError("", "User Is Already Registered");
                            }
                            else
                            {
                                ModelState.AddModelError("", "Wrong Information Entered");
                            }
                            
                            return Page();

                        }

                        return RedirectToPage("./Index", new { s = 2 });


                    }
                }


            }

            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return Page();

        }



    }
}
