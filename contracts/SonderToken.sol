pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC20/CappedToken.sol';

contract SonderToken is CappedToken {
  string public constant name = "Sonder";
  string public symbol = "SNR";
  uint8 public constant decimals = 18;

  uint256 public cap = 240000000 * (10 ** uint256(decimals));

  function SonderToken() CappedToken(cap) {

  }

  //protection for a case if we'll need to do some rebranding
  function changeSymbol(string sym) external onlyOwner {
    symbol = sym;
  }
}
