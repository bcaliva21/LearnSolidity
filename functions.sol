pragma solidity ^0.8.7;

contract FunFunFunctions {

// we specify that we want to store the _name parameter in memory
// some types MUST be stored in memory they are
  // arrays
  // structs
  // mappings
  // strings

// take _note of the naming convention for the function parameters
  function eatHamburgers(
    string memory _name,
    uint _amount
    ) public
    {
      // some burger eating logic here
  }
  // we invoke functions as if in JS
  eatHamburgers("Bradley", 100);
}