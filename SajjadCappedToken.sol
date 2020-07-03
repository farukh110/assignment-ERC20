pragma solidity ^0.6.0;

//start openzeppelin library

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

//end openzeppelin library

contract SajjadCappedToken is ERC20{
    
    address public owner;
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Permission Denied: Only owner can access this activity");
        _;
    }
    
    uint256 public cap;
    
    constructor() ERC20("Sajjad Capped Token","SCT")
    public{
        owner = msg.sender;
        _setupDecimals(5);
        
        //10000
        uint initialSupply = 10000 * (10 ** uint256(decimals())); 
        
        //cap 
        cap=initialSupply.mul(5);
        
        _mint(owner,initialSupply);
    }
    
    function generateTokens(address account, uint256 amount) public onlyOwner{
        require(account != address(0),"Error: Invalid address");
        require(amount > 0,"Invalid amount");
        require(totalSupply().add(amount)<cap,"Overlimit tokens: Token Generation failed");
        _mint(account,amount);
    }
    
    
}
