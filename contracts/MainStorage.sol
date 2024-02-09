// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract MainStorage {
    // Initializing a variable "simpleStorage" with a type SimpleStorage which is a contract
    // SimpleStorage public simpleStorage;

    // A function that creates the SimpleStorage contract.
    // function createSimpleStorage() public {
    //     simpleStorage = new SimpleStorage();
    // }

    // Initializing an array "simpleStorages" with a type SimpleStorage which is a contract.
    // This holds every contract created by the fxn beneath.
     SimpleStorage[] public simpleStorages;

    // A function that creates a SimpleStorage contract and then pushes it into the simpleStorage Array
    function createSimpleStorage() public {
        simpleStorages.push(new SimpleStorage());
    }

    // Calling a function within the simpleStorage contract
    // function msShowNumber(uint256 contractIndex, uint256 num) public view returns(uint256) {
    //     SimpleStorage simpleStorage = simpleStorages[contractIndex];
    //     return simpleStorage.showNumber(num);
    // }

    // function getNumberFromSimpleStorage(uint256 contractIndex) public view returns(uint256) {
    //     return simpleStorages[contractIndex].number();
    // }

    // Using the mapAgeToName function from SimpleStorage contract.
    function msMapAgeToName(uint256 contractIndex,string memory _name, uint256 age) public {
        simpleStorages[contractIndex].mapAgeToName(_name, age);
    }

    // Retreiving the value of a mapped pair by the key which is name.
    function getMappedAgeFromName(uint256 contractIndex, string memory name) public view returns(uint256) {
        return simpleStorages[contractIndex].nameToAge(name);
    }
}