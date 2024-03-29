// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Core11 {
    struct User {
        string username;
        address userAddress;
        uint256 accountBalance;
        bool userExists;
    }

    struct Room {
        string name;
        string creator;
        uint256 prizePool;
        mapping(address => bool) players;
    }

    uint256 public constant entryFee = 1 ether;

    mapping(address => User) public users;
    mapping(string => Room) public matches;

    uint256 public constant teamSize = 11;

    function registration(string memory _username) public {
        users[msg.sender] = User({
            username: _username,
            accountBalance: address(this).balance,
            userAddress: msg.sender,
            userExists: true
        });
    }

    function checkUser(address _user) public view returns (bool) {
        return users[_user].userExists;
    }

    function getEntryFee() public pure returns (uint256) {
        return entryFee;
    }
}
