// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet{
   uint public numOfFunders;
   mapping(uint => address) public funders;

   //private -> can be accesible only within the smart contract
   // internal -> can be accesible only within the smart contract and also derived contracts

   receive() external payable {} //receive ether

   function addFunds() external payable {
    // funders.push(msg.sender);
    uint index = numOfFunders++;
    funders[index] = msg.sender;
   }

   function getAllFunders() public view returns (address[] memory) {
    address[] memory _funders = new address[](numOfFunders);
    
    for(uint i = 0; i < numOfFunders; i++) {
      _funders[i] = funders[i];
    }
    return _funders;
   }

  

   function getFunderAtIndex(uint256 index) external view returns (address) {
    //  address[] memory _funders = getAllFunders();
       return funders[index];
   }

   
   
   
}