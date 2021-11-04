pragma solidity ^0.8.7;

contract People {

  struct Person {
    uint age;
    string name;
  }

  Person[] public people;
  // how to make a new person
  Person bradley = Person(31, "Bradley");
  // add to an array as if in JS
  people.push(bradley);
  // we can save a line of code by doing both together
  people.push(Person(25, "Huanming"));

}