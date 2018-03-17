pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract SonderICO is Crowdsale {
  uint256 public publicRate = 14286;
  uint256 public bonus1Rate = publicRate * 115 / 100;
  uint256 public bonus2Rate = publicRate * 110 / 100;
  uint256 public bonus3Rate = publicRate * 105 / 100;

  function SonderICO(address _wallet, ERC20 _token) Crowdsale(bonus1Rate, _wallet, _token) {
  }
}
