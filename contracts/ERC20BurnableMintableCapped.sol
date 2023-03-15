// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "./Roles.sol";

abstract contract ERC20BurnableMintableCapped is ERC20Capped, ERC20Burnable {
    using Roles for Roles.Role;

    function mint(address to, uint256 amount) external virtual onlyMinter {
        _mint(to, amount);
    }

    function _mint(
        address account,
        uint256 amount
    ) internal virtual override(ERC20Capped, ERC20) {
        super._mint(account, amount);
    }

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor() {
        _addMinter(_msgSender());
    }

    modifier onlyMinter() {
        require(
            isMinter(_msgSender()),
            "MinterRole: caller does not have the Minter role"
        );
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(_msgSender());
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}
