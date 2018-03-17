const SonderToken = artifacts.require("./SonderToken.sol");
const SonderICO = artifacts.require("./SonderICO.sol");

const wallet = '0xf17f52151EbEF6C7334FAD080c5704D77216b732';
const icoTokenAmount = 240e6;
const startDate = Date.parse('03/25/2018') / 1000; // 03/25
const phase1EndDate = Date.parse('03/28/2018') / 1000; // 03/28
const phase2EndDate = Date.parse('04/05/2018') / 1000; // 04/05
const phase3EndDate = Date.parse('04/11/2018') / 1000; // 04/11

module.exports = async function(deployer) {
  await deployer.deploy(SonderToken);
  const token = await SonderToken.deployed();
  await deployer.deploy(SonderICO, wallet, SonderToken.address, startDate, phase1EndDate, phase2EndDate, phase3EndDate);
  token.mint(SonderICO.address, web3.toWei(icoTokenAmount, 'ether'));
};
