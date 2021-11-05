pragma solidity ^0.8.7;

// TLDR: mappings are like js objects

// address
// Ethereum blockchain is made up of accounts
// each account has an address
// we commonly use address to reference user/owner accounts

contract LedgeBalance {
  //mapping(_KeyType => _ValueType) modifiers name;
    mapping(address => uint) public balances;

    function updateBalance(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }

    function showBalance(address _user) view public returns(uint) {
        return balances[_user];
    }
// if we called the function above, we should receive the user balance

    showBalance(msg.sender); // => outputs the balance of this account
}

// the valuetype in a mapping can also be a mapping so it can get funky
// STOLEN FROM BINANCE SMART CONTRACT
contract FunkyMapping {
    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public freezeOf;
    mapping(address => mapping (address => uint256)) public allowance;


    function approve(address _spender, uint256 _value)
        returns (bool success) {
            if (_value <= 0) throw;
            allowance[msg.sender][_spender] = _value;
            return true;
        }

    // we could also use require instead of these if (magic) throw;
    // not sure if Require or these if statements are more conventional
    
    function transferFrom(address _from, address _to, uint256 _value)
        returns (bool success) {
            if (_to == 0x0) throw; // prevent transfer to 0x0 address
            // require(_to != 0x0);
            if (_value <= 0) throw;
            // require(_value > 0);
            if (balanceOf[_from] < _value) throw; // check if user has enough eth
            // require(balanceOf[_from] > value);
            // RESEARCH OVERFLOWS
            if (balanceOf[_to] + _value < balanceOf[_to]) throw; // check for overflows
            if (_value > allowance[_from][msg.sender]) throw; // check for allowance
            // should probably import safeMath... too lazy
            balanceOf[_from] = SafeMath.safeSub(balanceOf[_from], _value); // subtract from sender
            balanceOf[_to] = SafeMath.safeAdd(balanceOf[_to], _value); // adds to the recipient
            allowance[_from][msg.sender] = SafeMath.safeSub(allowance[_from][msg.sender], _value);
            Transfer(_from, _to, _value);
            return true;
        }
}