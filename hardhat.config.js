/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");

// const { PrivateKey } = require("./secret.json");

module.exports = {
	defaultNetwork: "testnet",

	networks: {
		hardhat: {},
		testnet: {
			url: "https://rpc.test.btcs.network",
			accounts: [
				"5f53fcbe4e1e45636fb0baf6e4630ad360d1788fdee52df4ebf320e9ac8d59c9",
			],
			chainId: 1115,
		},
	},
	solidity: {
		compilers: [
			{
				version: "0.8.24",
				settings: {
					optimizer: {
						enabled: true,
						runs: 200,
					},
				},
			},
		],
	},
	paths: {
		sources: "./contracts",
		cache: "./cache",
		artifacts: "./artifacts",
	},
	mocha: {
		timeout: 20000,
	},
};
