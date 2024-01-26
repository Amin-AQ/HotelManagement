// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract HotelManagement {

    string private hotelName;
    uint private hotelAge;
    string private hotelTelNo;
    address private hotelWallet;
    struct Hotel {
        string name;
        uint age;
        string telNo;
    }

    enum UserType {
        STAFF,
        RESIDENT
    }

    struct User {
        string userName;
        string cnic;
        UserType userType;
    }

    Hotel private hotel;
    mapping (address => User) userWalletMapping;  // maps users with unique wallet address
    mapping (uint => User) residentRoomMapping;   // checks which user is at provided room number

    constructor(string memory _name, uint _age, string memory _telNo) {
        require(_age > 0, "Age must be a positive non-zero number");
        hotel = Hotel(_name, _age, _telNo);
        hotelWallet = msg.sender;
    }

    // Get Hotel Name, Hotel Age, Hotel Tel No
    function getHotelDetails() external view returns(string memory name, uint age, string memory telNo) {
        name = hotel.name;
        age = hotel.age;
        telNo = hotel.telNo;
    }

    function addStaff(address staffWallet, string memory name, string memory cnic) external {
        require(msg.sender == hotelWallet, "Only hotel owner can call this function");
        bytes memory cnicBytes = bytes(cnic);
        bytes memory nameBytes = bytes(name);
        require(cnicBytes.length == 13, "CNIC must have 13 numbers, without dashes");
        require(nameBytes.length >= 3, "Name must have at least 3 characters");
        for (uint i; i < 13; i++) {
            require(uint8(cnicBytes[i]) >= 48 && uint8(cnicBytes[i]) <= 57, "CNIC can have only numbers");
        }
        require(staffWallet != address(0), "Provide a valid wallet address");
        User memory newStaff = User(name, cnic, UserType.STAFF);
        userWalletMapping[staffWallet] = newStaff;
    }

    function addResident(address residentWallet, string memory name, string memory cnic, uint roomNo, uint roomCost) external {
        require(userWalletMapping[msg.sender].userType == UserType.STAFF, "Only staff users can call this function");
        bytes memory cnicBytes = bytes(cnic);
        bytes memory nameBytes = bytes(name);
        require(roomCost>5, "Cost of room must be at least 5");
        require(roomNo>=0, "Room no. must be a positive number");
        require(cnicBytes.length == 13, "CNIC must have 13 numbers, without dashes");
        require(nameBytes.length >= 3, "Name must have at least 3 characters");
        for (uint i; i < 13; i++) {
            require(uint8(cnicBytes[i]) >= 48 && uint8(cnicBytes[i]) <= 57, "CNIC can have only numbers");
        }
        require(bytes(residentRoomMapping[roomNo].userName).length == 0, "Room is already occupied.");
        require(residentWallet != address(0), "Provide a valid wallet address");
        User memory newResident = User(name, cnic, UserType.RESIDENT);
        residentRoomMapping[roomNo] = newResident;
        userWalletMapping[residentWallet] = newResident;
    }

    // Function to get details of a specific user
    function getUserDetails(address userWallet) external view returns(string memory name, string memory cnic, UserType userType) {
        User storage user = userWalletMapping[userWallet];
        require(bytes(userWalletMapping[userWallet].userName).length > 0, "User does not exist");
        name = user.userName;
        cnic = user.cnic;
        userType = user.userType;
    }
}
