pragma solidity ^0.4.18;

//the very seventh example
contract Banks {

    address owner;
    mapping (address => uint) accounts;

    constructor() public {
        owner = msg.sender;
    }

    function deposit(address recipient, uint value) public {
        if(msg.sender == owner) {
            accounts[recipient] += value;
        }
    }

    function transfer(address to, uint value)  public{
        if(accounts[msg.sender] >= value) {
            accounts[msg.sender] -= value;
            accounts[to] += value;
        }
    }

    function balance(address addr) public view returns (uint) {
        return accounts[addr];
    }
}

