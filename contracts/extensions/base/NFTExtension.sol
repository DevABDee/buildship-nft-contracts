// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

import "../../interfaces/INFTExtension.sol";
import "../../interfaces/IERC721Community.sol";

contract NFTExtension is INFTExtension, ERC165 {
    IERC721Community public immutable nft;

    constructor(address _nft) {
        nft = IERC721Community(_nft);
    }

    function beforeMint() internal view {
        require(
            nft.isExtensionAdded(address(this)),
            "NFTExtension: this contract is not allowed to be used as an extension"
        );
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(IERC165, ERC165)
        returns (bool)
    {
        return
            interfaceId == type(INFTExtension).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
