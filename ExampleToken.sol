pragma solidity ^0.5.0;
import './StandardToken.sol';

contract ExampleToken is StandardToken {
  string public name = "BlockHire";
  string public symbol = "BH";
  uint public decimals = 18;
  uint public INITIAL_SUPPLY = 10000 * (10 ** decimals);
  //uint256 public totalTokens;

  constructor() public payable {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }
}