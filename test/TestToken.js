const Token = artifacts.require("./POOLX.sol")
const truffleAssert = require("truffle-assertions")
const BigNumber = require("bignumber.js")
const { constants } = require("@openzeppelin/test-helpers")

contract("Token", (accounts) => {
    const name = "Poolz Finance"
    const symbol = "POOLX"
    const decimals = 18
    const amount = new BigNumber(100 * 10 ** decimals)
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

        it("currect name", async () => {
            const tokenName = await token.name()
            assert.equal(name, tokenName, "invalid token name")
        })

        it("has 18 decimals", async () => {
            const tokenDecimals = await token.decimals()
            assert.equal(decimals.toString(), tokenDecimals.toString(), "invalid decimals number")
        })
    })

    describe("Mint", () => {
        it("check totalSupply after mint", async () => {
            const totalSupplyBefore = await token.totalSupply()
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const totalSupplyAfter = await token.totalSupply()
            assert.equal(BigNumber.sum(amount, totalSupplyBefore).toString(), totalSupplyAfter.toString())
        })

        it("check totalSupply after mint", async () => {
            const totalSupplyBefore = await token.totalSupply()
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const totalSupplyAfter = await token.totalSupply()
            assert.equal(BigNumber.sum(totalSupplyBefore, amount).toString(), totalSupplyAfter.toString())
        })

        it("cap exceeded", async () => {
            const amount = await token.cap()
            await truffleAssert.reverts(
                token.mint(accounts[1], amount.toString() + 1, { from: accounts[0] }),
                "ERC20Capped: cap exceeded"
            )
        })

        it("caller does not have the Minter role", async () => {
            await truffleAssert.reverts(
                token.addMinter(accounts[2], { from: accounts[1] }),
                "MinterRole: caller does not have the Minter role"
            )
            await truffleAssert.reverts(
                token.mint(accounts[1], amount, { from: accounts[1] }),
                "MinterRole: caller does not have the Minter role"
            )
        })

        it("add minter role", async () => {
            const tx = await token.addMinter(accounts[2])
            const accountAddress = tx.logs[0].args.account.toString()
            assert.equal(accountAddress, accounts[2], "invalid account log event")
            const isMinter = await token.isMinter(accounts[2])
            assert.equal(isMinter, true, "user doens't have minter role")
        })

        it("remove minter role", async () => {
            await token.addMinter(accounts[1])
            const tx = await token.renounceMinter({ from: accounts[1] })
            const accountAddress = tx.logs[0].args.account.toString()
            assert.equal(accountAddress, accounts[1], "invalid account log event")
            const isMinter = await token.isMinter(accounts[1])
            assert.equal(isMinter, false, "user doens't have minter role")
        })

        it("account already has role", async () => {
            const minterAddress = accounts[9]
            await token.addMinter(minterAddress)
            await truffleAssert.reverts(token.addMinter(minterAddress), "Roles: account already has role")
        })

        it("account is the zero address", async () => {
            await truffleAssert.reverts(token.addMinter(constants.ZERO_ADDRESS), "Roles: account is the zero address")
        })
    })

    describe("Transfer", () => {
        it("check balance after transfer", async () => {
            await token.mint(accounts[1], amount, { from: accounts[0] })
            const balance2before = await token.balanceOf(accounts[2])
            await token.transfer(accounts[2], amount, { from: accounts[1] })
            const balance2after = await token.balanceOf(accounts[2])
            assert.equal(BigNumber.sum(balance2before, amount).toString(), balance2after.toString())
        })
    })
})
