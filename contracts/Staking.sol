
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
            event Withdrawal(address, uint256, uint256);
            event AddStack(address, uint256, uint256);
            
            struct Stake{
            uint256 timeStaked;
            uint256 amount;
            address staker;
            bool status;
        }  

        // address boredApeAddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
        address tokenDeployedAddress = 0xEd4E1f3f9ad315288705713BF3105E2d9976Aa3a;

        // IERC721 BoredApeToken = IERC721(boredApeAddress);
        IERC20 Token = IERC20(tokenDeployedAddress);

        mapping(address =>Stake ) public stakers;
        // uint256 minStakeTime = 5 seconds;
        uint256 minStakeTime = 3 days;
        function stakeToken(uint256 _amount) external {
            // require(BoredApeToken.balanceOf(msg.sender) >= 1, "Only boredApes owner can stake");
            // transfer token to BoredAPE OWNER;
            require(Token.balanceOf(msg.sender) >= _amount, "insuffient fund");
            // transfer to boredowner first from the deploy ERC
            Token.transferFrom(msg.sender, address(this), _amount);
            Stake storage stake = stakers[msg.sender];
            if(stake.status == true){
                uint256 daysSpent = block.timestamp - stake.timeStaked;
                if(daysSpent > minStakeTime){
                    // require(daysSpent > minStakeTime, "Maturity not yet reached!!");
                    uint256 reward = calculateReward(msg.sender);
                    stake.amount += reward;
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
            emit AddStack(msg.sender, _amount, stake.timeStaked);
        }

   function withdraw(uint256 _amount) external {
         Stake storage stake = stakers[msg.sender];
        uint256 daysSpent = block.timestamp - stake.timeStaked;
           require(_amount <= stake.amount, "Insufficient fund");

        if(daysSpent > minStakeTime){
        uint256 reward =  calculateReward(msg.sender);
           stake.amount +=   reward;
            // check that amount requested is lesser or equal total balance
            stake.amount -=  _amount;
            stake.timeStaked = block.timestamp;
        }else{
  // if daysSpent is greater than minStakeTime and you try to withdraw , withdraw that amount and then compound your interest else give the withdrawl d amount he wnt to withdraw
        stake.amount = stake.amount - _amount;
        stake.timeStaked = block.timestamp;
        }
        Token.transfer(msg.sender, _amount);
        stake.timeStaked = block.timestamp;
        stake.amount > 0? stake.status = true : stake.status = false;
    emit Withdrawal(msg.sender, _amount, stake.timeStaked);
      
    } 

//   @dev Calculate Reward per seconds

 uint rewardInSecond =2592000;
    
    function calculateReward(address _address) public view returns (uint256 reward){
       Stake storage stake  = stakers[_address];
        if (stake.status==false){
        return 0;
    }
       uint256 perMonth = (stake.amount * 10);
       uint256 time = block.timestamp - stake.timeStaked;
       reward = (perMonth * time* 1000) /(rewardInSecond);
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