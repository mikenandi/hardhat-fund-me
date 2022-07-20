// -. Goals
// Get funds from users.
// Withdraw funds.
// Set minimum funding value in USD.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    // Declaring the library that we gonna use.
    using PriceConverter for uint256;

    uint256 minimumUsd = 50;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;

    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(priceFeed) >= minimumUsd,
            "Didn't send enough money here!"
        );
        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            // getting the funder address.
            address funder = funders[funderIndex];

            // setting the amount to zero.
            addressToAmountFunded[funder] = 0;
        }

        // reseting the array.
        funders = new address[](0);

        // using call function.
        // -> this is the recomended way of sending.
        (
            bool callSuccess, /* bytes dataReturned */

        ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "sender is not owner!");
        _;
    }

    // incase when someone sends moneny without any calldata.
    receive() external payable {
        fund();
    }

    // incase when someone sends eth with calldata which is undefined.
    fallback() external payable {
        fund();
    }
}
