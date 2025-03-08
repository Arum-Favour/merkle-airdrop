//// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract WegelToken is ERC20, Ownable(msg.sender) {
    constructor() ERC20("Wegel", "WGL") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
