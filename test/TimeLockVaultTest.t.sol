// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@src/TimeLockVault.sol";
import "@src/MockERC20.sol";
import "@src/ProofOfActivity.sol";

contract TimeLockVaultTest is Test {
    TimeLockVault public vault;
    MockERC20 public usdc;
    ProofOfActivity public poa;

    address employer = address(0x1);
    address employee = address(0x2);

    function setUp() public {
        usdc = new MockERC20(1_000_000 ether);
        poa = new ProofOfActivity();
        vault = new TimeLockVault(address(usdc), address(poa));

        usdc.transfer(employer, 1000 ether);
        vm.prank(employer);
        usdc.approve(address(vault), 1000 ether);
    }

    function testDepositAndClaim() public {
        vm.prank(employer);
        vault.deposit(employee, 100 ether);

        vm.warp(block.timestamp + 30 days);

        vm.prank(employee);
        vault.claim(0);

        assertEq(usdc.balanceOf(employee), 100 ether);
    }

    function testReclaimAfter30Days() public {
        vm.prank(employer);
        vault.deposit(employee, 100 ether);

        vm.warp(block.timestamp + 60 days); 

        vm.prank(employer);
        vault.reclaimExpired(employee, 0);

        assertEq(usdc.balanceOf(employer), 100 ether);
    }

    function testActivityScoreIncreasesOnDeposit() public {
        vm.prank(employer);
        vault.deposit(employee, 100 ether);

        uint256 score = poa.getScore(employee);
        assertGt(score, 0, "Activity score should increase after deposit");
    }
}
