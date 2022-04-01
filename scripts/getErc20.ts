
import { ethers } from "hardhat";

 async function main() {
  const WALLETOWNER = "0xf4bfaf916a68b0fC859D63a319034C0f72A88a5C";
const DEPLOYEDBAP20 = "0xEd4E1f3f9ad315288705713BF3105E2d9976Aa3a";
const BOREDAPEOWNER = "0x9e64b47bbdb9c1f7b599f11987b84c416c0c4110";
const BOREDAPECONTRACT ="0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D";
const signer = await ethers.getSigner(WALLETOWNER);

const ERC20 = await ethers.getContractAt("BAPTOKEN",DEPLOYEDBAP20)
console.log(await ERC20.balanceOf(WALLETOWNER))
//  await ERC20.connect(signer).transfer(BOREDAPEOWNER, "1000000000000000000")
console.log(await ERC20.balanceOf(BOREDAPEOWNER))

// 30000000000000000000
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})


exports.deploy = main;
