// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Write  a staking contract that accepts an erc20 token called boredApeToken(created by you,18 decimasls)

// - When people stake brt, they 10% of it per month provided they have staked for 3 days or more
// - IMPORTANT: Only BoredApes owners can use your contract

// BOREDAPES NFT: 0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d

contract BRT is ERC20{
    constructor(uint256 _totalSupply) ERC20("boredApeToken", "BRT"){
        _mint(msg.sender, (_totalSupply *10**18));
    }

}