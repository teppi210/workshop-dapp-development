pragma solidity ^0.5.1;

/**
  Delegatecall-proxy pattern
 */
 
contract Data {

  address owner;
  address public logicContract;
  mapping(address => uint) public numbers;

  constructor() public {
    owner = msg.sender;
  }

  function setLogicContract(address addr) onlyOwner public {
    logicContract = addr;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function getNumber(address addr) view public returns(uint256 num) {
    return numbers[addr];
  }

  function() external {
    logicContract.delegatecall(msg.data);
  }

}

contract Logic {

  address owner;
  address public logicContract;
  mapping(address => uint) public numbers;

  function setNumber(uint256 num) public onlyOwner {
    numbers[msg.sender] = num;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

}