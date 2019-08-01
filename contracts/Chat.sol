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
	function answer(string calldata text) external returns(bool success) {
		Count++;
		bytes32 _text = stringToBytes32(text);
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
		uint256 tempDisplay;
		if(TextKeys.length < Display) {
			tempDisplay = TextKeys.length;
		}else {
			tempDisplay = Display;
		}
		address[] memory returnAddress = new address[](tempDisplay);
		bytes32[] memory text = new bytes32[](tempDisplay);
		uint256[] memory time = new uint256[](tempDisplay);

		uint j = 0;
		for(uint i = TextKeys.length - tempDisplay;i<TextKeys.length;i++) {
			returnAddress[j] = TextMapping[TextKeys[i]].add;
			text[j] = TextMapping[TextKeys[i]].text;
			time[j] = TextMapping[TextKeys[i]].timestamp;
			j++;
		} 
		return(returnAddress,text,time);	

	}
	function stringToBytes32(string memory source) internal returns (bytes32 result) {
	    bytes memory tempEmptyStringTest = bytes(source);
	    if (tempEmptyStringTest.length == 0) {
	        return 0x0;
	    }

	    assembly {
	        result := mload(add(source, 32))
	    }
	}
	function bytes32ToString(bytes32 x) view internal returns (string memory) {
	    bytes memory bytesString = new bytes(32);
	    uint charCount = 0;
	    for (uint j = 0; j < 32; j++) {
	        byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
	        if (char != 0) {
	            bytesString[charCount] = char;
	            charCount++;
	        }
	    }
	    bytes memory bytesStringTrimmed = new bytes(charCount);
	    for (uint j = 0; j < charCount; j++) {
	        bytesStringTrimmed[j] = bytesString[j];
	    }
	    return string(bytesStringTrimmed);
	}


}