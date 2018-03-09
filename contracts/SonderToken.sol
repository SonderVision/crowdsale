pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC20/CappedToken.sol';

contract TestToken is CappedToken {
  string public constant name = "Sonder";
  string public constant symbol = "SNR";
  uint8 public constant decimals = 18;

  uint256 public cap = 240000000 * (10 ** uint256(decimals));
}
