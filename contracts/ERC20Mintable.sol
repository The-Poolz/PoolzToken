// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./MinterRole.sol";

abstract contract ERC20Mintable is Context, MinterRole, ERC20 {
    constructor() {
        Minter[_msgSender()] = true;
    }

    function mint(address to, uint256 amount) external virtual onlyMinter {
        _mint(to, amount);
    }
}
