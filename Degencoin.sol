// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable {
    address private _owner;
    address  public minter = 0xb6B5ed54Dc1faBEBfe3358B7F77A287DE9E359d2;
    string public rewards = "1 --> Iron sword : 400, 2 --> Golden sword  :  900, 3 --> Diamond sword :  1500";
    constructor() ERC20("Degen", "DGN") {
        _owner = msg.sender;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }
    
    function burn(uint256 amount) public{
        _burn(msg.sender, amount);
    }

    function transfer(address receiver, uint256 amount) public override returns (bool) {
        require(amount <= balanceOf(msg.sender), "Insufficient balance of tokens");
        _transfer(_owner, receiver, amount);
        return true;
    }

    function choose_item(uint256 item_num) external payable {
        redeem(item_num);
        }

    function redeem(uint256 item_num) public payable {
        require(item_num >= 1 && item_num <= 3, "Invalid item number");

        if (item_num == 1) {
            require(balanceOf(msg.sender) >= 400,"Insufficient balance for Iron sword");
            _transfer(msg.sender, minter, 400);
            console.log("Iron sword transfered to your account");
        } 
        else if (item_num == 2) {
            require(
                balanceOf(msg.sender) >= 900,
                "Insufficient balance for Golden sword"
            );
            _transfer(msg.sender, minter, 900);
            console.log("Golden sword transfered to your account");

           
        } else if (item_num == 3) {
            require(
                balanceOf(msg.sender) >= 1500,
                "Insufficient balance for Diamond Sword"
            );
            
            _transfer(msg.sender , minter, 1500);
            console.log("Diamond sword transfered to your account");

            
        }

        
    }
  
}
