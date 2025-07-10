// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ProofOfActivity.sol";

contract TimeLockVault {
    IERC20 public usdc;
    ProofOfActivity public poa;

    struct Deposit {
        uint256 amount;
        uint256 unlockTime;
        bool claimed;
    }

    mapping(address => Deposit[]) public deposits;

    event Deposited(address indexed employer, address indexed employee, uint256 amount, uint256 unlockTime);
    event Claimed(address indexed employee, uint256 index, uint256 amount);
    event PaymentReclaimed(address indexed employee, uint256 amount);

    constructor(address _usdc, address _poa) {
        usdc = IERC20(_usdc);
        poa = ProofOfActivity(_poa);
    }

    function deposit(address employee, uint256 amount) external {
        require(amount > 0, "Amount must be > 0");

        uint256 unlockTime = block.timestamp + 30 days;

        deposits[employee].push(Deposit({
            amount: amount,
            unlockTime: unlockTime,
            claimed: false
        }));

        require(usdc.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        poa.recordActivity(employee, 1);

        emit Deposited(msg.sender, employee, amount, unlockTime);
    }

    function claim(uint256 index) external {
        require(index < deposits[msg.sender].length, "Invalid index");

        Deposit storage userDeposit = deposits[msg.sender][index];
        require(!userDeposit.claimed, "Already claimed");
        require(block.timestamp >= userDeposit.unlockTime, "Funds are still locked");

        userDeposit.claimed = true;
        require(usdc.transfer(msg.sender, userDeposit.amount), "Transfer failed");

        emit Claimed(msg.sender, index, userDeposit.amount);
    }

    function reclaimExpired(address employee, uint256 index) external {
        require(index < deposits[employee].length, "Invalid index");

        Deposit storage userDeposit = deposits[employee][index];
        require(!userDeposit.claimed, "Already claimed");
        require(block.timestamp >= userDeposit.unlockTime + 1 days * 30, "Grace period not passed");

        userDeposit.claimed = true;
        require(usdc.transfer(msg.sender, userDeposit.amount), "Transfer failed");

        emit PaymentReclaimed(employee, userDeposit.amount);
    }

    function getDeposits(address employee) external view returns (Deposit[] memory) {
        return deposits[employee];
    }
}
