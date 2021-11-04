pragma solidity ^0.8.7;

contract FunFunFunctions {

  uint[] numbers;
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

  // this is a simple private function.
  // this means only other functiosn within our contract will be able to call this

  // once again, pay attention to the naming convention for private functions
  function _addToArray(uint _number) private {
    numbers.push(_number);
  }

  // if we declare a function that returns something we need to specify that in it's declaration
  function sayHello() public returns (string memory) {
    string greeting = "Hello Solidity";
    return greeting;
  }
  // we invoke functions as if in JS
  eatHamburgers("Bradley", 100);
}