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
	
	event Received(
		bytes32 _text,
		address _add,
		uint256 timestamp

	);

	constructor() public {
		Deployer = msg.sender;
		Count = 0;
	}
	function answer(bytes32 _text) external returns(bool success) {
		Count++;
		bytes32 id = keccak256(abi.encodePacked(_text,Count));
		TextKeys.push(id);
		TextMapping[id].text = _text;
		TextMapping[id].add = msg.sender;
		TextMapping[id].timestamp = block.timestamp;
		emit Received(_text,msg.sender,block.timestamp);
    
	}

	function getAnswer() external view returns (bytes32[] memory) {
		return TextKeys;
	}

	function setDisplay(uint256 _display) external returns (bool success) {
		Display = _display;
	}

	function getLatest() external view returns (address[] memory ,bytes32[] memory,uint256[] memory) {
		address[] memory returnAddress = new address[](Display);
		bytes32[] memory text = new bytes32[](Display);
		uint256[] memory time = new uint256[](Display);

		uint j = 0;
		for(uint i = TextKeys.length - Display;i<TextKeys.length;i++) {
			returnAddress[j] = TextMapping[TextKeys[i]].add;
			text[j] = TextMapping[TextKeys[i]].text;
			time[j] = TextMapping[TextKeys[i]].timestamp;
			j++;
		} 
		return(returnAddress,text,time);	

	}

}