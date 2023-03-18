# PoolxToken
[![Build Status](https://api.travis-ci.com/The-Poolz/poolztoken.svg)](https://app.travis-ci.com/github/The-Poolz/PoolzToken)
[![CodeFactor](https://www.codefactor.io/repository/github/the-poolz/poolztoken/badge)](https://www.codefactor.io/repository/github/the-poolz/poolztoken/)
[![codecov](https://codecov.io/gh/The-Poolz/poolztoken/branch/master/graph/badge.svg)](https://app.codecov.io/gh/The-Poolz/PoolzToken)
#### [**The Poolz**](https://poolz.finance/) official Token
The **POOLX** smart contract implements the **ERC20** standard. In addition to the default functions, the contract has the features of minting, burning, and capped the number of tokens. The token works in tandem with the [MultiSig](https://github.com/The-Poolz/MultiSig/) contract to provide a secure minting system. 
 
 ### Navigation

- [Installation](#installation)
- [Details](#token-details)
- [Contract relations](#uml)
- [Settings](#settings)

#### Installation

```console
npm install
```

#### Testing

```console
truffle run coverage
```

#### Deployment

```console
truffle dashboard
```

```console
truffle migrate --network dashboard
```

 ### Token Details

* **Name:** Poolz Finance

* **Symbol:** POOLX

* **Decimals:** 18

* **Maximum Supply:** 5,500,000 POOLX

### UML
![classDiagram](https://user-images.githubusercontent.com/68740472/225975280-a6958c37-4027-475a-82c2-37c8116823e1.svg)

## Settings
The **POOLX** contract includes the following functions:
```solidity
function transfer(address to, uint256 amount) public virtual override returns (bool)
```
Transfer allows the sender (the owner of the tokens) to transfer a specified amount of tokens to a specified recipient address. The function first checks if the owner has sufficient balance to complete the transfer, and if so, transfers the amount of tokens from the owner's address to the recipient's address. The function then returns a boolean value of true to indicate that the transfer was successful.

```solidity
function balanceOf(address account) public view virtual override returns (uint256)
```
The `balanceOf` function returns the token balance of the given address. The balances of each account are maintained in a mapping. This function just returns the uint256 balance data from the mapping.


```solidity
function burn(uint256 amount) public virtual
```

This function that can be called by a user to burn (destroy) a specified amount of their own tokens.

### MultiSig settings
```solidity
function mint(address to, uint256 amount) external onlyMinter
```
The `mint` function is a external function that can be called by the [MultiSig](https://github.com/The-Poolz/MultiSig/) contract with the Minter role to mint new tokens.

```solidity
function addMinter(address account) external onlyMinter
```
An external function that can be called by a user with the Minter role to add a new address to the Minter role. If all checks are passed, the account is added to the Minter role.

```solidity
function renounceMinter() external onlyMinter
```
`renounceMinter` is a external function that a user with the Minter role can call to renounce (remove) their own Minter role.

```solidity
function isMinter(address account) external view returns (bool) 
```
`isMinter` is a view function that any user can call to check if the specified account has the Minter role (by default, the Minter role has a MultiSig contract). It returns a boolean indicating whether the account has the Minter role.

## License
The Poolz contract is released under the MIT License.