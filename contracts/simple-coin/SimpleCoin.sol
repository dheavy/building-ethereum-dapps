// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleCoin {
    mapping (address => uint256) public coinBalance;
    mapping (address => mapping(address => uint256)) public allowance;
    mapping (address => bool) public frozenAccount;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event FrozenAccount(address target, bool frozen);

    modifier onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }

    constructor(uint256 initialSupply) {
        owner = msg.sender;
        mint(owner, initialSupply);
    }

    function transfer(address to, uint256 amount) public {
        require(to != 0x0);
        require(coinBalance[msg.sender] > amount);
        require(coinBalance[to] + amount >= coinBalance[to]);

        coinBalance[msg.sender] -= amount;
        coinBalance[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }

    function authorize(address authorizedAccount, uint256 allowance) public returns (bool success) {
        allowance[msg.sender][authorizedAccount] = allowance;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool success) {
        require(to != 0x0);
        require(coinBalance[from] > amount);
        require(coinBalance[to] + amount >= coinBalance[to]);
        require(amount <= allowance[from][msg.sender]);

        coinBalance[from] -= amount;
        coinBalance[to] += amount;
        allowance[from][msg.sender] -= amount;

        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address recipient, uint256 mintedAmount) onlyOwner public {
        coinBalance[recipient] += mintedAmount;

        emit Transfer(owner, recipient, mintedAmount);s
    }

    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;

        emit FrozenAccount(target, freeze);
    }
}
