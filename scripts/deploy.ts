
import { ethers } from "hardhat";

async function main() {
  const totalSupply = 20000;
 await ethers.getSigners()
const BAP = await ethers.getContractFactory("BAPTOKEN");
const bap = await BAP.deploy(totalSupply);
console.log(bap.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})
