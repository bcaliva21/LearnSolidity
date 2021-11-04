pragma solidity ^0.8.7;

import "./ZombieTutorial/ownable.sol";

contract GetPaid is Ownable {
  function withdraw()
  external
  onlyOwner
  {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }

// we can run this if, for example, a user overpaid

  // uint itemFee = 0.001 ether;
  // msg.sender.transfer(msg.value - itemFee);

}