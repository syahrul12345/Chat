const {address,abi} = require('./contract.js')
const Web3 = require('web3');

const main = async() => {
	const web3 = new Web3(new Web3.providers.HttpProvider('http://nd-487-578-981.rg-837-380.p2pify.com:8545'))
	const accounts = await web3.eth.getAccounts()
	const contract = await new web3.eth.Contract(abi,address)
	//set the display
	await contract.methods.setDisplay('20000').send({
		from:accounts[0]
	})
	console.log("set the display length")

	// const payload = [
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// 	{name:'syahrul',text:'hello'},
	// ]
	// const promiseArray = []
	// payload.forEach((item) => {
	// 	promiseArray.push(contract.methods.answer(item.name,item.text).send({
	// 		from:accounts[0],
	// 		gas: 450000
	// 	}))
	// })

	// Promise.all(promiseArray).then((result) => {
	// 	console.log(result)
	// })
	await contract.methods.returnEmpty('0x33acDbDb38048B107ec0007e961cd8E7c25Df0ed').call({}).then(console.log)

}

main()