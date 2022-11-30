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
using System.Reflection.Metadata;
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
                        cmd.Parameters.Add(new SqlParameter("@PublicKey", NewUser.PublicAddress));

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


                        OnGetGivePermissionBlockChain();


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


         
        public async Task OnGetGivePermissionBlockChain()
        {
            var adminPK = _configuration.GetValue<string>("AdminPK");

            var adminAccount = new Account(adminPK);

            //Console.WriteLine("private key is " + account.PrivateKey);
            //Console.WriteLine("public key is " + account.PublicKey);            
            //Console.WriteLine("address  is " + account.Address);

            Web3 web3 = new Web3(url:ContractData.URL,account:adminAccount) ;
            // Console.WriteLine(ContractData.ABI );
           
            Contract dVotingContract = web3.Eth.GetContract(ContractData.ABI.Replace("\n", "").Replace("\r", "").Replace(" ", ""), ContractData.ContractAddress);       
            
            web3.TransactionManager.UseLegacyAsDefault = true;
            try
            {
                HexBigInteger gas = new HexBigInteger(new BigInteger(400000));
                HexBigInteger value = new HexBigInteger(new BigInteger(0));      

                Task<string> permitToVote = dVotingContract.GetFunction("permitToVote").SendTransactionAsync(adminAccount.Address, gas, value, NewUser.PublicAddress); 
                permitToVote.Wait();
                Console.WriteLine("permitted ");
            }catch(Exception e){
                Console.WriteLine("Error: {0}", e.Message);
            }


        }



        public void OnGet()
        {
        }
    }
}
