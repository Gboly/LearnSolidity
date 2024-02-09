// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Inheritance. ExtraStorage inheriting SimpleStorage.
contract ExtraStorage is SimpleStorage {

    // Overriding the mapAgeToName function in SimpleStorage.
    // Code and output remain as is in SimpleStorage. Changes made here only runs for this 
    // particular inheriting contract.
    function mapAgeToName(string memory _name, uint256 age) public override {
        nameToAge[_name] = age + 10;
    }

}