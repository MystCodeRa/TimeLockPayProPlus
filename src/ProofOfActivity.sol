// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProofOfActivity {
    mapping(address => uint256) public activityScore;
    mapping(address => uint256) public lastActivity;

    event ActivityRecorded(address indexed user, uint256 score);
    event ScoreBoosted(address indexed user, uint256 newScore);


    function recordActivity(address user, uint256 quality) external {
        uint256 score = quality + (block.timestamp - lastActivity[user]) / 1 days;
        activityScore[user] += score;
        lastActivity[user] = block.timestamp;
        emit ActivityRecorded(user, score);
    }

    function boostScore(address user, uint256 boost) external {
        activityScore[user] += boost;
        emit ScoreBoosted(user, activityScore[user]);
    }

    function getScore(address user) external view returns (uint256) {
        return activityScore[user];
    }
}
