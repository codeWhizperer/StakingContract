
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IERC20.sol";


// // -when people stake brt, they 10% of it per month provided they have staked for 3 days or more.
// // IMPORTANT: Only BOREDAPES OWNERS CAN USE YOUR CONTRACT WITH
// // BOREDAPES NFT:
// // Write  a staking contract that accepts an erc20 token called boredApeToken(created by you,18 decimasls)

// // - When people stake brt, they 10% of it per month provided they have staked for 3 days or more
// // - IMPORTANT: Only BoredApes owners can use your contract

// // BOREDAPES NFT: 0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d

contract StakeContract{
            event Withdrawal(address, uint208, uint40);
            event AddStack(address, uint208, uint40);
            
            struct Stake{
            uint40 timeStaked;
            uint208 amount;
            bool status;
        }  

        address tokenDeployedAddress = 0xD0998d596E49F827fDBeb4f40aF29013354969B9;
        IERC20 Token = IERC20(tokenDeployedAddress);

        mapping(address =>Stake ) public stakers;
        uint40 minStakeTime = 3 days;
        function stakeToken(uint208 _amount) external {
            require(Token.balanceOf(msg.sender) >= _amount, "insuffient fund");
            Token.transferFrom(msg.sender, address(this), _amount);
            Stake storage stake = stakers[msg.sender];
            if(stake.status == true){
                uint40 daysSpent = uint40(block.timestamp) - stake.timeStaked;
                if(daysSpent > minStakeTime){
                    uint208 reward = calculateReward(msg.sender);
                    stake.amount += reward;
                    stake.amount += _amount;
                    stake.timeStaked = uint40(block.timestamp);
                }
                else {
                    stake.amount += _amount;
                    stake.timeStaked = uint40(block.timestamp);
                }
            }
            else {
                stake.timeStaked = uint40(block.timestamp);
                stake.amount = _amount;
                stake.status = true;

            }
            emit AddStack(msg.sender, _amount, stake.timeStaked);
        }

   function withdraw(uint208 _amount) external {
         Stake storage stake = stakers[msg.sender];
        uint40 daysSpent = uint40(block.timestamp) - stake.timeStaked;
           require(_amount <= stake.amount, "Insufficient fund");

        if(daysSpent > minStakeTime){
        uint208 reward =  calculateReward(msg.sender);
           stake.amount +=   uint208(reward);
            stake.amount -=  uint208(_amount);
            stake.timeStaked = uint40(block.timestamp);
        }else{
        stake.amount = stake.amount - uint208(_amount);
        stake.timeStaked = uint40(block.timestamp);
        }
        Token.transfer(msg.sender, _amount);
        stake.timeStaked = uint40(block.timestamp);
        stake.amount > 0? stake.status = true : stake.status = false;
    emit Withdrawal(msg.sender, _amount, stake.timeStaked);
      
    } 

 uint40 rewardInSecond =2592000;
    
    function calculateReward(address _address) public view returns (uint208 reward){
       Stake storage stake  = stakers[_address];
        if (stake.status==false){
        return 0;
    }
       uint208 perMonth = (stake.amount * 10);
       uint40 time = uint40(block.timestamp) - stake.timeStaked;
       reward = uint208((perMonth * time* 1000) /(rewardInSecond));
    }


function getBalance() external view returns (uint){
Stake memory stake = stakers[msg.sender];
return stake.amount;
}

function getStakeDetailsByAddress(address _address) external view returns (Stake memory){
    Stake memory stake = stakers[_address];
    return stake;
}


}