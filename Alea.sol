// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Alea {

  mapping (uint256 => uint256) alea; 
  uint256 constant INIT = 0xaddeda1ea;

  event InitAlea(uint256 number);
  event GetAlea(uint256 hash);


  modifier validAlea(uint256 bn) {

    require(
      bn < block.number, 
      "DeLorean not implemented"
    );
    require(
      alea[bn] != 0, 
      "Alea not initialized"
    );
    _;
  }


  function initAlea() public returns (uint256) {

    uint256 blockNumber = block.number;

    alea[blockNumber] = INIT;

    emit InitAlea(blockNumber);
    return blockNumber;
  }


  function initAlea(uint256 blocknumber) public returns (uint256) {

    require(
      blocknumber > block.number,
      "Block number should be in the future"
    );

    alea[blockNumber] = INIT;

    emit InitAlea(blockNumber);
    return blockNumber;
  }


  function getAlea(uint256 bn) validAlea(bn) public returns (uint256) {

    if (alea[bn] == INIT)
      alea[bn] = uint256(blockhash(bn));

    emit GetAlea(alea[bn]);
    return alea[bn];
  }
