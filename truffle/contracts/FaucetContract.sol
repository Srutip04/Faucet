// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned,  Logger , IFaucet{

   uint public numOfFunders;
   

   mapping(address=> bool) private funders;
   mapping(uint=> address) private lutFunders;

    


   modifier limitWithdraw(uint withdrawAmount){
     require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether");
     _;
   }

   receive() external payable {} //receive ether

    function emitLog() public override pure returns(bytes32) {
    return "Hello World";
  }

   function addFunds() override external payable {
    // funders.push(msg.sender);
    address funder = msg.sender;
    test3();

    if(!funders[funder]){
        uint index = numOfFunders++;
        funders[funder] = true;
        lutFunders[index] = funder;
    }
   }

   function test1() external onlyOwner {
    // some managing stuff that only admin should have access to
  }

  function test2() external onlyOwner {
    // some managing stuff that only admin should have access to
  }

   function withdraw(uint withdrawAmount) external override limitWithdraw(withdrawAmount){
   
    payable(msg.sender).transfer(withdrawAmount);
   }

   function getAllFunders() public view returns (address[] memory) {
    address[] memory _funders = new address[](numOfFunders);
    
    for(uint i = 0; i < numOfFunders; i++) {
      _funders[i] =  lutFunders[i];
    }
    return _funders;
   }

  

   function getFunderAtIndex(uint256 index) external view returns (address) {
    //  address[] memory _funders = getAllFunders();
       return  lutFunders[index];
   }


// const instance = await Faucet.deployed();
// instance.addFunds({from: accounts[0], value: "200000000"})
// instance.addFunds({from: accounts[1], value: "200000000"})
// instance.getFunderAtIndex(0)

   
   
   
}