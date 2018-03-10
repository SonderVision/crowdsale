const SonderToken = artifacts.require('SonderToken.sol');
const CAP = new web3.BigNumber(web3.toWei(240e6, 'ether'))

contract('SonderToken', function (accounts) {
  let token;

  beforeEach(async function () {
    token = await SonderToken.new();
  });

  describe('Cap: ', () => {
    it('should start with the correct cap', async function () {
      let _cap = await token.cap();

      assert(CAP.eq(_cap));
    });

    it('should mint when amount is less than cap', async function () {
      const result = await token.mint(accounts[0], 100);
      assert.equal(result.logs[0].event, 'Mint');
    });

    it('should fail to mint if the ammount exceeds the cap', async function () {
      try {
        await token.mint(accounts[0], CAP.sub(1));
        await token.mint(accounts[0], 100);
      } catch (error) {
        return;
      }
      assert.fail('Expected throw not received');
    });

    it('should fail to mint after cap is reached', async function () {
      try {
        await token.mint(accounts[0], cap);
        await token.mint(accounts[0], 1);
      } catch (error) {
        return;
      }
      assert.fail('Expected throw not received');
    });
  })
});
