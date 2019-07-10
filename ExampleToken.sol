pragma solidity ^0.5.0;
import './StandardToken.sol';

contract ExampleToken is StandardToken {
  string public name = "Geth-Hired";
  string public symbol = "GH";
  uint public decimals = 18;
  uint public INITIAL_SUPPLY = 10000 * (10 ** decimals);
  //uint256 public totalTokens;

  constructor() public payable {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }
}
