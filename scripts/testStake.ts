
import {ethers} from "hardhat";

async function main(){
  const deployedStakeAddress = "0xefc1aB2475ACb7E60499Efb171D173be19928a05";
  const BOREDAPEOWNER = "0x9e64b47bbdb9c1f7b599f11987b84c416c0c4110";
  const DEPLOYEDBAP20 = "0xEd4E1f3f9ad315288705713BF3105E2d9976Aa3a";
  const BOREDAPECONTRACT ="0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D";
  const deployedStake = await ethers.getContractAt("StakeContract",deployedStakeAddress )
  const ERC20 = await ethers.getContractAt("BAPTOKEN",DEPLOYEDBAP20)
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [BOREDAPEOWNER],
  });

  const signer = await ethers.getSigner(BOREDAPEOWNER)
// Approve contract to spend on behalf of boredApe owner
const approve = ERC20.connect(signer).approve(deployedStakeAddress,2000000000000)
console.log(await (await approve).wait())

const allowance = await ERC20.connect(signer).allowance(BOREDAPEOWNER, deployedStakeAddress);

console.log(allowance);

    console.log("YOUR BALANCE BEFORE",await ERC20.balanceOf(BOREDAPEOWNER))
    
     await deployedStake.connect(signer).stakeToken(10000000)

     console.log("YOUR BALANCE AFTER",await ERC20.balanceOf(BOREDAPEOWNER))

     console.log(await deployedStake.connect(signer).getBalance())




// 0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE


// JUMP TIME
// suppose the current block has a timestamp of 01:00 PM
// @ts-ignore
await network.provider.send("evm_increaseTime", [259200])
//  @ts-ignore
await network.provider.send("evm_mine") // this one will have 02:00 PM as its timestamp

// WITHDRAW
// await deployedStake.connect(signer).withdraw(9000000);
 console.log(await deployedStake.connect(signer).getBalance())
//  Check thr stake detail
 console.log(await deployedStake.getStakeDetailsByAddress(BOREDAPEOWNER))
//  check balance of boredApe Owner
console.log(await ERC20.balanceOf(BOREDAPEOWNER))
}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })