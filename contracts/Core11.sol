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

    mapping(address => User) public users;
    mapping(string => Room) public matches;

    uint256 public constant teamSize = 11;
    
    function registration(string memory _username) public{
        users[msg.sender] = User({
            username: _username,
            accountBalance: address(this).balance,
            userAddress: msg.sender
        })
    }


}
