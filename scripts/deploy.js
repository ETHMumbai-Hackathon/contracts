const { ethers } = require("hardhat");

async function main() {
	const [deployer] = await ethers.getSigners();

	console.log("Deploying contracts with the account:", deployer.address);

	const Core11 = await ethers.getContractFactory("Core11");
	const core11 = await Core11.deploy();

	console.log("Core11 address:", core11.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
