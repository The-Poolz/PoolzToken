const POOLX = artifacts.require("POOLX")

module.exports = function(deployer) {
  deployer.deploy(POOLX)
}
