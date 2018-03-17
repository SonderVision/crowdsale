const SonderToken = artifacts.require("./SonderToken.sol");
const SonderICO = artifacts.require("./SonderICO.sol");

module.exports = async function(deployer) {
  const testWallet = '0xf17f52151EbEF6C7334FAD080c5704D77216b732';
  await deployer.deploy(SonderToken);
  deployer.deploy(SonderICO, testWallet, SonderToken.address);
};
