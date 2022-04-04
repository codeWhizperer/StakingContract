import {ethers} from "hardhat";

async function main(){
const Contract = await ethers.getContractFactory("StakeContract");
const contract = await Contract.deploy()
await contract.deployed()

console.log(await contract.address)
// const balance = await contract.balanceOf(deployedToken)

// console.log(balance)
// 0x40960D06132BBCBAA3FfA1B77d10e57C8578eF95
}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })