// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Script.sol";

import "../src/MockERC20.sol";
import "../src/ProofOfActivity.sol";
import "../src/Reputation.sol";
import "../src/DAOManager.sol";
import "../src/BonusManager.sol";
import "../src/TimeLockVault.sol"; 
import "../src/IcarvAI.sol"; 

contract DeployTimeLockPay is Script {
    function run() external {
        vm.startBroadcast();

        MockERC20 usdc = new MockERC20(1_000_000 ether);
        console.log("MockERC20 deployed at:", address(usdc));

        ProofOfActivity poa = new ProofOfActivity();
        console.log("ProofOfActivity deployed at:", address(poa));

        ReputationModule rep = new ReputationModule();
        console.log("ReputationModule deployed at:", address(rep));

        DAOManager dao = new DAOManager(address(0)); 
        console.log("DAOManager deployed at:", address(dao));

        BonusManager bonus = new BonusManager(address(usdc));
        console.log("BonusManager deployed at:", address(bonus));

    
        TimeLockVault vault = new TimeLockVault(address(usdc), address(poa));
        console.log("TimeLockVault deployed at:", address(vault));

    
         IcarvAI icarvAI = new IcarvAI(...);
         console.log("IcarvAI deployed at:", address(icarvAI));

        vm.stopBroadcast();
    }
}
