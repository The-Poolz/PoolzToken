// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "poolz-helper-v2/contracts/GovManager.sol";

abstract contract ERC20BurnableMintableCapped is
    ERC20Capped,
    ERC20Burnable,
    GovManager
{
    function mint(address to, uint256 amount) external virtual onlyOwnerOrGov {
        _mint(to, amount);
    }

    function _mint(
        address account,
        uint256 amount
    ) internal virtual override(ERC20Capped, ERC20) {
        super._mint(account, amount);
    }
}
