// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./SimpleCrowdsale.sol";

abstract contract FixedPricingCrowdsale is SimpleCrowdsale {
    constructor(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _weiTokenPrice,
        uint256 _etherInvestmentObjective
    ) SimpleCrowdsale(
        _startTime,
        _endTime,
        _weiTokenPrice,
        _etherInvestmentObjective
    ) payable public {}

    function calculateNumberOfTokens(uint256 _investment) override internal returns (uint256) {
        return _investment / weiTokenPrice;
    }
}
