pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract SonderICO is Crowdsale, Ownable {
  uint256 public publicRate = 14286;
  uint256 public bonus1Rate = publicRate * 115 / 100;
  uint256 public bonus2Rate = publicRate * 110 / 100;
  uint256 public bonus3Rate = publicRate * 105 / 100;

  uint256 public startDate;
  uint256 public phase1EndDate;
  uint256 public phase2EndDate;
  uint256 public phase3EndDate;

  bool public isActive = true;

  function SonderICO(address _wallet, ERC20 _token, uint256 _startDate, uint256 _phase1EndDate, uint256 _phase2EndDate, uint256 _phase3EndDate)
    Crowdsale(bonus1Rate, _wallet, _token) {
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

  function isValidRate() internal view returns (bool) {
    if (now >= phase3EndDate) return rate == publicRate;
    if (now >= phase2EndDate) return rate <= bonus3Rate;
    if (now >= phase1EndDate) return rate <= bonus2Rate;
    return true;
  }

  function currentStage() public view returns (uint) {
    if (now >= phase3EndDate) return 4;
    if (now >= phase2EndDate) return 3;
    if (now >= phase1EndDate) return 2;
    if (now >= startDate) return 1;
    return 0;
  }

  function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal onlyWhileActive {
    super._preValidatePurchase(_beneficiary, _weiAmount);
    //todo check if there's some tokens left

    if (!isValidRate()) {
      uint stage = currentStage();
      if (stage == 4) {
        rate = publicRate;
      } else if (stage == 3) {
        rate = bonus3Rate;
      } else if (stage == 2) {
        rate = bonus2Rate;
      } else if (stage == 1) {
        rate = bonus1Rate;
      }
    }
  }
}
