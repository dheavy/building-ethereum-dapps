// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./FixedPricingCrowdsale.sol";
import "../funding/UnlimitedFundingStrategy.sol";

contract UnlimitedFixedPricingCrowdsale is FixedPricingCrowdsale {
    constructor(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _weiTokenPrice,
        uint256 _etherInvestmentObjective
    ) FixedPricingCrowdsale(
        _startTime,
        _endTime,
        _weiTokenPrice,
        _etherInvestmentObjective
    ) payable public {}

    function createFundingLimitStrategy() override internal returns (FundingLimitStrategy) {
        return new UnlimitedFundingStrategy();
    }
}
