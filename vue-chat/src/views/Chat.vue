<template>
    <div class="chat container">
        <h2 class="text-primary text-center">Chainstack Super Secret Chat</h2>
        <h5 class="text-secondary text-center">Powered by Quorum</h5>

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
                <CreateMessage :name="name"/>
            </div>
            <button class="btn btn-primary" type="submit" name="action" @click="update">Random</button>
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
    import moment from 'moment';
    import {
      uniq,
    } from 'ramda';
    import {
      abi, address,
    } from './../../constants/contract';
    // /Users/nizamsyahrul/Desktop/Projects/chat/vue-chat/constants/contract.js
    // /Users/nizamsyahrul/Desktop/Projects/chat/vue-chat/src/views/Chat.vue
    const Web3 = require("web3")

    export default {
        name: 'Chat',
        props: ['name'],
        components: {
            CreateMessage
        },
        data() {
            return{
                //messages: [{id:1,name:"syahrul",message:"HELLO WORLD",timestamp:"1234567"}]
                messages: [],
                readableName: {},
            }
        },
        created() {
          // setInterval(function(){ 
          //   console.log("hello")
          // }, 5000);
        },
        methods: {
          async update() {
            const web3 = new Web3(window.web3.currentProvider);
            const chatContract = await new web3.eth.Contract(abi, address)
            chatContract.methods.getLatest().call({}).then((result) => {
              this.messages = [];
              const randomAnimals = this.randomize(result)
              const stringArray = this.bytesToString(result)
              for(var i=0;i<result[0].length;i++) {
                if(!this.readableName[result[0][i]]){
                  console.log('dont exist')
                  this.readableName[result[0][i]] = randomAnimals[result[0][i]]
                }
                var message = {
                  id: i,
                  explorerAddress: `https://nd-898-212-753.p2pify.com/accounts/${result[0][i]}/transactions`,
                  transactionHash: `HAHA`,
                  name:this.readableName[result[0][i]],
                  message:stringArray[i],
                  timestamp:result[2][i].toString()
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
            const stringArray = []
            result[1].forEach(async(item) => {
              stringArray.push(web3.utils.toAscii(item))
            })
            return stringArray
          }

        }
    }

</script>