//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256) {
        // address for sepolia ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceFeed.latestRoundData();
        uint8 decimals = priceFeed.decimals();

        // Since solidity does not use decimals. The the price is given in <actualPrice>e<decimals>
        // Lets convert to <actualPrice>e18, which would be the WEI format. This is the msg.value format
        return uint256(price)*10**(18 - decimals);
    }

    function convertEthToUsd(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethUsdRate = getPrice();
        return  (ethAmount * ethUsdRate) / 1e18;
    }
}