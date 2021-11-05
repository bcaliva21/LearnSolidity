pragma solidity ^0.8.7;

//---------------LINK_COIN_CONTRACT-------------------------------|
// STOLEN DIRECTLY FROM ETHERSCAN TO STUDY TOKEN MAKING
// I have made small modifications to this code to
// 1. Try to follow naming conventions as I have found in the docs
// 2. Replaced depreciated modifiers
// 2a. I have replace constant with view
//---------------END_RANT-----------------------------------------|

//--------------HELPFUL_LINKS_&_INFO------------------------------|
//
// Why SafeMath?
// https://docs.openzeppelin.com/contracts/2.x/api/math
//
//
// Allowance/Approval?
// SOF https://stackoverflow.com/questions/48664570/what-approve-and-allowance-methods-are-really-doing-in-erc20-standard
//
// assert() VS require()
// ESE https://ethereum.stackexchange.com/questions/15166/difference-between-require-and-assert-and-the-difference-between-revert-and-thro
// REQUIRE use cases
/**
Validate user inputs
Validate the response from an external contract
ie. use require(external.send(amount))
Validate state conditions prior to executing state changing operations, for example in an owned contract situation
Generally, you should use require more often,
Generally, it will be used towards the beginning of a function.
 */
 // ASSERT use cases
 /**
check for overflow/underflow
check invariants
validate contract state after making changes
avoid conditions which should never, ever be possible.
Generally, you should use assert less often
Generally, it will be use towards the end of your function.
  */
//-----------------END_LINKS--------------------------------------|


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */

library SafeMath {

// I see they use assert here...
    // look at the link above for a more indepth answer for require vs assert
    // my synopsis
    // assert(false) compiles to 0xfe, which is an invalid opcode
        // because of this it uses up all remaining gas & reverts all changes
    // require(false) compiles to 0xfd, which is the REVERT opcode
        // because of this it will REFUND remaining gas
    // SEE ABOVE (START LINE 11) FOR LINK & MORE INFO ON ASSERT VS REQUIRE
    function mul(uint256 a, uint256 b) internal view returns (uint256) {
        uint256 c = a * b;
        assert(a ==0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal view returns (uint256) {
        // assert(b > 0); // solidity auto throws an error when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // ???
        // LINK devs say this there is no case where this doesn't hold...
        // I believe them...
        return c;
    }

    function sub(uint256 a, uint256 b) internal view returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal view returns (uint256) {
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
    function balanceOf(address _who) view returns (uint256);
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

    function balanceOf(address _owner) view returns (uint256 balance) {
        // return the balance of the sender
        // ??? I'm curious what heppens if the user inputs an invalid address ???
        return balances[_owner];
    }

}

/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */

contract StandardToken is ERC20, BasicToken {

    mapping(address => mapping (address => uint256)) allowed;

        /**
    * @dev Transfer tokens from one address to another
    * @param _from address The address which you want to send tokens from
    * @param _to address The address which you want to transfer to
    * @param _value uint256 the amount of tokens to be transferred
    */

    function transferFrom(address _from, address _to, uint256 _value) returns (bool) {
        var _allowance = allowed[_from][msg.sender];

        // no check is needed here, because sub(_allowance, _value) will throw if this condition is not met

        // subtract the transfer amount, _value, from the _from address
        balances[_from] = balances[_from].sub(_value);
        // add _value to the _to address
        balances[_to] = balances[_to].add(_value);
        // subtract _value from the allowance
        allowed[_from][msg.sender] = _allowance.sub(_value);
        // invoking the event to communicate with FE
        Transfer(_from, _to, _value);
        return true;
    }

      /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */

   function approve(address _spender, uint256 _value) returns (bool) {
       // setting the value allowed for the _spender to use
       allowed[msg.sender][_spender] = _value;
       // invoking the event to communicate with FE
       Approval(msg.sender, _spender, _value);
       return true;
   }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */

   function allowance(address _owner, address _spender) view returns (uint256 _remaining) {
       return allowed[_owner][_spender];
   }

       /*
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   */

}
