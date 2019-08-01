pragma solidity 0.5.0;

contract Hello {

  constructor() public {}
  
  function getHello() external view returns(string memory){
      return 'Hello World';
  }
}