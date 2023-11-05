// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {ERC721Token} from "../src/ERC721Token.sol";
import {ERC721AToken} from "../src/ERC721AToken.sol";

// import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
// import "../lib/ERC721A/contracts/ERC721A.sol";

contract TestERC721GasComparison is Test {
    // ERC721 public erc721Contract;
    // ERC721A public erc721aContract;
    ERC721Token public OLD;
    ERC721AToken public NEW;
    address alice;
    address bob;

    function setUp() external {
        alice = makeAddr("alice");
        bob = makeAddr("bob");
        vm.deal(alice, 1 ether);
        vm.deal(bob, 1 ether);

        OLD = new ERC721Token();
        NEW = new ERC721AToken();

        vm.startPrank(alice);
        OLD.mintERC721(0);
        NEW.mintERC721a(1);
        vm.stopPrank();

        vm.startPrank(bob);
        OLD.mintERC721(1);
        NEW.mintERC721a(1);
        vm.stopPrank();
    }

    function testMintERC721() public {
        console2.log("---Mint gas comparasion---");
        uint256 startGas = gasleft();
        console2.log("startGas: ");
        console2.log(startGas);
        vm.startPrank(alice);
        OLD.mintERC721(2);
        uint256 gasSpent = startGas - gasleft();
        console2.log("ERC721 gas spent: ");
        console2.log(gasSpent);
        NEW.mintERC721a(1);
        startGas = gasleft();
        uint256 gasSpendInERC721A = startGas - gasleft();
        console2.log("ERC721A gas spent: ");
        console2.log(gasSpendInERC721A);
        console2.log(gasleft());
        vm.stopPrank();
    }

    function testBatchMintERC721() public {
        console2.log("---Mint gas comparasion---");
        uint256 startGas = gasleft();
        console2.log("startGas: ");
        console2.log(startGas);
        vm.startPrank(alice);
        for (uint i = 2; i <= 12; i++) {
            OLD.mintERC721(i);
        }
        uint256 gasSpent = startGas - gasleft();
        console2.log("ERC721 gas spent: ");
        console2.log(gasSpent);
        NEW.mintERC721a(10);
        startGas = gasleft();
        uint256 gasSpendInERC721A = startGas - gasleft();
        console2.log("ERC721A gas spent: ");
        console2.log(gasSpendInERC721A);
        console2.log(gasleft());
        vm.stopPrank();
    }

    function testTransferERC721() public {
        vm.startPrank(alice);
        OLD.transferERC721(bob, 0);
        NEW.transferERC721a(bob, 0);
        vm.stopPrank();
    }

    function testApproveERC721() public {
        vm.startPrank(alice);
        OLD.approveERC721(bob);
        NEW.approveERC721a(bob);
    }

    function testOwnerOf() public {
        vm.startPrank(alice);
        OLD.setApprovalForAll(bob, true);
        NEW.setApprovalForAll(bob, true);
        vm.stopPrank();
    }
}
