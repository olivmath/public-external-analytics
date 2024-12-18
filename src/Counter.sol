// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    string public name;
    uint8[] public array;

    function setNamePublic(string memory newName) public {
        name = newName;
    }

    function setNameExternal(string memory newName) external {
        name = newName;
    }

    function setNumberPublic(uint256 newNumber) public {
        number = newNumber;
    }

    function setNumberExternal(uint256 newNumber) external {
        number = newNumber;
    }

    function setArrayPublic(uint8[] memory newArray) public {
       array = newArray;
    }

    function setArrayExternal(uint8[] memory newArray) external {
       array = newArray;
        
    }
}
