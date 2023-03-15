// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract POOLZ is ERC20Capped, ERC20Burnable {
    constructor()
        ERC20("Poolz Finance", "$POOLZ")
        ERC20Capped(5500000 * 10 ** 18)
    {}

    function mint(address to, uint256 amount) public virtual {
        _mint(to, amount);
    }

    function _mint(
        address _account,
        uint256 _amount
    ) internal virtual override(ERC20Capped, ERC20) {
        super._mint(_account, _amount);
    }
}
