//  Get Funds from users
//  Withdraw funds
// set minimum funding limit

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    // uint256 public num = 2;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // num = 7;

        //  Sending ETH to the contract and setting a min value
        require(msg.value.getConversionRate() >= 1e18, "Didn't receive enough"); // 1e18 => 1000000000000000000 wei or 1000000000 gwei or 1 ether

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

        // num = 11;

        //  If the transaction fails due to less amount then it will get reverted back
        //  and the value of num will not change , it will remain 2 only
        // Undoes the action and returns the remaining gas
    }

    function withdraw() public onlyOwner{
       
        for(uint256 i = 0; i < funders.length; i=i+1){
            address funder = funders[i];
            addressToAmountFunded[funder] = 0 ;
        }
        //  reset the array
        funders = new address[](0);

        //actually withdraw the funds

        //transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send Failed");
        //call
        (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call Failed");
    }
    modifier onlyOwner{
         require(msg.sender == owner,"Sender is not owner!");
         _;
         //  if _ is placed before then the code of the function on which it is applied will be executed first then onlyOwner
    }
}
