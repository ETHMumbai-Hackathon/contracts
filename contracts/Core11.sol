// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Core11 {
    struct User {
        string username;
        address userAddress;
        uint256 accountBalance;
        bool userExists;
        uint256[] team;
    }

    struct Room {
        string name;
        address creator;
        uint256 prizePool;
        mapping(address => bool) players;
        uint256 entryFee;
        address[] playersArray;
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
            userExists: true,
            team: new uint256[](teamSize)
        });
    }

    function checkUser(address _user) public view returns (bool) {
        return users[_user].userExists;
    }

    function getEntryFee() public pure returns (uint256) {
        return entryFee;
    }

    function createTeam(uint256[] memory _team) public {
        require(users[msg.sender].userExists, "User is already registered.");
        require(_team.length == teamSize, "There should be 11 players");
        users[msg.sender].team = _team;
    }

    function createMatch(string memory name) public payable {
        require(users[msg.sender].userExists, "user is not regisstered");
        require(msg.value == entryFee, "Entry fee must be 1 ether");
        matches[name].name = name;
        matches[name].creator = msg.sender;
        matches[name].entryFee = entryFee;
        matches[name].prizePool = msg.value;
        matches[name].entryFee = entryFee;
        matches[name].prizePool = msg.value;
    }

    function joinMatch(string memory _name) public payable {
        require(users[msg.sender].userExists, "User is not registered");
        Room storage room = matches[_name];
        require(room.entryFee == entryFee, "Entry fee must be 1 ether ");
        require(!room.players[msg.sender], "User already joined the battle");
        room.players[msg.sender] = true;
        room.prizePool += msg.value;
    }

    function getTeam(address _user) public view returns (uint256[] memory) {
        require(users[_user].userExists, "User is not registered");
        return users[_user].team;
    }

    function getMatchPlayers(
        string memory matchName
    ) public view returns (address[] memory) {
        Room storage gmatch = matches[matchName];
        uint256 totalUsers = gmatch.playersArray.length;
        address[] memory playerAddress = new address[](totalUsers);

        for (uint256 i = 0; i < totalUsers; i++) {
            playerAddress[i] = gmatch.playersArray[i];
        }

        return playerAddress;
    }

    function endMatch(string memory _name, uint256[] memory _stats) public {
        require(users[msg.sender].userExists, "User not registered");
        Room storage game = matches[_name];
        require(game.creator == msg.sender, "Not authorized");
        uint256 maxScore = 0;
        address winner;
        for (uint256 i = 0; i < teamSize; i++) {
            address playerAddress = users[game.playersArray[i]].userAddress;
            uint256 score = _stats[i];
            if (score > maxScore) {
                maxScore = score;
                winner = playerAddress;
            }
        }
        payable(winner).transfer(game.prizePool);

        delete matches[_name];
    }
}
