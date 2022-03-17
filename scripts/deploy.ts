// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import { BRT } from "../typechain";

async function main() {
  const totalSupply = 10000;
  // const wallet = "0x0c0014c341526c52Abf1Cb64F9C764519075E45d";
 await ethers.getSigners()
const BRT = await ethers.getContractFactory("BRT");
const brt = await BRT.deploy(totalSupply);
console.log(brt.address);
}
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
// 0x0ed64d01D0B4B655E410EF1441dD677B695639E7
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})
