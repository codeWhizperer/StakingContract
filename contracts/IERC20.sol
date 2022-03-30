
// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract BAPTOKEN is ERC20 {
 constructor(uint256 _totalSupply) ERC20("boredApeToken", "BRT"){
        _mint(msg.sender, (_totalSupply *10**18));
    }
}
