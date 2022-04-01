import { expect } from "chai";
import { ethers } from "hardhat"; 
import {main as token } from "../scripts/deploy"






describe("Staking Contract Testing",  async () => {
 const WALLETOWNER = "0xf4bfaf916a68b0fC859D63a319034C0f72A88a5C"
 const BOREDAPEOWNER = "0x9e64b47bbdb9c1f7b599f11987b84c416c0c4110";

  let tokenAddress;
  let deployed:any;
  let account:any;

  beforeEach(async function () {
    tokenAddress = await token()
    deployed = await ethers.getContractAt("BAPTOKEN", tokenAddress)
  });

  it("Returns the balance of mint", async function (){
    // tokenAddress = await token()
    // deployed = await ethers.getContractAt("BAPTOKEN", tokenAddress)
    expect(await deployed.balanceOf(WALLETOWNER)).to.equal("30000000000000000000")
  });

  it("Returns balance of staker",async () => {
    // tokenAddress = await token()
    // deployed = await ethers.getContractAt("BAPTOKEN", tokenAddress)
    expect(await deployed.balanceOf(BOREDAPEOWNER)).to.equal("1000000000000000000")
  })

  
})



// You've just created a BRT TOKEN relayer on Mumbai and an API key for it.

// Ethereum Address

// 0x46847260659475d28a0cf247cb5d1b24945357a1


// content_copy
// API Key
// 5ua2kDNFq5iMejTxfpENCgRN3fVRqZtf

// // content_copy
// // Secret Key
// // Write it down, you won’t be able to retrieve it later.
// zwvqUizKR1pGYf7bkYPmbJYrEQMn1kGL3KLve5qDDxtNnC4Hr7kq7mH6UcSAA3tN