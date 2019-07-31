<template>
    <div class="container" style="margin-bottom: 30px">
        <form @submit.prevent="createMessage">
            <div class="form-group">
                <input type="text" name="message" class="form-control" placeholder="Enter message ..." v-model="newMessage">
                <p class="text-danger" v-if="errorText">{{ errorText }}</p>
            </div>
            <button class="btn btn-primary" type="submit" name="action">Submit</button>
        </form>
    </div>
</template>c,
<script>
	import {
      abi, address,
    } from './../../constants/contract';
	const Web3 = require('web3')
	
    export default {
        name: 'CreateMessage',
        props: ['name'],
        data(){
				return {
					newMessage: null,
					errorText: null,
					localAccount: null,
					localPrivateKey:null,
					localPassword:null,
					web3:null,
					signer:null,
				}
			},
		async created() {
			//creates a local account for the sender
			//ROPSTEN
			//this.web3 = new Web3('https://nd-987-442-424.p2pify.com')
			// //QUORUM
			this.web3 = new Web3(window.web3.currentProvider);
			const l = this.web3.eth.accounts.create('123');
			this.localAccount = l.address
			this.localPrivateKey = l.privateKey
			this.signer = l.signTransaction
			console.log("Created a local account")

			//create a new account in the node
			//const web3 = new Web3(window.web3.currentProvider);
			// console.log("HERE")
			// this.localPassword = 'password'
			// this.localAccount = await web3.eth.personal.newAccount('password')
			// console.log("Local account created on the quorum node")
			// console.log("attempting to unlock this new node account.....")
			// web3.eth.personal.unlockAccount(this.localAccount,this.localPassword,6000).then(console.log("Unlocked the account for 6000 seconds :)"))

		},
        methods: {
			async createMessage () {
				if (this.newMessage) {
					if(typeof window.web3 !== 'undefined'){
						// create account in the remote node
						// const newAccount = await web3.eth.personal.newAccount('password')
						//for use with metamask accounts
						// const web3 = new Web3(window.web3.currentProvider);
						// const accounts = await web3.eth.getAccounts()
						// const metamaskAccount = accounts[0];
						// const chatContract = await web3.eth.Contract(abi,address)
						// const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
						// chatContract.methods.answer(convertedMessage).send({
						// 	from:  metamaskAccount
						// })

						
						//signing with local accounts
						console.log(this.localAccount)
						const web3 = this.web3
						const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
						const chatContract = await new web3.eth.Contract(abi,address)
						const encodedCall = chatContract.methods.answer(convertedMessage).encodeABI()
						const info = await this.web3.eth.accounts.signTransaction({
							to:address,
							gas:450000,
							gasPrice:0,
							data:encodedCall
						},this.localPrivateKey)
						const rawTx = info.rawTransaction;
						this.web3.eth.sendSignedTransaction(rawTx).on('receipt',console.log)
						
						//for use with node accounts
						// const web3 = new Web3(window.web3.currentProvider);
						// const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
						// const chatContract = await web3.eth.Contract(abi,address)
						// const encodedCall = chatContract.methods.answer(convertedMessage).encodeABI()
						// web3.eth.signTransaction({
						//     from: this.localAccount,
						//     gasPrice: "0",
						//     gas: "45000000",
						//     to: address,
						//     data: encodedCall
						// }, this.localPassword).then(console.log);

					}else {
						window.alert("NO METAMASK :(")
					}
				} else {
					this.errorText = "A message must be entered!"
				}
			},
			async stringToBytes32(web3,item){
				return web3.utils.fromAscii(item)
			}
        }
    } 
</script>