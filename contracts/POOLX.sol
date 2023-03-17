// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract POOLX is ERC20Mintable, ERC20Burnable, ERC20Capped {
    constructor()
        ERC20("Poolz Finance", "POOLX")
        ERC20Capped(5500000 * 10 ** 18)
    {}

    function _mint(
        address account,
        uint256 amount
    ) internal virtual override(ERC20Capped, ERC20) {
        super._mint(account, amount);
    }
}
