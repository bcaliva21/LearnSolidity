pragma solidity ^0.8.7;

// TLDR
// storage is to harddisk as memory is to RAM
// storage => permanently stores to the blockchain
// memory => temporary place to store data

contract SandwichFactory {
    struct Sandwich {
        string name;
        string status;
    }

    Sandwich[] sandwiches;

    function eatSandwich(uint _index) public {
        // Sandwich mySandwich = sandwiches[_index];

        // Seems like this should work, but you will get a warning from solidity
        // telling you that you should explicitly declare 'storage' or 'memory' here

        // we can handle it like so:
        Sandwich storage mySandwich = sandwiches[_index];
        // mySandwich points to sandwiches[_index] in storage
        // we can change this permanently by reassigning it to whatever we want
        mySandwich.status = "Eaten!";

        // but what if we don't want to permanently change it???
        Sandwich memory anotherSandwich = sandwiches[_index + 1];
        // now this is a copy of the data in memory
        // so when we reassign this...
        anotherSandwich.status = "Eaten!";
        // it's just a temporary var
        // it WILL NOT CHANGE on the blcokchain

        // but...
        // if we did the following logic, it WOULD change it
        sandwiches[_index + 1] = anotherSandwich;

    }
}
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the 
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect 
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}