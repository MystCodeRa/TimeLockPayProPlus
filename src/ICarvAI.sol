// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface ICarvAI {
    function submitActivityData(address employee, uint256 activityScore) external;
}
