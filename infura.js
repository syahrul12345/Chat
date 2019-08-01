const Web3 = require('Web3');
const fs = require('fs-extra')
//chainstack
const chainstack = new Web3(new Web3.providers.HttpProvider('https://nd-987-442-424.p2pify.com'));
const infura = new Web3(new Web3.providers.HttpProvider('https://ropsten.infura.io/v3/2a3f078d3755444b8777a0204e5f694a'));

const data = JSON.parse(fs.readFileSync('./build/contracts/Hello.json','utf8'))


const main = async() => {
	const abi = data.abi;
	const bytecode = data.bytecode;
	//const account = await createAccount()
	const account = {address:'0x98b661759c5CA70C13d8fB91730eACa39c7773e1',privateKey:'DF33360FAA7FAD1B13658F2A0F98A60350B974FA98EE61AF91DDD4071A31F2A0'}
	// manual encoding
	const contract = await new chainstack.eth.Contract(abi)
	const encodedFunction = await contract.methods.getHello().encodeABI()
	
	const hash = await chainstack.eth.accounts.signTransaction({
		gasPrice:100000,
		gas:450000,
		data:bytecode,
		nonce:3
	},account.privateKey)

	const rawTransaction = hash.rawTransaction
	console.log(rawTransaction)
	infura.eth.sendSignedTransaction(rawTransaction)
	.on('receipt',receipt => {
		console.log(receipt)
	}).on('transactionHash',console.log)


	//web3 deployment
	// const contract = chainstack.eth.Contract(abi)
	// contract.deploy({
	// 	data:bytecode
	// }).send({
	// 	from: account.address,
	// 	gasPrice:0,
	// 	gas:45000000,
	// }).then((result) => {
	// 	console.log(result)
	// })
	
}

main();