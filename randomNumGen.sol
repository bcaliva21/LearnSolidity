pragma solidity ^0.8.7;

// Generate a random number between 1 and 100:
contract RandomNumber {

  function getRandoNumber() internal {
  uint randNonce = 0;
  uint random = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % 100;
  randNonce++;
  uint random2 = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % 100;
  }
}

