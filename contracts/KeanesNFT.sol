// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract KeanesNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string baseSVG = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: black; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='pink' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["Silly", "Funny", "Fantastic", "Jolly", "Cranky", "Spooky", "Awesome", "Zany", "Kookie", "Terrible", "Epic", "Hilarious", "Amazing", "Magnificent", "Grumpy"];
    string[] secondWords = ["NoodleSoup", "GarlicNoodles", "IceCream", "Cookies", "FriedChicken", "Fries", "Rice", "Karaage", "Candy", "Cheese", "Baguette", "Pizza", "Popsicles", "Lemonade", "Strawberries"];
    string[] thirdWords = ["Kirby", "Daroach", "DarkMetaKnight", "KingDedede", "BandanaWaddleDee", "Bugzzy", "Chirby", "KnuckleJoe", "Vividria", "Magolor", "ChefKawasaki", "Magolor", "PoppyBrosJr", "Plugg", "Chilly"];

    constructor() ERC721 ('SquareNFT', 'Square') {
        console.log("Keane's first NFT CONTRACT!");
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];

    }
    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        string memory finalSvg = string(abi.encodePacked(baseSVG, first, second, third, "</text></svg>"));
        console.log("\n-----------------");
        console.log(finalSvg);
        console.log("-----------------\n");

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, "https://jsonkeeper.com/b/ZATG");
        
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}