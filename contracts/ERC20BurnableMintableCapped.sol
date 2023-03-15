// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20Mintable.sol";

abstract contract ERC20BurnableMintableCapped is ERC20Mintable {
    function mint(address to, uint256 amount) external virtual onlyMinter {
        _mint(to, amount);
    }

    function addMinter(address account) external onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() external onlyMinter {
        _removeMinter(_msgSender());
    }
}
