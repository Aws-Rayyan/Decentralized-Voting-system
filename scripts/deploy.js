//similar to ethers
const { ethers, network } = require("hardhat");
const fs = require("fs-extra");

async function Main() {
    //hardhat method

    //if we used ethers here instead of hardhat, then it wouldn't know
    //where to find the file , however hardhat is smart enought to find it in the
    // contracts folder
    const DvotingFactory = await ethers.getContractFactory("Dvoting");
    console.log("deploying plz w8");
    const Dvoting = await DvotingFactory.deploy("5");
    await Dvoting.deployed();

    console.log("contract deployed to : " + Dvoting.address);

    console.log(network.config);

    var period = await Dvoting.getVotingPeriod();
    console.log("The voting will end in " + period);
    console.log(period);

    // var num = await Dvoting.retrieve();
    // console.log(num);
    // const stored = await Dvoting.store("100");
    // num = await Dvoting.retrieve();
    // console.log(num);

    //ethers method
    //http://127.0.0.1:8545

    // const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    // const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    // const abi = fs.readFileSync(
    //     "./SimpleStorage_sol_SimpleStorage.abi",
    //     "utf-8"
    // );
    // const binary = fs.readFileSync(
    //     "./SimpleStorage_sol_SimpleStorage.bin",
    //     "utf-8"
    // );
    // const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    // console.log("deploying .... pls w8");

    // // you can add the gasPrice and gasLimit in the deploy function between {}
    // const contract = await contractFactory.deploy(); // wait for the contract to deploy

    // //wait for 1 block before starting to work with the contract
    // //inorder to make sure it gets attached to the chain
    // const deploymentReceipt = await contract.deployTransaction.wait(1);
    // //console.log(contract);

    // const currentFavoutiteNumber = await contract.retrieve();
    // console.log(
    //     "Current favourite number is : " + currentFavoutiteNumber.toString()
    // );

    // const transactionResponse = await contract.store("4445");
    // const transactionReceipt = await transactionResponse.wait(1);

    // const updateFavoutiteNumber = await contract.retrieve();
    // console.log(
    //     "Current favourite number is : " + updateFavoutiteNumber.toString()
    // );
}

Main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
