// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

abstract contract FundingLimitStrategy {
    function isFullInvestmentWithinLimit(
        uint256 _investment,
        uint256 _fullInvestmentReceived
    ) virtual public view returns (bool);
}
