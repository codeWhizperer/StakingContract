
import { ethers } from "hardhat";

function sleep(ms:number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export async function main() {
  const WALLETOWNER = "0xf4bfaf916a68b0fC859D63a319034C0f72A88a5C"

  
  // impersonate metamask wallet and setbalance
  //  @ts-ignore
  // await hre.network.provider.request({
  //   method: "hardhat_impersonateAccount",
  //   params: [WALLETOWNER],
  // });

// @ts-ignore
  // await network.provider.send("hardhat_setBalance", [
  //   WALLETOWNER,
  //   "0x2000000000000000000"
  // ]);
  const totalSupply = 300;
// const balance = await ethers.provider.getBalance(WALLETOWNER);
// console.log(balance)
//to stop impersonatinig 


  const signer = await ethers.getSigner(WALLETOWNER)
  const Token = await ethers.getContractFactory("BAPTOKEN")
  const tokenDeploy = await Token.connect(signer).deploy(totalSupply)
   await tokenDeploy.deployed()
  console.log("Deployed token address:",tokenDeploy.address)

  console.log("Sleeping.....");
  // Wait for etherscan to notice that the contract has been deployed
  await sleep(100000);

  // Verify the contract after deploying
  // @ts-ignore
  await hre.run("verify:verify", {
    address: tokenDeploy.address,
    constructorArguments: ["300"],
  });
  // return tokenDeploy.address
  // 0xD0998d596E49F827fDBeb4f40aF29013354969B9
}

if (require.main === module) {
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.main = main;


// main().catch((error) => {

//   console.error(error);
//   process.exitCode = 1;
// })

