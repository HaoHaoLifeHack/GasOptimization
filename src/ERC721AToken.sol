// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../lib/ERC721A/contracts/ERC721A.sol"; 


contract ERC721AToken is ERC721A{
    ERC721A public erc721aContract;

    constructor() ERC721A("721AToken", "NEW") {
        //name, symbol
    }
    function mintERC721a(uint256 quantity) public {
        _safeMint(msg.sender, quantity); //(to, quantity)
    }
    function transferERC721a(address to, uint256 tokenId) public {
        safeTransferFrom(msg.sender, to, tokenId);
    }
    function approveERC721a(address spender) public {
        approve(spender, 0);
    }
}