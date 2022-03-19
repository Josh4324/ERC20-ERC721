// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  //const Greeter = await hre.ethers.getContractFactory("Greeter");
  // const greeter = await Greeter.deploy("Hello, Hardhat!");

  const JNFT = await hre.ethers.getContractFactory("JNFT");

  const jnft = await JNFT.deploy();

  const jnftDeployed = await jnft.deployed();

  await jnftDeployed.makeJNFT(
    "Fake APE 1",
    "https://ipfs.io/ipfs/bafybeigwwraht2qi3uqtgx34xp4hy6rvbw77ubvqpw27o3okg2gpukpdjy/nft1.webp"
  );

  await jnftDeployed.makeJNFT(
    "Fake APE 2",
    "https://ipfs.io/ipfs/bafybeidsr6h3k4odc43tjaz33pvujm6uh7lxhd6zlnnwlm4pwbwboedtuy/ntf2.jpeg"
  );

  await jnftDeployed.makeJNFT(
    "Fake APE 3",
    "https://ipfs.io/ipfs/bafybeigjj6fk2bafym56u6d2ko56ktio7tzggyllm6psr5zixy5x72d2be/nft3.jpeg"
  );

  console.log("JNFT deployed to:", jnft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
