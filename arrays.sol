pragma solidity ^0.8.7;

contract Arrays {
  // Array witha fixed length of 2 unsigned integer elements
  uint[2] fixedArray;
  // Array with a fixed lenght of 5 string elements
  string[5] stringArray;
  // a dynamic array with not fixed size
  uint[] dynamicArray;

  struct Person {
    uint age;
    string name;
  }

  // a dynamic array of the Person Struct
  Person[] people;

  // lastly we can add modifiers to an array
  // this modifier will make the array have a getter method
  // that is callable by anyone

  struct Animal {
    uint age;
    string name;
    string species;
  }

  Animal[] public animals;
}