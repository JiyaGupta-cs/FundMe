//  Get Funds from users
//  Withdraw funds
// set minimum funding limit

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
  
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x447Fd5eC2D383091C22B8549cb231a3bAD6d3fAf
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 amt) internal view returns (uint256) {
        uint256 ethAmt = getPrice();
        return (amt * ethAmt) / 1e18;
    }
    
}
