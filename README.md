# ⏳ TimeLockPay Pro+ Smart Contracts

This repository contains the **backend smart contracts** for **TimeLockPay Pro+**, a decentralized payroll platform utilizing **time-locked USDC**, AI-driven activity scoring, and a fair reputation-based bonus system for contributors.

> 💻 Tested on: **Local Foundry Network**  
> 🌐 Live App: [TimeLockPay Pro+ Dashboard](https://timelockpayroll.netlify.app)

---

## 🔍 Features

- **Salary with Expiry:** Salaries are usable for 30 days only; after expiration, unused funds are locked or returned to the DAO.
- **TimeLockVault.sol:** Stores salary funds and enforces time-based claim rules.
- **ProofOfActivity.sol:** Tracks contributor behavior and calculates activity scores.
- **BonusManager.sol:** Distributes performance-based bonuses.
- **DAOManager.sol:** Redirects expired funds back to DAO-controlled addresses.

---

## ⚙️ Tech Stack

- Solidity (v0.8.x)
- Foundry (Forge)
- Hardhat-compatible test logic
- OpenZeppelin contracts

---
