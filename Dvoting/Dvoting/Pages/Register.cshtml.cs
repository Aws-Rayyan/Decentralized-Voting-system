using Dvoting.Models;
using Dvoting.Pages.Shared;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Nethereum.Contracts;
using Nethereum.Hex.HexTypes;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using System.Data;
using System.Data.SqlClient;
using System.Numerics;


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

            try
            {

                string connectionstring = _configuration.GetConnectionString("DefaultConnection");

                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    await connection.OpenAsync();
                    string sql = "SP_User_Validate";
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

                        await cmd.ExecuteNonQueryAsync();

                        int Status = Convert.ToInt32(cmd.Parameters["@Status"].Value);

                        if (Status != 1)
                        {
                            if (Status == 2)
                            {
                                ModelState.AddModelError("", "User Is Already Registered");
                            }
                            else if (Status == 4)
                            {
                                ModelState.AddModelError("", "You Are Not Allowed To Vote, Please Contact Us For More Details");
                            }
                            else if (Status == 5)
                            {
                                ModelState.AddModelError("", "A User Has Already Registered With The Same Ethereum Account");
                            }
                            else
                            {
                                ModelState.AddModelError("", "Wrong Information Entered");
                            }

                            return Page();

                        }

                        string res = await GivePermissionBlockChain();

                        if (res == "fail")
                        {
                            ModelState.AddModelError("", "Voting Is Closed");
                            return Page();
                        }

                        return RedirectToPage("./Index", new { s = 1 });


                    }
                }


            }

            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return Page();

        }



        private async Task<string> GivePermissionBlockChain()
        {
            var adminPK = _configuration.GetValue<string>("AdminPK");

            var adminAccount = new Account(adminPK);
            Web3 web3 = new Web3(url: ContractData.URL, account: adminAccount);

            Contract dVotingContract = web3.Eth.GetContract(ContractData.ABI.Replace("\n", "").Replace("\r", "").Replace(" ", ""), ContractData.ContractAddress);

            web3.TransactionManager.UseLegacyAsDefault = true;
            try
            {
                HexBigInteger gas = new HexBigInteger(new BigInteger(54000));
                HexBigInteger value = new HexBigInteger(new BigInteger(0));

                Task<string> permitToVote = dVotingContract.GetFunction("permitToVote").SendTransactionAsync(
                  from: adminAccount.Address,
                  gas: gas,
                  value: value,
                  NewUser.PublicAddress);
                permitToVote.Wait();
                Console.WriteLine("permitted ");
                return "success";
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e.Message);

                await ReveretRegisteration();
                return "fail";
            }


        }

        private async Task ReveretRegisteration()
        {

            string connectionstring = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                await connection.OpenAsync();
                string sql = "SP_Revert_Registeration";
                using (SqlCommand cmd = new SqlCommand(sql, connection))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@publicKey", NewUser.PublicAddress));
                    await cmd.ExecuteNonQueryAsync();

                }
            }
        }

    }
}
