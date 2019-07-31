const fs = require('fs-extra');
const Web3 = require('web3');
const process = require('process')
var app = require('express')();


/**
@notice First lets import the necessary contract information
@dev
**/
const chatData = JSON.parse(fs.readFileSync('../build/contracts/Chat.json'))
/**
@notice Intiialize the Express App
@dev Configure it accordingly
**/
const web3 = new Web3(new Web3.providers.HttpProvider('http://nd-487-578-981.rg-837-380.p2pify.com:8545'),
	null,
	{transactionConfirmationBlocks:1})

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

app.get('/confirm',async function(req,res) {
	console.log("CONFIRMATION")
})

app.listen(3000)
console.log("listening")