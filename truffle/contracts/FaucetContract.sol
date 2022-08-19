// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet{
    //this is a special function 
    // it is called when  you make a tx that dosnt specify func name yo call
    // external func are part of the contract interface
    //which means they can be called via contract and other tx

   receive() external payable {} //receive ether
}