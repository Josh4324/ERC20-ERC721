//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract JToken {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "JToken";
    string public symbol = "JT";
    uint8 public decimals = 18;
    address payable public owner;

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
        totalSupply = 1000000 * 10**18;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(to, amount);
        return true;
    }

    function _transfer(address recipient, uint256 amount)
        internal
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function buyToken(address receiver) external payable {
        require(msg.value > 0, "Insufficient Ether provided");
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Failed to send money");

        uint256 tokens = 1000 * msg.value;
        totalSupply -= tokens;
        balanceOf[receiver] += tokens;
        totalSupply += tokens;
    }
}
