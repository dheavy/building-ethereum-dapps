// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./TranchePricingCrowdsale.sol";
import "../funding/UnlimitedFundingStrategy.sol";

abstract contract UnlimitedTranchePricingCrowdsale is TranchePricingCrowdsale {
    constructor(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _etherInvestmentObjective
    ) TranchePricingCrowdsale(
        _startTime,
        _endTime,
        _etherInvestmentObjective
    ) payable public {}

    function createFundingLimitStrategy() override internal returns (FundingLimitStrategy) {
        return new UnlimitedFundingStrategy();
    }
}
