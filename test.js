const Web3 = require('web3')
const contract = {address:"0xb2DdD1b6566de3aAb267Ab47CDc7b1833B27C740",abi:[
    {
      "inputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "_text",
          "type": "bytes32"
        },
        {
          "indexed": false,
          "name": "_add",
          "type": "address"
        },
        {
          "indexed": false,
          "name": "timestamp",
          "type": "uint256"
        }
      ],
      "name": "Received",
      "type": "event"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_text",
          "type": "bytes32"
        }
      ],
      "name": "answer",
      "outputs": [
        {
          "name": "success",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_display",
          "type": "uint256"
        }
      ],
      "name": "setDisplay",
      "outputs": [
        {
          "name": "success",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getLatest",
      "outputs": [
        {
          "name": "",
          "type": "address[]"
        },
        {
          "name": "",
          "type": "bytes32[]"
        },
        {
          "name": "",
          "type": "uint256[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ]}
const main = async() => {
	// const web3 = new Web3(new Web3.providers.HttpProvider('http://nd-487-578-981.rg-837-380.p2pify.com:8545'))
	const web3 = new Web3(Web3.providers.WebsocketProvider('wss://ws-nd-483-012-860.p2pify.com'))

	// const deployed = await web3.eth.Contract(contract.abi,contract.address);
	// deployed.events.Received({},(error,event) => {
	// 	if(error) console.log(error)
	// 		console.log(event)
	// }),
	const subscription = web3.eth.subscribe('logs', {
	    address: contract.address
	}, function(error, result){
		console.log(error);
	    if (!error)
	        console.log(result);
	});

	//console.log(subscription);

	// unsubscribes the subscription
	// subscription.unsubscribe(function(error, success){
	//     if(success)
	//         console.log('Successfully unsubscribed!');
	// });
	}

main()