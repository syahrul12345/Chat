const Web3 = require('web3');

web3 = new Web3(new Web3.providers.HttpProvider('https://nd-987-442-424.p2pify.com'))

const l = web3.eth.accounts.create()
console.log(l.signTransaction)
