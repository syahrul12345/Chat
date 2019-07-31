<template>
  <div class="container">
    <div class="card login">
      <div class="card-body">
        <h2 class="card-title text-center">Login</h2>
        <form @submit.prevent="login" class="text-center">
          <div class="form-group">
            <p v-if="errorText" class="text-danger">{{ errorText }}</p>
          </div>
          <button class="btn btn-primary">Enter Chat</button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'home',
  data () {
    return {
      name: "",
      errorText: null
    }
  },
  methods: {
    async login() {
      if (window.ethereum) {
        const accounts = await ethereum.enable()
        const account = accounts[0]
        this.$router.push({name: 'Chat', params: {account: account}})
      } else {
        this.errorText = "Please authenticate your ID using metamask :) !"
      }
    }
  }
}
</script>
<style>
.login{
  max-width: 450px;
  margin-top: 50px;
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>