
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IERC20.sol";


// // -when people stake brt, they 10% of it per month provided they have staked for 3 days or more.
// // IMPORTANT: Only BoREDaPES OWNERS CAN USE YOUR CONTRACT WITH
// // BOREDAPES NFT:
// // Write  a staking contract that accepts an erc20 token called boredApeToken(created by you,18 decimasls)

// // - When people stake brt, they 10% of it per month provided they have staked for 3 days or more
// // - IMPORTANT: Only BoredApes owners can use your contract

// // BOREDAPES NFT: 0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d

contract StakeContract is ERC20 {

            struct Stake{
            uint256 timeStaked;
            uint256 amount;
            address staker;
            bool status;
        }  
        mapping(address =>Stake ) public stakers;
        // uint256 minStakeTime = 5 seconds;
        uint256 minStakeTime = 3 days;
        function stakeToken(uint256 _amount) external {
            require(boredApes.balanceOf(msg.sender) >= 1, "Only boredApes owner can stake");
            // transfer token to BoredAPE OWNER
            BAPTOKEN.transferFrom(msg.sender, address(this), _amount);
            require(BAPTOKEN.balanceOf(msg.sender) >= _amount, "insuffient fund");
            Stake storage stake = stakers[msg.sender];
            if(stake.status == true){
                if(stake.timeStaked > minStakeTime){
                    uint256 interest = calInterest(msg.sender);
                    stake.amount += interest;
                    stake.amount += _amount;
                    stake.timeStaked = block.timestamp;
                }
                else {
                    stake.amount += _amount;
                    stake.timeStaked = block.timestamp;
                }
            }
            else {
                stake.timeStaked = block.timestamp;
                stake.amount = _amount;
                stake.staker = msg.sender;
                stake.status = true;

            }
        }

     function calInterest(address _address) view public returns (uint256){
    Stake memory stake = stakers[_address];
    if (stake.status==false){
        return 0;
    }
    uint256 secondsInDay = 86400;
    // uint256 secondsInDay = 5;
    uint256 daysSpent = block.timestamp - stake.timeStaked;
    // uint256 interest = ((daysSpent/secondsInDay) / 300) * _stakes ;
    uint256 interest = (daysSpent * stake.amount)/(secondsInDay*300);
    return interest;
    }


//    unction withdraw() external {
//         // withdraw reward

//         // withdraw stake

//         // withdraw all
//     } f


}


