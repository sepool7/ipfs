// contracts/NFTMarketplace.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    mapping(uint256 => uint256) public tokenIdToPrice;
    mapping(uint256 => bool) public tokenIdForSale;

    constructor() ERC721("MyNFT", "NFT") {
        tokenCounter = 0;
    }

    function mintNFT(string memory tokenURI) public onlyOwner returns (uint256) {
        uint256 newItemId = tokenCounter;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenCounter++;
        return newItemId;
    }

    function listNFTForSale(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can list the NFT for sale");
        require(price > 0, "Price must be greater than zero");
        tokenIdToPrice[tokenId] = price;
        tokenIdForSale[tokenId] = true;
    }

    function buyNFT(uint256 tokenId) public payable {
        require(tokenIdForSale[tokenId], "NFT is not for sale");
        uint256 price = tokenIdToPrice[tokenId];
        require(msg.value >= price, "Insufficient funds to buy the NFT");

        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        payable(seller).transfer(msg.value);

        tokenIdForSale[tokenId] = false;
        tokenIdToPrice[tokenId] = 0;
    }
}
