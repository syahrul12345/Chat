<template>
	<div class="row">
	  <div class = "col-md-3 offset-md-9">
	    <input type="text" name="message" class="form-control" placeholder="Register your user ID" v-model="userID" @keyup="submit">
	  </div>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				userID: 'Anonymous',
			};
		},
		methods: {
			submit() {
				if (this.userID.trim().length === 0) {
					this.userID = 'Anonymous';
				}

				this.$emit('update', this.userID);
			},
		}
	}
</script>