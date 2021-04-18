// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Ownable.sol";

contract Destructible is Ownable {
    constructor() payable public {}

    function destroyAndSend(address payable _recipient) onlyOwner public {
        selfdestruct(_recipient);
    }
}
