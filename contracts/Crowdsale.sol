pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract SonderICO is Crowdsale, Ownable {
  uint256 public publicRate = 14286;
  uint256[] rates = [publicRate * 115 / 100, publicRate * 110 / 100, publicRate * 105 / 100, publicRate];
  uint[] minDeposit = [10000, 5000, 1000, 100];
  uint stage = 0;

  uint256 public startDate;
  uint256 public phase1EndDate;
  uint256 public phase2EndDate;
  uint256 public phase3EndDate;

  bool public isActive = true;

  function SonderICO(address _wallet, ERC20 _token, uint256 _startDate, uint256 _phase1EndDate, uint256 _phase2EndDate, uint256 _phase3EndDate)
    Crowdsale(rates[stage], _wallet, _token) {
      startDate = _startDate;
      phase1EndDate = _phase1EndDate;
      phase2EndDate = _phase2EndDate;
      phase3EndDate = _phase3EndDate;
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

  function getStageByTime() internal view returns (uint) {
    if (now >= phase3EndDate) return 3;
    if (now >= phase2EndDate) return 2;
    if (now >= phase1EndDate) return 1;
    return 0;
  }

  function setStage() internal {
    uint currentStage = getStageByTime();
    if (currentStage > stage) {
      stage = currentStage;
      rate = rates[stage];
    }
  }

  function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal onlyWhileActive {
    super._preValidatePurchase(_beneficiary, _weiAmount);
    setStage();
    require(_weiAmount >= minDeposit[stage] * (10 ** 15));
  }
}
