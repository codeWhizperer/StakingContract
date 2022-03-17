
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./BRT.sol";

// // -when people stake brt, they 10% of it per month provided they have staked for 3 days or more.
// // IMPORTANT: Only BoREDaPES OWNERS CAN USE TYOUR CONTRACT WITH
// // BOREDAPES NFT:
// // Write  a staking contract that accepts an erc20 token called boredApeToken(created by you,18 decimasls)

// // - When people stake brt, they 10% of it per month provided they have staked for 3 days or more
// // - IMPORTANT: Only BoredApes owners can use your contract

// // BOREDAPES NFT: 0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d

contract Staking is ERC20{
 constructor(uint256 _totalSupply) ERC20("boredApeToken", "BRT"){
        _mint(msg.sender, (_totalSupply *10**18));
    }
    struct Stake{
        address staker;
        uint256 timeStaked;
        uint256 amount;
        mapping(address => uint) balances;
    }
        // mapping(address => uint) balance;
    
    address boredApeContract = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
    IERC721 boredApes = IERC721(boredApes);

    mapping(address =>Stake ) public stakers;
    // mapping(uint => Stake)
    // mapping(address => uint) balance;
    // uint256 private totalStakes;
    uint256 constant yield = 10;
    uint256 day = 30 days;
    
    

    // constructor(address _brtToken, address _brtNft){
    //   brtNft =  IERC721(_brtNft);
    // //    brtToken =  IERC20(_brtToken);
    // }

// function transfer()external();
function stake(uint256 _amount) external{
    require(boredApes.balanceOf(msg.sender) >= 1, "Only boredApes owner can stake");
//    transfer from the wallet minted to ==> boredAddress
    require(_balances[msg.sender] >= _amount, "insuffient fund");
    Stake storage s = stakers[msg.sender];
    s.staker = msg.sender;
    s.timeStaked = block.timestamp;
    s.amount += _amount;
    s.balances[msg.sender]+=_amount;  
}


// withdraw function will be in 3 part
// case 1: choose to withdraw all i.e your stake and reward
// case2:choose to withdraw reward only
// case3: choose to withdraw stake only
// enum Action {
//     stake, reward, all
// }
function withdraw() external {
    Stake storage w = stakers[msg.sender];
    uint256 amount = w.balances[msg.sender];
    if((block.timestamp  - w.timeStaked) < 3 days){
    w.balances[msg.sender] = amount;
    }
    uint interest =   calInterest();
    w.balances[msg.sender] += interest;
    }

    function calInterest() view internal returns (uint){
        Stake storage i = stakers[msg.sender];
     uint256 secondsInDay = 86400;
    uint256 daysSpent = block.timestamp - i.timeStaked;
    uint256 interest = ((daysSpent/secondsInDay) / 300) * i.amount;
    return interest;
    }

// operator not comppatible with type rational_cost 1/10 and uint256
// function check(address _nftAddr) view internal{
//     require(brtNft.balanceOf(_nftAddr) >= 1, "Only boredApes owner can stake");
// }

// checks if boredAddress has boredApeNft...if it does then transfer token to his account
//   function transferToken(address _nftAddr, uint256 _amount) external{
//       check((_nftAddr));
//       brtToken.transferFrom(msg.sender, address(this), _amount);
//   }


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