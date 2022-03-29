// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.4;

interface IERC721{
      function balanceOf(address owner) external view  returns (uint256);
}

//     uint rewardInSecond =2592000;
    
//     function calculateReward(address _address) public view returns (uint256 reward){
//        Stake storage stake  = stakers[_address];
//         if (stake.status==false){
//         return 0;
//     }
//        uint256 perMonth = (stake.amount * 10);
//     //    uint256 perSeconds = perMonth /rewardInSecond;
//        uint256 time = block.timestamp - stake.timeStaked;
//     //  return  reward = time * perSeconds *1000000000;
//        reward = (perMonth * time) /(rewardInSecond * 100);
//     }