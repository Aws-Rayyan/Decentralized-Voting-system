using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace Dvoting.Models
{
    public class Register
    {
        [Required]
        public string? NationalID { get; set; }
        [Required]
        public string? Fname { get; set; }

        [Required]
        public string? Lname { get; set; }

        [Required]
        public DateTime DOB { get; set; }

        [Required] //TODO: re enable
        //[RegularExpression("^.*(?=.{8,})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#$%^&+=_~`-]).*$",ErrorMessage = "Password Should Meet The Following:\n" +
        //    "1- Has a lenght of 8 \n" +
        //    "2- At least one lower case letter \n" +
        //    "3- At least one upper case letter \n" +
        //    "4- At least one special character !*@#$%^&+=_~`- \n" +
        //    "5- At least one number")]
        [DataType(DataType.Password)]
        public string? Password { get; set; }

        [DataType(DataType.Password)]
        [Required]
        [Display(Name = " Confirm Password")]
        [Compare("Password", ErrorMessage = "The Passwords Doesn't Match")]
        public string? ConfirmPassword { get; set; }

        [Required]
        public string? PublicAddress { get; set; }


    }
}
