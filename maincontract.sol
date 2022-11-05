// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ierctoken.sol";

contract tech4dev is IERC20{
   
   uint public override totalSupply = 10**6 * 10**18; //total supply the token is to have
   mapping(address => uint) public override balanceOf; //getting the balance of owner
   mapping(address => mapping(address => uint)) public override allowance; //to get the address of the spender and the amount
   string public name = "tech4dev Token"; //name thet will appear for token
   string public symbol = "T4D";        //symbol to be used by token
   uint public decimals = 18;         

   function transfer(address recipient, uint amount) external override returns(bool){ //indicate the amount deducted from the address of the person calling the contract
   balanceOf[msg.sender] -= amount; //deducting the amount from sender

   balanceOf[recipient] += amount;//indicate the deducted token from the address 
   //balanceOf[recipient] = balanceOf[recipient] + amount;
   emit Transfer(msg.sender, recipient,amount); // to show if the transfer is succesful from the owner
   return true; // to return true when transaction is succesful on this function

   }

 function approve(address spender, uint amount)external override returns(bool){ // approve to take out a certain amount of money by the spender
   allowance[msg.sender][spender] = amount; // allowing the spender to get access to money from the owner 
   emit Approval(msg.sender, spender, amount); // the emit keyword broadcast the approval made
   return true; // return true when transaction is succesful

}
// approve transfer to 3rd party account
function transferFrom(address sender, address recipient, uint amount) external override returns(bool){
   allowance[sender][msg.sender] -= amount; //to check amount allowed to be sent
   balanceOf[sender] -= amount; //deducting the amount from the sender
   balanceOf[recipient] += amount; //an added amount to the recipient in line with the amount indicated
   emit Transfer(sender, recipient, amount); //conditions meant to then broadcast the address of the sender
    return true; //return true when function is succesful

}
  function mint(uint amount) public { //adding amount to the owner, created token which contains an input
    balanceOf[msg.sender] += amount; // balance of the person calling the contract and adding amount
    totalSupply += amount; // adding same amount to total supply
    emit Transfer(address(0), msg.sender, amount); // broadcasting the function

  }

  function burn(uint amount)public {   // to remove a certain amount from circulation
     balanceOf[msg.sender] -= amount; //deduction from the total supply
     totalSupply -= amount; // to enable a deduction in the total supply created token, whwn the burn fucntion is called
     emit Transfer(msg.sender, address(0), amount);// broadcasting a function has been called



  }



 }
