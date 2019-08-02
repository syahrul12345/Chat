<template>
    <div class="container">
	    <div class = row> 
	    	 <div class = "col-lg">
	        	 <div class="form-group">
	                <input type="text" name="message" class="form-control" placeholder="Enter message ..." v-model="message" @keyup="clearError">
	                <p class="text-danger" v-if="errorText">{{ errorText }}</p>
	        	</div>
	        </div>
	        <div class = "col-xs mr-3">
	        	<button class="btn btn-primary" type="submit" name="action" @enter="createMessage" @click="createMessage">Submit</button>
	        </div>
	    </div>
    </div>
</template>
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
				message: null,
				errorText: null,
			}
		},
        methods: {
        	clearError() {
        		if (this.message.trim().length !== 0) {
        			this.errorText = null;
        		}
        	},
			async createMessage () {
				if (this.message) {
				  this.$emit('message', this.message);
				}
				else {
					this.errorText = 'Are you trying to be funny?';
				}

				// if (this.newMessage) {
				// 	if(typeof window.web3 !== 'undefined'){
				// 		if(this.animal !== null) {
				// 			//just to set up display
				// 		// const accounts = await this.web3.eth.getAccounts()
				// 		// const metamaskAccount = accounts[0];
				// 		// const chatContract = await new this.web3.eth.Contract(abi,address)
				// 		// chatContract.methods.setDisplay('200').send({
				// 		// 	from:  metamaskAccount
				// 		// })

				// 		// signing with local accounts
				// 		const web3 = this.web3
				// 		//const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
				// 		const chatContract = await new web3.eth.Contract(abi,address)
				// 		console.log(this.animal)
				// 		const encodedCall = chatContract.methods.answer(this.animal,this.newMessage).encodeABI()
				// 		const info = await this.web3.eth.accounts.signTransaction({
				// 			to:address,
				// 			gas:450000,
				// 			gasPrice:0,
				// 			data:encodedCall
				// 		},this.localPrivateKey)
				// 		const rawTx = info.rawTransaction;
				// 		this.web3.eth.sendSignedTransaction(rawTx)
				// 		.on('receipt',(receipt) => {
				// 			console.log(receipt)
				// 		})
				// 		this.newMessage=''

				// 		//for use with node accounts <- doesnt work with chainstick since we dont have access to the .personal namespace
				// 		// const web3 = new Web3(window.web3.currentProvider);
				// 		// const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
				// 		// const chatContract = await web3.eth.Contract(abi,address)
				// 		// const encodedCall = chatContract.methods.answer(convertedMessage).encodeABI()
				// 		// web3.eth.signTransaction({
				// 		//     from: this.localAccount,
				// 		//     gasPrice: "0",
				// 		//     gas: "45000000",
				// 		//     to: address,
				// 		//     data: encodedCall
				// 		// }, this.localPassword).then(console.log);
				// 		}
				// 		else {
				// 			this.noIdError = "Please put in your ID :("
				// 		}
				// 	}else {
				// 		window.alert("NO METAMASK :(")
				// 	}
				// } else {
				// 	this.errorText = "A message must be entered!"
				// }
			},
			async stringToBytes32(web3,item){
				return web3.utils.fromAscii(item)
			}
        }
    } 
</script>