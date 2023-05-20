// SPDX-License-Identifier: MIT

pragma solidity ^0.4.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/security/pausable/Pausable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract GalacticWar is ERC721, Ownable, Pausable {
    using SafeMath for uint256;

    event CreatureRegistered(address indexed owner, uint256 tokenId, address nefturian);

    uint256 constant NUM_NEFTURIANS = 1240;


    // uint public totalLoneWolves;
    // uint public totalNefturians;
    // uint public totalCyberians;
    // uint public totalSumarians;



    mapping (uint256 => address) public tokenIdToNefturian;
    mapping (address => uint256) public revealedNefturians;
    mapping (address => uint256) public ownerToCreatureCount;
    mapping (address => uint256) public ownerToLoneWolfCount;
    mapping (address => uint256) public ownerToCyberianCount;
    mapping (address => uint256) public ownerToSumarianCount;


    constructor() public {
      
    }

    function registerCreature() external {
                
    
    emit CreatureRegistered(msg.sender, _tokenId, _nefturian);
    }

    
    function balanceOf(address _owner) public view returns (uint256) {
        return ownerToCreatureCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return createToNefturian[_tokenId];
    }

    function transferFrom(address _to, address _from, uint _tokenId) public {

    }

    function approve(address _approved, uint _tokenId) public {

    }

    function setApprovalForAll(address _operator, bool _approved) public {

    }

    function getApproved(uint _tokenId) public view returns (address) {

    }

    function supportsInterface(bytes4 _interfaceID) external view returns (bool) {

    }

    function name() external view returns (string) {

    }

    function symbol() external view returns (string) {

    }

    function tokenURI(uint256 _tokenId) external view returns (string) {

    }



}