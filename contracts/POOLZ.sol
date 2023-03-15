// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20BurnableMintableCapped.sol";

contract POOLZ is ERC20BurnableMintableCapped {
    constructor()
        ERC20("Poolz Finance", "POOLX")
        ERC20Capped(5500000 * 10 ** 18)
    {}
}
