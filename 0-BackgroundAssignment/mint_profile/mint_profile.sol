// contracts/CheapCats.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CheapCats is ERC721, Ownable {

    string public baseURI;

    uint16 MAX_CATS = 10000;

    uint16 totalSupply = 0;

    constructor() ERC721("CheapCats", "CAT") {

    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function setBaseURI(string memory base) public onlyOwner {
        baseURI = base;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // Despite the function being payable, I've removed any functionality for that here for the simplicity of the example.
    function mint() public payable {
        require(totalSupply + 1 < MAX_CATS, "All cats have already been minted!");

        _safeMint(msg.sender, totalSupply + 1);

        totalSupply += 1;
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
