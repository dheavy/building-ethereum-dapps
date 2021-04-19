// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../common/Ownable.sol";
import "./ERC20.sol";

contract SimpleCoin is ERC20, Ownable {
    mapping (address => uint256) public coinBalance;
    mapping (address => mapping(address => uint256)) public allowances;
    mapping (address => bool) public frozenAccount;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event FrozenAccount(address target, bool frozen);

    constructor(uint256 _initialSupply) public {
        owner = msg.sender;
        mint(owner, _initialSupply);
    }

    function balanceOf(address _owner) override public view returns (uint256 balance) {
        return coinBalance[_owner];
    }

    function approve(address _spender, uint256 _value) override public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) override public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

    function transfer(address _to, uint256 _value) override virtual public returns (bool success) {
        require(_to != address(0));
        require(coinBalance[msg.sender] > _value);
        require(coinBalance[_to] + _value >= coinBalance[_to]);

        coinBalance[msg.sender] -= _value;
        coinBalance[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) override virtual public returns (bool success) {
        require(_to != address(0));
        require(coinBalance[_from] > _value);
        require(coinBalance[_to] + _value >= coinBalance[_to]);
        require(_value <= allowances[_from][msg.sender]);

        coinBalance[_from] -= _value;
        coinBalance[_to] += _value;
        allowances[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function mint(address _recipient, uint256 _mintedAmount) onlyOwner public {
        coinBalance[_recipient] += _mintedAmount;

        emit Transfer(owner, _recipient, _mintedAmount);
    }

    function freezeAccount(address _target, bool _freeze) onlyOwner public {
        frozenAccount[_target] = _freeze;

        emit FrozenAccount(_target, _freeze);
    }
}
