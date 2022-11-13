using Dvoting.Models;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data;
using System.Data.SqlClient;
using static Org.BouncyCastle.Math.EC.ECCurve;

namespace Dvoting.Pages
{
    [BindProperties]
    public class RegsiterModel : PageModel
    {

        readonly IConfiguration _configuration;

        public RegsiterModel(IConfiguration Configuration)
        {
            _configuration = Configuration;
        }

        public Register NewUser { get; set; } = new Register();


        public async Task<IActionResult> OnPostRegisterUserAsync()
        {

            if (!ModelState.IsValid)
            {
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
                        cmd.Parameters.Add(new SqlParameter("@PublicKey", NewUser.PublicKey));

                        cmd.Parameters.Add(new SqlParameter("@Status", SqlDbType.Int, 20, ParameterDirection.Output, false, 0, 10, "Status", DataRowVersion.Default, null));

                       // cmd.UpdatedRowSource = UpdateRowSource.OutputParameters;
                        await cmd.ExecuteNonQueryAsync();

                        int Status = Convert.ToInt32(cmd.Parameters["@Status"].Value);

                        if (Status != 1)
                        {
                            if(Status == 2) { 
                            ModelState.AddModelError("", "User Is Already Registered");
                            }
                            else if(Status == 3)
                            {
                                ModelState.AddModelError("", "Wrong Information Entered");
                            }
                            //TODO: Add other cases
                            return Page();

                        }
    
                        HttpContext.Session.SetString("User_Name", NewUser.Fname+" "+NewUser.Lname);
                        HttpContext.Session.SetString("NationalID", NewUser.NationalID);


                        var adminPK = _configuration.GetValue<string>("AdminPK");
                       // Console.WriteLine(adminPK);





                        return RedirectToPage("Voter");


                    }
                }


            }

            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return Page();
        }




        public void OnGet()
        {
        }
    }
}
