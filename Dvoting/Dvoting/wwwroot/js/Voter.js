// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
import { ethers } from "./ethers-5.1.esm.min.js";
import {abi , contractAddress } from "./constants.js"
import * as jQuery from "../lib/jquery/dist/jquery.js";



const getCandidatesButton = document.getElementById("getCandidatesButton");
getCandidatesButton.onclick = getCandidates;
async function getCandidates() {    
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);       
        try {
            const transactionResponse = await contract.getCandidates();
            console.log(transactionResponse); //returns array of array 
          
            var select = document.getElementById('CandidatesList');
          
            for (let i = 0; i < Object.keys(transactionResponse).length; i++) {              
                var opt = document.createElement('option');
                opt.value = i;
                opt.innerHTML = transactionResponse[i][1];
                select.appendChild(opt);
            }


           
        } catch (error) {          
            console.log(error.data.message)
  
        }
       

    } else {
       //tell the user to add MetaMask
    }

}

const VoteButton = document.getElementById("VoteButton");
VoteButton.onclick = Vote;
async function Vote() {
    //alert('aws')
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);
        try {
            const transactionResponse = await contract.vote($('#CandidatesList').val());
            console.log(transactionResponse); //returns array of array 

            $('#VotedSuccessfully').show()
            $('#VotedSuccessfully').delay(3200).fadeOut(500);

        } catch (error) {
            console.log(error.data.message)
            if (error.data.message.includes('You Are Not Allowed To Vote')) {
                $('#errorNotAllowedToVote').show()
                $('#errorNotAllowedToVote').delay(5200).fadeOut(500);
            } else if (error.data.message.includes('You Already Voted')) {
                $('#errorAlreadyVoted').show()
                $('#errorAlreadyVoted').delay(5200).fadeOut(500);
            }




        }


    } else {
        //tell the user to add MetaMask
    }

}









const testbutton = document.getElementById("TestButton");
testbutton.onclick = etherprintTest;
function etherprintTest() {
    console.log(ethers);
}

