// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleNFT is ERC721, Ownable {
    uint256 public tokenCounter;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        tokenCounter = 0;
    }

    function mintNFT(address recipient) public onlyOwner {
        _safeMint(recipient, tokenCounter);
        tokenCounter++;
    }

    // Function to retrieve the owner of a specific token
    function ownerOfToken(uint256 tokenId) public view returns (address) {
        return ownerOf(tokenId);
    }

    // Function to get the total number of minted tokens
    function totalSupply() public view returns (uint256) {
        return tokenCounter;
    }
}
