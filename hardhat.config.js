// importing modules.
require("hardhat-deploy");
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");

// Getting all env variables.
const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
const ACCOUNT_PRIV_KEY = process.env.ACCOUNT_PRIV_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        rinkeby: {
            url: RINKEBY_RPC_URL,
            accounts: [ACCOUNT_PRIV_KEY],
            chainId: 4,
        },
        localhost: {
            url: "http:127.0.0.1:8545",
            chainId: 31337,
        },
    },
    solidity: "0.8.9",
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
        enabled: true,
        outputFile: "gas-resport.txt",
        noColors: true,
        coinmarketcap: COINMARKETCAP_API_KEY,
    },
    namedAccounts: {
        deployer: {
            default: 0,
        },
    },
};
