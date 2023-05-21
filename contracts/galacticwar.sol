// SPDX-License-Identifier: MIT

pragma solidity ^0.4.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/security/pausable/Pausable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract GalacticWar is ERC721, Ownable, Pausable {
    using SafeMath for uint256;

    event CreatureRegistered(address indexed owner, uint256 tokenId, Side side, uint256 nefturianId);

    uint256 constant NUM_NEFTURIANS = 1240;

    enum Side { None, Cyberians, Samurians, LoneWolf }

    mapping (uint256 => address) public tokenIdToNefturian;
    mapping (address => uint256) public ownerToCreatureCount;
    mapping (address => uint256) public ownerToLoneWolfCount;
    mapping (address => uint256) public ownerToCyberianCount;
    mapping (Side => address) public sideToNefturianHero;
    mapping (address => uint256) public nefturianHeroToTokenId;
    mapping (address => uint256) public ownerToSumarianCount;
    mapping (uint256 => Side) public tokenIdToSide;
    mapping (uint256 => Nefturian) public nefturians;

    struct Nefturian {
        string name;
        string pfp;
    }

    modifier onlyOwner(uint256 _tokenId) {
        require(msg.sender == ownerOf(_tokenId));
        _;
    }

    constructor() ERC721 ("Galactic War", "GW") public {
        paused = true;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function registerCreature() external {
        require(!paused, "Creature registration is paused");

        address owner = msg.sender;
        uint256 tokenId = totalSupply().add(1);
        uint256 nefturianId = _determineNefturianId(owner);
        Side side = _determineSide(nefturianId);


        _mint(owner, tokenId);
        tokenIdToNefturian[tokenId] = nefturianId;
        tokenIdToSide[tokenId] = side;
        ownerToCreatureCount[owner] = ownerToCreatureCount[owner].add(1);

          // Store the Nefturian details
        nefturians[nefturianId] = Nefturian({
            name: "Nefturian Name",
            pfp: "Nefturian Profile Picture URL"
        });

           // Update the respective count mappings based on the determined side
        if (side == Side.LoneWolf) {
            ownerToLoneWolfCount[owner] = ownerToLoneWolfCount[owner].add(1);
        } else if (side == Side.Cyberians) {
            ownerToCyberianCount[owner] = ownerToCyberianCount[owner].add(1);
        } else if (side == Side.Samurians) {
            ownerToSumarianCount[owner] = ownerToSumarianCount[owner].add(1);
        }

        emit CreatureRegistered(owner, tokenId, side, nefturianId);
    }

    function _determineNefturianId(address owner) internal view returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), owner)));
        uint256 nefturianId = (randomNumber % NUM_NEFTURIANS) + 1;
        return nefturianId;
    }

    function _determineSide(uint256 nefturianId) internal pure returns (Side) {
        // Implement your side determination logic based on nefturianId
        // For example, odd IDs can be Cyberians and even IDs can be Samurians
            if (nefturianId % 10 == 2 || nefturianId % 10 == 7) {
            return Side.LoneWolf;
        } else if (nefturianId % 2 == 0) {
            return Side.Samurians;
        } else {
            return Side.Cyberians;
        }
    }

    function getNefturian(uint256 nefturianId) external view returns (string, string) {
        Nefturian memory nefturian = nefturians[nefturianId];
        return (nefturian.name, nefturian.pfp);
    }

    function getNefturianHero(Side side) external view returns (string, string) {
        address nefturianHero = sideToNefturianHero[side];
        uint256 nefturianId = nefturianHeroToTokenId[nefturianHero];
        return getNefturian(tokenId);
    }

    function assignSide(uint256 tokenId, Side side) external onlyOwner {
        tokenIdToSide[tokenId] = side;

        // get the owner of the token
        address owner = ownerOf(tokenId);

        // Update the respective count mappings based on the determined side
        if (side == Side.LoneWolf) {
            ownerToLoneWolfCount[owner] = ownerToLoneWolfCount[owner].add(1);
        } else if (side == Side.Cyberians) {
            ownerToCyberianCount[owner] = ownerToCyberianCount[owner].add(1);
        } else if (side == Side.Samurians) {
            ownerToSumarianCount[owner] = ownerToSumarianCount[owner].add(1);
        }
    }
    // incomplete
    function attack(uint256 tokenId, uint256 targetTokenId) external {
    address attacker = ownerOf(tokenId);
    address target = ownerOf(targetTokenId);
    Side attackerSide = tokenIdToSide[tokenId];
    Side targetSide = tokenIdToSide[targetTokenId];

    require(attackerSide != Side.None && targetSide != Side.None, "Invalid sides");
    require(attackerSide != targetSide, "Cannot attack own side");

    if (attackerSide == Side.Cyberians && targetSide == Side.Samurians) {
        // Cyberian attacks Samurian
        // Perform the attack logic here
    } else if (attackerSide == Side.Samurians && targetSide == Side.Cyberians) {
        // Samurian attacks Cyberian
        // Perform the attack logic here
    } else {
        // Lone wolf attacking or responding to another side
        // Perform the attack logic here
    }
}

    
    function balanceOf(address _owner) public view returns (uint256) {
        return ownerToCreatureCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return tokenIdToNefturian[_tokenId];
    }
    

    function name() external view returns (string) {
        return "Galactic War";

    }

    function symbol() external view returns (string) {
        return "GW";
    }

    function tokenURI(uint256 _tokenId) external view returns (string) {
        return "https://api.galacticwar.io/token/1";

    }

        function transferFrom(address _to, address _from, uint _tokenId) public {

    }

    function approve(address _approved, uint _tokenId) public {

    }

    function setApprovalForAll(address _operator, bool _approved) public {

    }

    function supportsInterface(bytes4 _interfaceID) external view returns (bool) {
        return true;

    }



}