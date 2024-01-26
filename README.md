# Hotel Management Smart Contract

This is a simple Solidity smart contract for managing a hotel. The contract allows hotel owners and staff to add details about the hotel, add staff members, and add residents. It also provides functions to retrieve hotel details and user information.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Functions](#functions)
- [License](#license)

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Amin-AQ/HotelManagement.git
   ```

2. Navigate to the project directory:

   ```bash
   cd HotelManagement
   ```

3. Open the contract file `hotel_mgmnt.sol` using a Solidity development environment like [Remix](https://remix.ethereum.org/) or your preferred development tool.

4. Deploy the smart contract to a compatible blockchain (e.g., Ethereum, Binance Smart Chain).

## Usage

- Deploy the smart contract on a blockchain network.
- Interact with the contract using a blockchain wallet or through a decentralized application (DApp).
- Utilize the provided functions to add hotel details, staff members, and residents.
- Retrieve information about the hotel and specific users.

## Functions

### `getHotelDetails()`

Returns the details of the hotel, including the name, age, and telephone number.

### `addStaff(address staffWallet, string memory name, string memory cnic)`

Allows the hotel owner to add staff members with specified wallet addresses, names, and CNICs.

### `addResident(address residentWallet, string memory name, string memory cnic, uint roomNo, uint roomCost)`

Enables staff members to add residents to the hotel, including their wallet addresses, names, CNICs, assigned room numbers, and room costs.

### `getUserDetails(address userWallet)`

Returns details about a specific user based on their wallet address, including their name, CNIC, and user type (staff or resident).

## License

This smart contract is open-source and available under the [GPL-3.0 License](LICENSE).
