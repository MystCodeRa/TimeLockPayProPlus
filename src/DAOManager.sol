// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DAOManager {
    address public dao;
    mapping(address => bool) public approvedEmployers;

    event EmployerApproved(address employer);
    event EmployerRevoked(address employer);

    modifier onlyDAO() {
        require(msg.sender == dao, "Only DAO");
        _;
    }

    constructor(address _dao) {
        dao = _dao;
    }

    function approveEmployer(address employer) external onlyDAO {
        approvedEmployers[employer] = true;
        emit EmployerApproved(employer);
    }

    function revokeEmployer(address employer) external onlyDAO {
        approvedEmployers[employer] = false;
        emit EmployerRevoked(employer);
    }

    function isApproved(address employer) external view returns (bool) {
        return approvedEmployers[employer];
    }
}
