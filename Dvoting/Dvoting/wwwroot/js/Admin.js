// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
import { ethers } from "./ethers-5.1.esm.min.js";
import {abi , contractAddress } from "./constants.js"
import * as jQuery from "../lib/jquery/dist/jquery.js";



const PermissionButton = document.getElementById("PermissionButton");
PermissionButton.onclick = GivePermmision;
async function GivePermmision() {
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);

        //add a check here to see if the address is not empty, and is in the right
        //format
        const address = document.getElementById("addressToPermitInput").value;

        alert(address)
        try {
            const transactionResponse = await contract.permitToVote(address);
            console.log(transactionResponse.data);
            
            $('#PermissionSuccessful').show()
            $('#PermissionSuccessful').delay(3200).fadeOut(500);
        } catch (error) {          
            console.log(error.data.message)

            if (error.data.message.includes('User Already Added')) {
                $('#errorUserAlreadyAdded').show()
                $('#errorUserAlreadyAdded').delay(3200).fadeOut(500);
            } else if (error.data.message.includes('Only The Owner Is Allowed To Perform This Operation')) {
                $('#onlyAdmin').show()
                $('#onlyAdmin').delay(3200).fadeOut(500);

            }
        }
       

    } else {
       
    }

   


}








const testbutton = document.getElementById("TestButton");
testbutton.onclick = etherprintTest;
function etherprintTest() {
    console.log(ethers);
}

