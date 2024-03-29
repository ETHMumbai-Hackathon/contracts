// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Core11 {
    struct User {
        string username;
        address userAddress;
        uint256 accountBalance;
    }

    struct Room {
        string name;
        string creator;
        uint256 prizePool;
        mapping(address => bool) players;
    }
}
