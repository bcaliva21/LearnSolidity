pragma solidity ^0.8.7;

//---------------LINK_COIN_CONTRACT-------------------------------|
// STOLEN DIRECTLY FROM ETHERSCAN TO STUDY TOKEN MAKING
//---------------END_RANT-----------------------------------------|



/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */

library SafeMath {

// I see they use assert here...
    // if I understand this correctly (caveat, I'm an idiot) 
    // you could use the other options below as well
    // require(logic)
    // if(logic) throw;
    function mul(uint256 a, uint256 b) internal constant returns (uint256) {
        uint256 c = a * b;
        assert(a ==0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal constant returns (uint256) {
        // assert(b > 0); // solidity auto throws an error when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // ???
        // LINK devs say this there is no case where this doesn't hold... 
        // I believe them...
        return c;
    }

    function sub(uint256 a, uint256 b) internal constant returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal constant returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */

contract ERC20Basic {
    uint256 public totalSupply;
    function balanceOf(address _who) constant returns (uint256);
    function transfer(address _to, uint256 _value) returns (bool);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */

contract ERC20 is ERC20Basic {
    function allowance(address _owner, address _spender) constant returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool);
    function approve(address _spender, uint256 _value) returns (bool);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract ERC677 is ERC20 {
    function transferAndCall(address _to, uint _value, bytes _data) returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint _value, bytes _data);
}

contract ERC677Reveiver {
    function onTokenTransfer(address _sender, uint _value, bytes _data);
}

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances. 
 */

contract BasicToken is ERC20Basic {
    using SafeMath for uint256;

    mapping(address => uint256) balances;

    /**
    * @dev transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */

    function transfer(address _to, uint256 _value) returns (bool) {
        // subtract the value from the sender
        balances[msg.sender] = balances[msg.sender].sub(_value);
        // add the value to the specified address
        balances[_to] = balances[_to].add(_value);
        // Invoke the Transfer Event to alert the blockchain of the transaction
        // ??? curious why we don't use the emit keyword here in front of Transfer ???
        Transfer(msg.sender, _to, _value);
        // ??? curious why we return true here ???
        return true;
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of. 
    * @return An uint256 representing the amount owned by the passed address.
    */

    function balanceOf(address _owner) constant returns (uint256 balance) {
        // return the balance of the sender
        // ??? I'm curious what heppens if the user inputs an invalid address ???
        return balances[_owner];
    }

}

// WILL CONTINUE THIS TOMORROW
