// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18;
interface IERC20Bonus {
    function transfer(address to, uint amount) external returns (bool);
}

contract BonusManager {
    address public employer;
    IERC20Bonus public usdc;

    event BonusSent(address indexed employee, uint amount);

    constructor(address _usdc) {
        employer = msg.sender;
        usdc = IERC20Bonus(_usdc);
    }

    modifier onlyEmployer() {
        require(msg.sender == employer, "Only employer");
        _;
    }

    function SendBonus(address employee, uint amount) external onlyEmployer {
        require(usdc.transfer(employee, amount), "Bonus transfer failed");
        emit BonusSent(employee, amount);
    }
}