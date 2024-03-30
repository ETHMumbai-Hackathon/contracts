// deploy.js

async function main() {
	const Core11 = await ethers.getContractFactory("Core11");
	console.log("Deploying contract...");
	const core11 = await Core11.deploy();
	await core11.deployed();
	console.log("contract deployed to:", core11.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
