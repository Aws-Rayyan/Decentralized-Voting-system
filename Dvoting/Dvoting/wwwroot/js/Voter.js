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

            $("#Rayyan_votes").text(transactionResponse[0][0]);          
            $("#Atari_votes").text(transactionResponse[1][0]);
            $("#Masri_votes").text(transactionResponse[2][0]);

           //await trackVote();
            const transactionResponse2 = await contract.getVotingPeriod();
            const epocheTime =parseInt(transactionResponse2._hex, 16);
            var d = new Date(0);
            d.setUTCSeconds(epocheTime);
           // console.log(d);
            $("#VotingPeriod").html("Voting Will End On  " + d);
            //TODO: Display on UI


        } catch (error) { 
           // console.log('aws')
            console.log(error.data)
  
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
           // $('#VotedSuccessfully').delay(3200).fadeOut(500);

            $('#VoteID').text("User The Following ID To track Your Vote" + transactionResponse.hash)
            $('#VoteID').show()

        } catch (error) {
            console.log(error.data.message)
            if (error.data.message.includes('You Are Not Allowed To Vote')) {
                $('#errorNotAllowedToVote').show()
                $('#errorNotAllowedToVote').delay(5200).fadeOut(500);
            } else if (error.data.message.includes('You Already Voted')) {
                $('#errorAlreadyVoted').show()
                $('#errorAlreadyVoted').delay(5200).fadeOut(500);
            } else if (error.data.message.includes('Voting Period Has Been Exceeded')) {
                $('#errorVotingClosed').show()
                $('#errorVotingClosed').delay(5200).fadeOut(500);
            }




        }


    } else {
        //tell the user to add MetaMask
    }

}


const TrackButton = document.getElementById("TrackButton");
TrackButton.onclick = trackVote;
async function trackVote() {
    //alert('aws')
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);
        try {

            const voteid = $("#voteTrackingBox").val()
            if (voteid == "" || voteid.length != 66) //TX id is 64 char (256bits = 32bytes) + 2 for the "0x"
            {              
                $('#trackingerrorbox').text("Please Enter A Valid ID")
                $('#trackingerrorbox').show()
                $('#trackingerrorbox').delay(5200).fadeOut(500);

                return;
            }

          
            console.log(voteid)
            try {      
                const transactionResponse = await provider.getTransaction(voteid)
                console.log(transactionResponse);
                console.log(transactionResponse.data); //get the transaction data
                const transactionData = transactionResponse.data;
                if (transactionData.substring(0, 10) != "0x0121b93f") { //check if the data corresponds to the vote function signature
                    $('#trackingerrorbox').text("Please Enter A Valid ID")
                    $('#trackingerrorbox').show()
                    $('#trackingerrorbox').delay(5200).fadeOut(500);
                    return;
                }

                const transactionReceipt = await provider.getTransactionReceipt(voteid)
                console.log("Transaction receipt:")
                console.log(transactionReceipt)
                if (transactionReceipt == null) {
                    $('#trackingerrorbox').text("The Transaction is not yet confirmed, Please Wait")
                    $('#trackingerrorbox').show()
                    $('#trackingerrorbox').delay(5200).fadeOut(500);
                   return
                }
              


                console.log(transactionData.substring(10))//remove 0x and the function signature 8 char
                const candidateIDHex = transactionData.substring(10)
                const candidateID = parseInt(candidateIDHex, 16) //convert candidate ID to decimal
                console.log(candidateID)
              
                const candidateName = await contract.getCandidate(candidateID);//send if to the contract
                console.log(candidateName.name);
                $('#voteIDres').text("A Vote Has Been Casted To " + candidateName.name)
                $('#voteIDres').show()
                $('#voteIDres').delay(9200).fadeOut(500);
             
            } catch (e) {
                $('#trackingerrorbox').text("You Didn't Vote Yet")
                $('#trackingerrorbox').show()
                $('#trackingerrorbox').delay(5200).fadeOut(500);
            }

        } catch (error) {
            console.log(error.data.message)       
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

