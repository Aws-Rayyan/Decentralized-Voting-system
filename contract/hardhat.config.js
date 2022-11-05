require("@nomicfoundation/hardhat-toolbox")
require("dotenv").config()
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
//aws
const GANACHE_RPC_URL = process.env.GANACHE_RPC_URL
const PRIVATE_KEY = process.env.PRIVATE_KEY

module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        localhost: {
            //yarn hardhat node
            url: "http://127.0.0.1:8545/",
            //accounts: [PRIVATE_KEY], //no need to add it, its added automatically
            chainId: 31337,
        },
        ganache: {
            url: GANACHE_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 1337,
        },
    },
    solidity: {
        compilers: [
            {
                version: "0.8.8",
            },
        ],
    },
    // gasReporter: {
    //     enabled: true,
    //     currency: "USD",
    //     outputFile: "gas-report.txt",
    //     noColors: true,
    //     // coinmarketcap: COINMARKETCAP_API_KEY,
    // },
}
