<template>
    <div class="chat container">
        <h2 class="text-primary text-center">Chainstack Super Secret Chat</h2>
        <h5 class="text-secondary text-center">Powered by Quorum  </h5>
        <h5 class="text-secondary text-center">Please set metamask RPC endpoint to : http://nd-487-578-981.rg-837-380.p2pify.com:8545</h5>

        <UserName @update="updateUserID"></UserName>

        <div class="card">
            <div class="card-body">
                <p class="nomessages text-secondary" v-if="messages.length == 0">
                    [No messages yet!]
                </p>
                <div class="messages" v-chat-scroll="{always: false, smooth: true}">
                    <div v-for="message in messages" :key="message.id">
                        <a v-bind:href = "message.explorerAddress"><span class="text-info">[{{ message.name }}]: </span></a>
                        <span>{{message.message}}</span>
                        <span class="text-secondary time">{{message.timestamp}}</span>
                    </div>
                </div>
            </div>
            <div class="card-action">
                <CreateMessage :name="name" @message="createMessage"/>
            </div>
            <!-- <button class="btn btn-primary" type="submit" name="action" @click="update">Random</button> -->
        </div>
    </div>
</template>
<style>
.chat h2{
    font-size: 2.6em;
    margin-bottom: 0px;
}
.chat h5{
    margin-top: 0px;
    margin-bottom: 40px;
}
.chat span{
    font-size: 1.2em;
}
.chat .time{
    display: block;
    font-size: 0.7em;
}
.messages{
    max-height: 300px;
    overflow: auto;
}
</style>


<script>
    import CreateMessage from '@/components/CreateMessage';
    import UserName from '@/components/UserName';
    import moment from 'moment';
    import {
      uniq,
    } from 'ramda';
    import {
      address as referenceAddress, 
      abi,
    } from './../../constants/contract';
    // /Users/nizamsyahrul/Desktop/Projects/chat/vue-chat/constants/contract.js
    // /Users/nizamsyahrul/Desktop/Projects/chat/vue-chat/src/views/Chat.vue
    const Web3 = require("web3")

    export default {
        name: 'Chat',
        props: ['name'],
        components: {
            CreateMessage,
            UserName,
        },
        data() {
            return{
                //messages: [{id:1,name:"syahrul",message:"HELLO WORLD",timestamp:"1234567"}]
                userID: null,
                messages: [],
                readableName: {},
                web3:null,
                chatContract: null,
                initParams: {},
            }
        },
        async created() {
          this.web3 = new Web3(window.web3.currentProvider);
          this.chatContract = await new this.web3.eth.Contract(abi, referenceAddress)
          const {
            address,
            privateKey,
            signTransaction,
          } = this.web3.eth.accounts.create('123');

          this.initParams = {
            address,
            privateKey,
            signTransaction,
          };

          //sets the display
          const Display = 20000
          const encodedDisplay = this.chatContract.methods.setDisplay(Display).encodeABI()
          const signedMessage = await this.web3.eth.accounts.signTransaction({
            to:referenceAddress,
            gasPrice:0,
            gas:500000,
            data:encodedDisplay
          },this.initParams.privateKey)
          const rawTx = signedMessage.rawTransaction;
          this.web3.eth.sendSignedTransaction(rawTx)
            .on('receipt',(receipt) => {
             console.log(receipt)
          })

          setInterval(function() {
            this.update()
          }.bind(this),500)
        },
        
        methods: {
          updateUserID(userID) {
            this.userID = userID;
          },

          async createMessage(message) {
            console.log("creating message")
            console.log(message);
            console.log(this.userID);
            //const convertedMessage = await this.stringToBytes32(web3,this.newMessage)
            const encodedCall = this.chatContract.methods.answer(this.userID,message).encodeABI()
            const info = await this.web3.eth.accounts.signTransaction({
              to:referenceAddress,
              gas:450000,
              gasPrice:0,
              data:encodedCall
            },this.initParams.privateKey)
            const rawTx = info.rawTransaction;
            this.web3.eth.sendSignedTransaction(rawTx)
            
          },

          async update() {
            this.chatContract.methods.getLatest().call({}).then((result) => {
              this.messages = [];
              const {animalArray, stringArray} = this.bytesToString(result)
              for(var i=0;i<result[0].length;i++) {
                var message = {
                  id: i,
                  explorerAddress: `https://nd-898-212-753.p2pify.com/accounts/${result[1][i]}/transactions`,
                  transactionHash: `Impossible to get transaction hash`,
                  name:animalArray[i],
                  message:stringArray[i],
                  timestamp:result[3][i].toString()
                }
                this.messages.push(message)
              }
            })

          },
          randomize(result) {
            const animals = ['puppy','kitten','wolf','elephant','fox','turtle','bird','chicken','lizard','butterfly'];
            const r = {}
            uniq(result[0]).forEach((id) => {
              const rand = Math.floor((Math.random() * animals.length))
              r[id] = animals[rand]
              animals.pop(rand)
            })
            return r;
          },
          bytesToString(result) {
            const web3 = new Web3();
            //populate the human readable IDS
            const animalArray = []
            result[0].forEach((item) => {
              animalArray.push(web3.utils.toAscii(item))
            })
            //populate the string arrays
            const stringArray = []
            result[2].forEach((item) => {
              stringArray.push(web3.utils.toAscii(item))
            })
            return {animalArray, stringArray}
          }

        }
        
    }

</script>