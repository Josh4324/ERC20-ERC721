//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./ERC20.sol";

contract JToken is ERC20 {
    uint256 public totalFixedSupply;
    address payable public owner;
    mapping(address => uint256) public balance;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = payable(msg.sender);
        totalFixedSupply = 1000000 * 10**18;
    }

    function buyToken(address receiver) public payable {
        require(msg.value > 0, "Insufficient Ether provided");
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Failed to send money");

        uint256 tokens = 1000 * msg.value;
        totalFixedSupply -= tokens;
        balance[receiver] += tokens;
        totalFixedSupply += tokens;
    }
}
