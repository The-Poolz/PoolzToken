// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @title Minter
 * @dev managing addresses assigned to a minter role.
 */
contract MinterRole {
    mapping(address => bool) Minter;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    modifier onlyMinter() {
        require(
            Minter[msg.sender],
            "MinterRole: caller does not have the Minter role"
        );
        _;
    }

    function addMinter(address account) external onlyMinter {
        require(!Minter[account], "MinterRole: account already has role");
        require(
            account != address(0),
            "MinterRole: account is the zero address"
        );
        Minter[account] = true;
        emit MinterAdded(account);
    }

    function renounceMinter() external onlyMinter {
        Minter[msg.sender] = false;
        emit MinterRemoved(msg.sender);
    }

    function isMinter(address account) external view returns (bool) {
        return Minter[account];
    }
}
