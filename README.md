# BRT Staking Contract

    BRT STAKE is a Staking Contract project which enables people to stake  with BRT Token and earn 10% interest  monthly on their stake. Stakers can only claim reward when they have staked for more than 3 days.
    
    The reward of stakes is calculated in seconds via the formular;
    
    Reward = TimeSpent * interestPerSeconds * amount; 


    Commands:
    To clone project:
    git clone https://github.com/Adegbite1999/boredApeStakingContract.git

    -Install Dependencies:
     npm install



    File Structure:

    There are three files in the contract viz
    IERC20.sol contains functions to mint BRT Token
    IERC721.sol contains interface to interact with ERC721 contract
    Staking.sol contain the logic for the project.

    Project scripts are deploy.ts, getErc20.ts, staking.ts, testStake.ts
    deploy.ts: To deploy the ERC20 TOKEN
    getErc20.ts: script to interact with deployed ERC20 contract
    staking.ts: deploys the staking contract
    testStake.ts: script to interact with deployed staking contract.

    To test script on forked network 

    This project utilized hardhat `mainnet forking` for testing in local environment

    step1: Click on the link https://admin.moralis.io/speedyNodes to copy a network to be utilized for testing
    step2: run the command npx hardhat node --fork <network>, this gets the snapshot of the network url you copied from moralis.
    step3: To test the scripts, run the command npx hardhat run scrpts/ <script> --network localhost

    BRT TOKEN was deployed on rinkeby test network.
    Deployed BRT TOKEN CONTRACT:0xD0998d596E49F827fDBeb4f40aF29013354969B9
    Link to  verified token: https://rinkeby.etherscan.io/address/0xD0998d596E49F827fDBeb4f40aF29013354969B9#code