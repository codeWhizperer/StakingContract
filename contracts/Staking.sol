
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

contract StakeContract{
            event Withdrawal(address, uint256, uint256);
            event AddStack(address, uint256, uint256);
            
            struct Stake{
            uint256 timeStaked;
            uint256 amount;
            address staker;
            bool status;
        }  

        address boredApeAddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;

        IERC721 BoredApeToken = IERC721(boredApeAddress);
        IERC20 Token = IERC20(boredApeAddress);
        mapping(address =>Stake ) public stakers;
        // uint256 minStakeTime = 5 seconds;
        uint256 minStakeTime = 3 days;
     
        // uint256 minStakeTime = 3 days;
        function stakeToken(uint256 _amount) external {
            require(BoredApeToken.balanceOf(msg.sender) >= 1, "Only boredApes owner can stake");
            // transfer token to BoredAPE OWNER
            Token.transferFrom(msg.sender, address(this), _amount);
            require(Token.balanceOf(msg.sender) >= _amount, "insuffient fund");
            Stake storage stake = stakers[msg.sender];
            if(stake.status == true){
                uint256 daysSpent = block.timestamp - stake.timeStaked;
                if(daysSpent > minStakeTime){
                    require(daysSpent > minStakeTime, "ogbeni");
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
            emit AddStack(msg.sender, _amount, stake.timeStaked);
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

   function withdraw(uint256 _amount) external {
         Stake storage stake = stakers[msg.sender];
        uint256 daysSpent = block.timestamp - stake.timeStaked;

        if(daysSpent > minStakeTime){
        uint256 reward =  calInterest(msg.sender);
           uint256 total =  stake.amount + reward;
            // check that amont requested is lesser or equal total balance
           require(total >= _amount, "Insufficient fund");
            stake.amount = total - _amount;
            stake.timeStaked = block.timestamp;
        }else{
  // if daysSpent is greater than minStakeTime and you try to withdraw , withdraw that amount and then compound your interest else give the withdrawl d amount he wnt to withdraw
        require(stake.amount >= _amount, "Insufficient fund");
        stake.amount = stake.amount - _amount;
        stake.timeStaked = block.timestamp;
        }
        Token.transfer(msg.sender, _amount);
        stake.status = true;
        stake.timeStaked = block.timestamp;
    emit Withdrawal(msg.sender, _amount, stake.timeStaked);
      
    } 




}