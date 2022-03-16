// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import { BRT } from "../typechain";

async function main() {
  const totalSupply = 10000;
  const signer = await ethers.getSigners(); ;
  const signerMsg = await signer[0].address;
  const msgSender = await ethers.getSigner(signerMsg)
const BRT = await ethers.getContractFactory("BRT");
const brt = await BRT.connect(msgSender).deploy(totalSupply);
console.log(brt.address);
}
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})
