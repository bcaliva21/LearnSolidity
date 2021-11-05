pragma solidity ^0.8.7;

// Events help your contract communicate that something happened on the blockchain to your app front-end, which can be "listening" for certain events and take action when they happen.

contract Event {

  event CalculateTotal(uint x, uint y, uint result);

  function add(uint _userMoney, uint _tokenWorth) public returns (uint) {
    uint result = _userMoney + _tokenWorth;
    // fire an event to let the app know the function was called
    emit CalculateTotal(_userMoney, _tokenWorth, result);
    return result;
  }
}

// |--------JS----------------------------------------|
/**
events.CalculateTotal(function(error, result) {
  if (error) {
    stuff
  } else {
    have fun with result
  }
})

 */
// |---------END--------------------------------------|