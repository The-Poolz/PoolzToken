pragma solidity 0.5.2;
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol';

contract POOLZ is ERC20Capped, ERC20Detailed{
       constructor()
       ERC20Detailed("Poolz Finance","POOLZ",18)
       ERC20Capped(5000000*10**18)
       public {}     
}
