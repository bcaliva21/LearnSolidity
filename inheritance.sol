pragma solidity ^0.8.7;

// Inheritance works as expected in solidity
// syntax is quite simple 


contract Doge {
    function catchphrase() pure public returns (string memory) {
        return "WOOF WOOF";
    }
}

// BabyDoge has everything Doge has
contract BabyDoge is Doge {
    function babyCatchphrase() pure public returns (string memory) {
        return "woof woof";
    }
}

// If you are inheriting from multiple contracts and they 
// share function names you need to provide an override modifier
// so the compilier won't throw an error from confusion

// still not 100% on why this is necessary, I'm assuming when you are inheriting
// from multiple contracts there might be some clashes so this
// is good to have in your back pocket

contract First {
    function hello() 
        virtual public 
        returns(string memory) {
            return "Ni Hao";
    }
}

contract Second {
    function hello()
        virtual public
        returns(string memory) {
            return "Hola";
        }
}

contract Inheritor is First, Second {
    function hello()
        pure public override(First, Second)
        returns(string memory) {
            return "Hello";
        }
}
