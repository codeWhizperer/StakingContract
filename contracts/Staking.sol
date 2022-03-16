
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// // -when people stake brt, they 10% of it per month provided they have staked for 3 days or more.
// // IMPORTANT: Only BoREDaPES OWNERS CAN USE TYOUR CONTRACT WITH
// // BOREDAPES NFT:
// // Write  a staking contract that accepts an erc20 token called boredApeToken(created by you,18 decimasls)

// // - When people stake brt, they 10% of it per month provided they have staked for 3 days or more
// // - IMPORTANT: Only BoredApes owners can use your contract

// // BOREDAPES NFT: 0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d

contract Staking{
    IERC20 brtToken;
    IERC721 brtNft;
mapping(address => uint256) balances;
mapping(address => uint256) rewards;
    constructor(address _brtToken, address _brtNft){
      brtNft =  IERC721(_brtNft);
       brtToken =  IERC20(_brtToken);
    }

// design pattern ??????

// function stake(){
     
// }


function check(address _nftAddr) view internal{
    require(brtNft.balanceOf(_nftAddr) >= 1, "Only boredApes owner can stake");
}

// checks if boredAddress has boredApeNft...if it does then transfer token to his account
  function transferToken(address _nftAddr, uint256 _amount) external{
      check((_nftAddr));
      brtToken.transfer(_nftAddr, _amount);
  }


}
// // write a staking contract that accepts an erc20 token called bordApeToken(created byy you, 18 decimals) 


// contract Staking is BRT{

// struct Stakings{
//     address stakers[];
//     uint256 maturityTime;
//     uint256 amount;
//     bool status;
// }

// uint256 index;

// mapping(address => Stakings) balances;

// // function stake(address _stakers[], _amount, _maturityTime) external 
// // {

// // }

// }