// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

abstract contract SaleControlUpgradeable is OwnableUpgradeable {
    uint256 public constant __SALE_NEVER_STARTS = 2**256 - 1;

    uint256 public startTimestamp;

    function initialize() internal onlyInitializing {
        __Ownable_init();

        startTimestamp = __SALE_NEVER_STARTS;
    }

    modifier whenSaleStarted() {
        require(saleStarted(), "Sale not started yet");
        _;
    }

    function updateStartTimestamp(uint256 _startTimestamp) public onlyOwner {
        startTimestamp = _startTimestamp;
    }

    function startSale() public onlyOwner {
        startTimestamp = block.timestamp;
    }

    function stopSale() public onlyOwner {
        startTimestamp = __SALE_NEVER_STARTS;
    }

    function saleStarted() public view returns (bool) {
        return block.timestamp >= startTimestamp;
    }
}
