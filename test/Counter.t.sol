// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    /// @notice Testa o gás com `public`
    function test_gasReportSetNumberPublic(uint256 x) public {
        counter.setNumberPublic(x);
        assertEq(counter.number(), x);
    }

    /// @notice Testa o gás com `external`
    function test_gasReportSetNumberExternal(uint256 x) public {
        counter.setNumberExternal(x);
        assertEq(counter.number(), x);
    }

    /// @notice Testa o gás com `public`
    function test_gasReportSetNamePublic(string memory x) public {
        counter.setNamePublic(x);
        assertEq(counter.name(), x);
    }

    /// @notice Testa o gás com `external`
    function test_gasReportSetNameExternal(string memory x) public {
        counter.setNameExternal(x);
        assertEq(counter.name(), x);
    }

    /// @notice Testa o gás com `public`
    function test_gasReportSetArrayPublic(uint8[] memory x) public {
        vm.assume(x.length > 0);
        uint8 item = x[0];
        counter.setArrayPublic(x);
        assertEq(counter.array(0), item);
    }

    /// @notice Testa o gás com `external`
    function test_gasReportSetArrayExternal(uint8[] memory x) public {
        vm.assume(x.length > 0);
        uint8 item = x[0];
        counter.setArrayExternal(x);
        assertEq(counter.array(0), item);
    }
}
