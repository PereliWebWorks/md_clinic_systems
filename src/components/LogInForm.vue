<template>
	<form @submit.prevent="submit" id="log-in-form">
		<div class="form-group">
			<label>Location</label>
			<select name="location_id" class="form-control">
				<option
					v-for="location in locations"
					:key="location.id"
					:value="location.id"
				>{{location.name}}</option>
			</select>
		</div>
		<div class="form-group">
			<label>Password</label>
			<input type="password" class="form-control" name="password" />
		</div>
		<button type="submit" class="btn btn-primary">Log In</button>
	</form>
</template>

<script>
	import $ from 'jquery';
	import '../libraries/jquery.serialize-object.min.js';
	export default {
		props: ['locations', 'socket'],
		methods: {
			submit(){
				this.socket.emit('log_in', $('#log-in-form').serializeObject());
			}
		}
	}
</script>