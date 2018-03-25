pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract SonderICO is Crowdsale, Ownable {
  uint minDeposit = 100;

  uint256 public startDate;

  bool public isActive = true;

  function SonderICO(address _wallet, ERC20 _token, uint256 _startDate)
    Crowdsale(14286, _wallet, _token) {
      startDate = _startDate;
  }

  modifier onlyWhileActive {
    require(isActive);
    require(now >= startDate);
    _;
  }

  function finalize() external onlyOwner {
    isActive = false;
    token.transfer(owner, token.balanceOf(this));
  }

  function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal onlyWhileActive {
    super._preValidatePurchase(_beneficiary, _weiAmount);
    require(_weiAmount >= minDeposit * (10 ** 15));
  }
}
