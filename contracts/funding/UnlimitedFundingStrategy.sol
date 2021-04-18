// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./FundingLimitStrategy.sol";

contract UnlimitedFundingStrategy is FundingLimitStrategy {
    function isFullInvestmentWithinLimit(
        uint256 _investment,
        uint256 _fullInvestmentReceived
    ) override public view returns (bool) {
        return true;
    }
}
