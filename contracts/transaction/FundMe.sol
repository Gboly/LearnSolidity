// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error InsufficientFunding();
error UnAuthorized();

// A demo of sending money into a contract and withdrawing the money at any time.
contract FundMe {
    using PriceConverter for uint256;
    // fund function
    // Set a fund price limit to $7.
    // Avoid duplicate addresses in both arrays below
    // save an history of funders (addresses) in an array "fundersLog". Reps all funders since -
    // contract was deployed even after withdrawing funds.
    // Save holders in an array. Reps address that still have funds in the contract. Not withdrawn
    // Map funders address to the amount funded.
    // Also map funders address to their index in array plus 1. This would be used to confirm the
    // existence to avoid duplicate addresses.
    // NB: functions that use only a constant variable should be classified as pure.

    uint256 constant PRICE_LIMIT = 7e18; // e18 to much the converted decimal chainlink price. 7USD
    address immutable i_owner;
    address[] public funders;
    address[] public holders;
    mapping(address => uint256) public fundersToIndexPlusOne;
    mapping(address => uint256) public fundersToPrice;

    constructor () {
        i_owner = msg.sender;
    }
  
    function fund() public payable enforcePriceLimit {       
         if (fundersToIndexPlusOne[msg.sender] == 0) {
            funders.push(msg.sender);
            fundersToIndexPlusOne[msg.sender] = funders.length;
            }
         if (fundersToPrice[msg.sender] == 0) holders.push(msg.sender);
        fundersToPrice[msg.sender] += msg.value;
    }

    modifier enforcePriceLimit {
        if (msg.value.convertEthToUsd() <= PRICE_LIMIT)  revert InsufficientFunding();
        _;
    }

    
    // withdraw funtion
    // Authenticate this function by ensuring that only the owner of contract can withdraw.
    // Perform actual withdrawal
    // empty holders array
    // set mapped values of every holder address to 0.
    
    function withdraw() public authenticate {
        for(uint256 holderIndex = 0; holderIndex < holders.length; holderIndex++) {
            fundersToPrice[holders[holderIndex]] = 0;
        }
        holders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdrawal failed.");
    }

    modifier authenticate {
        if (i_owner != msg.sender)  revert UnAuthorized();
        _;
    }

    // Receive & fallback
    receive() external payable {
        fund();
    }
    
    fallback() external payable {
        fund();
    }
}

// testing
// Fund the contracts with 2 diff accts
// Withdraw
// -- At this point, holders array is empty while fundersLog still remains.
// -- The mapping value of all funders is zero.
// Now, fund again
// Check that holders array is populated with this address and the mapped value is correct.
// Fund again using the same address to ensure that the mapped value is a sum of old and new value.
// Confirm that the array does not push an existing address.
