// SPDX-License-Identifier: MIT
// pragma solidity >=0.8.0 <0.9.0;
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ZKU_Celebration is ERC721Enumerable, Ownable {
    using Strings for uint256;
    // merkleRoot hash
    bytes32 public merkleRoot;
    // merkleTree leaves
    bytes32[] private leaves;

    // bytes32[]  hashes;

    // record minted address
    mapping(address => bool) public alreadyMinted;

    mapping(uint256 => string) public tokenNames;

    mapping(uint256 => string) public tokenDescs;

    uint256 private reserveID;
    uint256 private currentSaleID;
    uint256 public constant maxID = 128;

    string private baseURI = "zkuc_";
    bool private saleStarted = true;

    constructor() ERC721("ZKU Celebration", "ZKUC") {
        reserveID = 1; // item 1-127
        currentSaleID = 32; // item 128-1024
    }



    // override tokenURI for adding name and desc to tokenURI
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        return
            bytes(baseURI).length > 0
                ? string(
                    abi.encodePacked(
                        baseURI,
                        tokenId.toString(),
                        getTokenName(tokenId),
                        getTokenDesc(tokenId)
                    )
                )
                : "";
    }

    // Commit the msg.sender, receiver address, tokenId, and tokenURI to a Merkle tree using the keccak256 hash function
    function updateRoot(
        address sender,
        address receiver,
        uint256 tokenId
    ) private {
        bytes32[] memory hashes = new bytes32[](128);

        // get tokenURI by tokenId
        string memory _tokenURI = tokenURI(tokenId);
        // compute leaveHash
        bytes32  leaveHash = keccak256(
            abi.encodePacked(sender, receiver, tokenId, _tokenURI)
        );
        // push leaveHash to merkletree leaves
        leaves.push(leaveHash);

        for (uint256 i = 0; i < leaves.length; i++) {
           hashes[i] = leaves[i];
        }
        // update merkle tree
        uint256 n = leaves.length;
        while(n > 1) {
            uint256 i = 0;
            uint256 j = 0;
            if (n % 2 == 0) {
                for(; i <= n-2 ;  i += 2 ){
                    hashes[j] = keccak256(abi.encodePacked(hashes[i],hashes[i + 1]));
                    j++;
                }
                n = n / 2;
            }else {
                 for(; i <= n-3 ;  i += 2 ){
                    hashes[j] = keccak256(abi.encodePacked(hashes[i],hashes[i + 1]));
                    j++;
                }
                n = n / 2 +1;
            }


        }

        merkleRoot = hashes[0];
        delete hashes;
    }

    function mint(address receiver) public returns (uint256) {
        require(saleStarted == true, "The sale is paused");
        require(msg.sender != address(0x0), "Public address is not correct");
        require(alreadyMinted[msg.sender] == false, "Address already used");
        require(currentSaleID <= maxID, "Mint limit reached");
        uint256  tokenID = currentSaleID;
        _safeMint(receiver, tokenID);
        alreadyMinted[msg.sender] = true;
        updateRoot(msg.sender, receiver, tokenID);

        currentSaleID++;
        return tokenID;
    }

    function getTokenName(uint256 tokenID) public view returns (string memory) {
        return tokenNames[tokenID];
    }

    function setTokenName(uint256  tokenID, string memory name) public onlyOwner {

        tokenNames[tokenID] = name;
    }

    function getTokenDesc(uint256 tokenID) public view returns (string memory) {
        return tokenDescs[tokenID];
    }

    function setTokenDesc(uint256  tokenID, string memory desc) public onlyOwner {
        tokenDescs[tokenID] = desc;
    }

    function startSale() public onlyOwner {
        saleStarted = true;
    }

    function pauseSale() public onlyOwner {
        saleStarted = false;
    }
}
