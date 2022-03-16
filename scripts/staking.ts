import {ethers} from "hardhat";

async function main(){
const deployedToken = "0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE";
const contract = await ethers.getContractAt("BRT", deployedToken);
// const balance = await contract.balanceOf(deployedToken)

// console.log(balance)

}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })