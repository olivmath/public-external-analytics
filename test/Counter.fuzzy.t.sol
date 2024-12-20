// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterFuzzyTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_gasReportSetNumberPublic(uint256 number) public {
        counter.setNumberPublic(number);
        assertEq(counter.number(), number);
    }

    function test_gasReportSetNumberExternal(uint256 number) public {
        counter.setNumberExternal(number);
        assertEq(counter.number(), number);
    }

    function test_gasReportSetNamePublic(string memory name) public {
        counter.setNamePublic(name);
        assertEq(counter.name(), name);
    }

    function test_gasReportSetNameExternal(string memory name) public {
        counter.setNameExternal(name);
        assertEq(counter.name(), name);
    }

    function test_gasReportSetArrayPublic(uint8[] memory array) public {
        vm.assume(array.length > 0);
        uint8 first = array[0];

        counter.setArrayPublic(array);
        assertEq(counter.array(0), first);
    }

    function test_gasReportSetArrayExternal(uint8[] memory array) public {
        vm.assume(array.length > 0);
        uint8 first = array[0];

        counter.setArrayExternal(array);
        assertEq(counter.array(0), first);
    }
}
