//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // Types
    //uint256 int256 bool address byte32 string
    // struct --> object

    // variable
    uint256 public number = 789;

    // funcion
    function showNumber(uint256 num) public view returns(uint256) {        
        return number + num;
    }

    // This is a struct. More like a schema from which an object is formed.
    struct People {
        string name;
        uint256 age;
    }

    // Object
    People public person = People({age: 23, name: "Gboly"});
    // Could also be witten in the order as defined in struct
    // People public person = People("Gboly", 20)

    // Array This is an array of positive integers
    uint256[] public myNumberList;
    // Array of objects with the People schema
    People[] public people;

    // function addPerson(string memory _name, uint256 age) public {
    //     people.push(People(_name, age));
    // }

    // There are two types of array. Fixed-sized and dynamic. 
    // Dynamic - Infinite number of values for array. E.g: uint256[]
    // Fixed-sized - A definite number of values is specified. E.g uint256[3].

    // Mapping. Attaching a value to another value. Like a js object but in the form;
    // {[value1]: value2}
    // The code below maps a name to an age. In js terms, this means that nameToAge is an Object -
    // with a key of name provided and value of age.
    mapping(string => uint256) public nameToAge;

    // The virtual keyword means that the function can be overriden.
    function mapAgeToName(string memory _name, uint256 age) public virtual {
        nameToAge[_name] = age;
    }

    // The difference between an array, struct and mapping;
    // POV: storing name and age.
    // -----
    // struct: {name: <name>, age: <age>}. Just one object that can have different types key/value pair
    // array: [{name: <name>, age: <age>}]. An array of structs
    // mapping:{<name>: <age>, <name>: <age>, ...}. An object that has same type key/value pair

}