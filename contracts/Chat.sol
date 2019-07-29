pragma solidity 0.5.0;

contract Chat {
	/**
	@notice Main Chat
	@dev This contract keeps track of all chats and should output the latest chat
	**/
	
	/**
	@notice Text struct keeps essential data regarding each text
	@dev Self explanatory text of each item in the struct
	**/
	struct Text {
		bytes32 text;
		address add;
		uint256 timestamp;
	}
	/**
	@notice Stored the data of each participant of the chat app
	@dev
	**/
	struct Account {
		address account;
	}

	mapping(address => bool) Owners;
	mapping(bytes32 => Text) TextMapping;
	bytes32[] TextKeys;
	address private Deployer;
	uint256 private Count;
	uint256 private Display;
	
	constructor() public {
		Deployer = msg.sender;
		Count = 0;
	}
	function answer(bytes32 _text) external returns(bool success) {
		count++;
		bytes32 id = keccak256(_text,count);
		TextMapping[id].text = text;
		TextMapping[id].add = msg.sender;
		TextMapping[id].timestamp = block.timestamp;

	}
	function setDisplay(uint256 _display) external returns (bool success) {
		Display = _display;
	}

	function getDisplay() external returns (address,bytes32) {
		address[] memory = new address[]()

	}

}