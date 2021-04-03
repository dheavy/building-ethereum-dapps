// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SimpleCoin.sol";

contract ReleasableSimpleCoin is SimpleCoin {
    bool public released = false;

    modifier isReleased() {
        if (!released) {
            revert();
        }
        _;
    }

    constructor(uint256 _initialSupply)
        SimpleCoin(_initialSupply) public {}

    function release() onlyOwner public {
        released = true;
    }

    function transfer(address _to, uint256 _amount) isReleased override public {
        super.transfer(_to, _amount);
    }

    function transferFrom(address _from, address _to, uint256 _amount) isReleased override public returns (bool) {
        super.transferFrom(_from, _to, _amount);
    }
}
