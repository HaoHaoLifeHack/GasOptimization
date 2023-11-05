// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


import "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol"; 

contract ERC721Token is ERC721Enumerable{
    ERC721 public erc721Contract;

    constructor() ERC721("721Token", "OLD") {
        //name, symbol
    }
    function mintERC721(uint256 tokenId) public {
        _safeMint(msg.sender,tokenId);//(to,tokenId)
    }
    function transferERC721(address to, uint256 tokenId) public {
        safeTransferFrom(msg.sender, to, tokenId);
    }
    function approveERC721(address spender) public {
        approve(spender, 0);
    }
}