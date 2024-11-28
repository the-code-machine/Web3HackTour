// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NameNFT is ERC721 {
    uint256 private tokenIdCounter = 1;
    mapping(uint256 => string) private tokenIdToName;
    address private ownerAddress;

    constructor() ERC721("NameNFT", "NNFT") {
        ownerAddress = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == ownerAddress, "Not the contract owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        ownerAddress = _newOwner;
    }

    function mintWithName(string memory _name) external onlyOwner {
        uint256 tokenId = tokenIdCounter++;
        _safeMint(ownerAddress, tokenId);
        tokenIdToName[tokenId] = _name;
    }

    function getName(uint256 tokenId) external view returns (string memory) {
        return tokenIdToName[tokenId];
    }
}

