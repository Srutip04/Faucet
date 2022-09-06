// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet{
   uint public numOfFunders;
   mapping(address=> bool) private funders;
   mapping(uint=> address) private lutFunders;

   modifier limitWithdraw(uint withdrawAmount){
     require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether");
     _;
   }

   receive() external payable {} //receive ether

   function addFunds() external payable {
    // funders.push(msg.sender);
    address funder = msg.sender;

    if(!funders[funder]){
        uint index = numOfFunders++;
        funders[funder] = true;
        lutFunders[index] = funder;
    }
   }

   function withdraw(uint withdrawAmount) external limitWithdraw(withdrawAmount){
   
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