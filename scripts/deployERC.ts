
import { ethers } from "hardhat";

const { DefenderRelayProvider, DefenderRelaySigner } = require('defender-relay-client/lib/ethers');

const credentials = { apiKey:"5ua2kDNFq5iMejTxfpENCgRN3fVRqZtf", apiSecret:"zwvqUizKR1pGYf7bkYPmbJYrEQMn1kGL3KLve5qDDxtNnC4Hr7kq7mH6UcSAA3tN" };
const provider = new DefenderRelayProvider(credentials);
const signer = new DefenderRelaySigner(credentials, provider, { speed: 'fast' });

async function main() {

  const totalSupply = 2000;

  const Token = await ethers.getContractFactory("BAPTOKEN")
  const tokenDeploy = await Token.connect(signer).deploy(totalSupply)
   await tokenDeploy.deployed()
  console.log("Deployed token address:",tokenDeploy.address)

}





main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})
