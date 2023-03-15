const Token = artifacts.require("./POOLZ.sol")
const truffleAssert = require("truffle-assertions")

const name = "Poolz.finance Token"
const symbol = "POOLX"
const decimals = 6
const amount = 100 * 10 ** decimals

contract("Token", (accounts) => {
    let token

    beforeEach("test", async () => {
        token = await Token.new()
    })

    describe("Constructor", () => {
        it("has symbol", async () => {
            const response = await token.symbol()
            assert.equal(response, symbol, "wrong symbol")
        })

        it("has initial supply equal zero", async () => {
            const response = await token.totalSupply()
            assert.equal(response, 0, "initial supply must be zero")
        })
    })

    describe("Mint", () => {
        it("check totalSupply after mint", async () => {
            const totalSupplyBefore = await token.totalSupply()
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const totalSupplyAfter = await token.totalSupply()
            assert.equal(Number(totalSupplyBefore + amount), Number(totalSupplyAfter))
        })

        it("check totalSupply after mint", async () => {
            const totalSupplyBefore = await token.totalSupply()
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const totalSupplyAfter = await token.totalSupply()
            assert.equal(Number(totalSupplyBefore + amount), Number(totalSupplyAfter))
        })

        it("cap exceeded", async () => {
            const amount = await token.cap()
            await truffleAssert.reverts(
                token.mint(accounts[1], amount.toString() + 1, { from: accounts[0] }),
                "ERC20Capped: cap exceeded"
            )
        })
    })

    describe("Transfer", () => {
        it("check balance after transfer", async () => {
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const balance2before = await token.balanceOf(accounts[2])
            await token.transfer(accounts[2], amount, { from: accounts[1] })
            const balance2after = await token.balanceOf(accounts[2])
            assert.equal(Number(balance2before + amount), Number(balance2after))
        })
    })
})
