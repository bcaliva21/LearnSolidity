pragma solidity ^0.8.0;

import "./zombiefactory.sol";

// Interfacea cannot have any function with implementation
// Functions of an interface can be only of type external
// Interfaces cannot have a constructor
// Interfaces cannot have state variables
// Interfaces can have enum, structs which can be accessed using interface name dot notation
// USEFUL?
/**
Interfaces are most useful when
it comes to designing larger
scale dapps prior to their
ocmprehensive implementations.
They make it easy to facilitate extensibility in yoru dapps without introductin added complexity.

i.e. helps to implement DRY
 */

contract KittyInterface {
  function getKitty(uint256 _id)
  external view returns(
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isRead(Zombie storage _zombie) internal view returns(bool) {
      return (_zombie.readyTime <= now);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie));
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZommbie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}