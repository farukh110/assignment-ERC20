pragma solidity ^0.6.0;

//start openzeppelin library

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

//end openzeppelin library

contract TimeboundToken is ERC20{
    
    address public owner;
    
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Permission Denied: Only owner can access this activity");
        _;
    }
    
    uint256 public cap;
    
    uint256 timeTillTransactionLock;
    
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
    
    function lockTransferUntil(uint256 time) public {
        require(time>0 && time > now,"Invalid Time: time must be greater current");    
        timeTillTransactionLock = time;
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override virtual { 
        require(timeTillTransactionLock <  now,"Transaction is Locked. Please try again" );
        
    }
    
}
