const SonderToken = artifacts.require("./SonderToken.sol");
const SonderICO = artifacts.require("./SonderICO.sol");

const wallet = '0xf17f52151EbEF6C7334FAD080c5704D77216b732';
const icoTokenAmount = 240e6;
const startDate = Date.parse('05/21/2018') / 1000; // 05/21

module.exports = async function(deployer) {
  await deployer.deploy(SonderToken);
  const token = await SonderToken.deployed();
  await deployer.deploy(SonderICO, wallet, SonderToken.address, startDate);
  token.mint(SonderICO.address, web3.toWei(icoTokenAmount, 'ether'));
};
