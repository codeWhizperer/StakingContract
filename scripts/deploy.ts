
import { ethers } from "hardhat";

async function main() {
  const WALLETOWNER = "0xf4bfaf916a68b0fC859D63a319034C0f72A88a5C"

  
  // impersonate metamask wallet and setbalance
  //  @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [WALLETOWNER],
  });

// @ts-ignore
  await network.provider.send("hardhat_setBalance", [
    WALLETOWNER,
    "0x2000000000000000000"
  ]);
  const totalSupply = 30;
// const balance = await ethers.provider.getBalance(WALLETOWNER);
// console.log(balance)
//to stop impersonatinig 


  const signer = await ethers.getSigner(WALLETOWNER)
  const Token = await ethers.getContractFactory("BAPTOKEN")
  const tokenDeploy = await Token.connect(signer).deploy(totalSupply)
   await tokenDeploy.deployed()
  console.log("Deployed token address:",tokenDeploy.address)
  const ownerBalance = await ethers.provider.getBalance(WALLETOWNER)
  // console.log("Owner balance:", ownerBalance)

}





main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})
