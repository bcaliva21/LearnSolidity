pragma solidity ^0.8.7;

// THIS IS VERY INSECURE.
// LOOK INTO MORE SECURE IMPLEMENTATIONS.

contract TypeCasting {

  function typeCastingInts (uint8 _a, uint _b) public pure returns (uint8) {
    uint8 c = _a * uint8(_b);
    return c;
  }

// Useful for comparing id's
    function _randomIdentifier () private {
    // keccak256 => hash function
    // abi.encodePacked => encoder
    // This packed mode is mainly used for indexed event parameters.
    keccak256(abi.encodePacked("aaaab"));
    //6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
    keccak256(abi.encodePacked("aaaac"));
    //b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
  }

}