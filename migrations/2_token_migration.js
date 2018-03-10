var SonderToken = artifacts.require("./SonderToken.sol");

module.exports = function(deployer) {
  deployer.deploy(SonderToken);
};
