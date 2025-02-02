// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    string name = "Testa o gas com public";
    uint256 number = 1000000;
    uint8[] array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

    function setUp() public {
        counter = new Counter();
    }

    function test_gasReportSetNumberPublic(uint256 _unusedParam) public {
        counter.setNumberPublic(number);
        assertEq(counter.number(), number);
    }

    function test_gasReportSetNumberExternal(uint256 _unusedParam) public {
        counter.setNumberExternal(number);
        assertEq(counter.number(), number);
    }

    function test_gasReportSetNamePublic(uint256 _unusedParam) public {
        counter.setNamePublic(name);
        assertEq(counter.name(), name);
    }

    function test_gasReportSetNameExternal(uint256 _unusedParam) public {
        counter.setNameExternal(name);
        assertEq(counter.name(), name);
    }

    function test_gasReportSetArrayPublic(uint256 _unusedParam) public {
        counter.setArrayPublic(array);
        assertEq(counter.array(0), 1);
    }

    function test_gasReportSetArrayExternal(uint256 _unusedParam) public {
        counter.setArrayExternal(array);
        assertEq(counter.array(0), 1);
    }
}
