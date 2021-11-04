pragma solidity ^0.8.7;

contract OnlineStore {
  function buySomething() external payable {
    // Check to make sure 0.001 ether was sent to the function call:
    require(msg.value == 0.001 ether);
    // If so, some logic to transfer the digital item to the caller of the function
    transferThing(msg.sender);
  }
}

// you would call this function from web3.js (DApp's front end) as follows
// This assumes that 'OnlineStore' points to your
// contract on Ethereum

// |-----JAVASCRIPT---------------------------------------------|

// OnlineStore.buySomething({
//   from: web3.eth.defaultAccount,
//   value: web3.utils.toWei(0.001)
// })

// |-----END----------------------------------------------------|

/**
IF WE DON'T USE THE PAYABLE MODIFIER THIS CONTRACT WILL THROW AN ERROR

 */