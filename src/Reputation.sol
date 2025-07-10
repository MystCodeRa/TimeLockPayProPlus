// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ReputationModule {
    mapping(address => uint256) public reputation;
    address public admin;

    event ReputationIncreased(address indexed user, uint256 amount);
    event ReputationDecreased(address indexed user, uint256 amount);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    function decreasedReputation(address user, uint256 amount) external onlyAdmin {
        require(reputation[user] >= amount, "Insufficient reputation");
        reputation[user] -= amount;
        emit ReputationDecreased(user, amount);
    }

    function getReputation(address user) external view returns (uint256) {
        return reputation[user];
    }
}