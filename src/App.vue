<template>
	<div class="">
		<span class="">
			<span
				v-if="!socket"
			>
				Loading...
			</span>
			<span
				v-else-if="!logged_in"
			>
				<log-in-form :locations="locations" :socket="socket" />
			</span>
			<span
				v-else
			>
				<nav-bar />
				<div class="container-fluid">
					<div 
						class="row"
						v-for="row in 2"
						:key="row"
					>	
						<room
							v-for="(room, index) in rooms"
							v-if="index >= (row - 1) * 3 && index < row * 3"
							:key="room.id"
							:room="room"
							:clients="clients"
							:face_treatments="face_treatments"
							:applications="applications"
							:upgrades="upgrades"
							:employees="employees"
							:socket="socket"
						/>
					</div>
			</div>
			</span>
		</span>
	</div>
</template>


<script>
	import io from 'socket.io-client';
	import NavBar from './components/NavBar.vue';
	import LogInForm from './components/LogInForm.vue';
	import Room from './components/Room.vue';

	export default {
		data: function(){
			return {
				rooms: [],
				clients: [],
				body_treatments: [],
				face_treatments: [],
				applications: [],
				upgrades: [],
				employees: [],
				locations: [],
			  logged_in: false,
			  socket: false
			}
		},
		components: {
			NavBar,
			LogInForm,
			Room
		},
		created: function(){
			//Create the socket
			this.socket = io();
			this.socket.on('update_data', (new_data) => {
				for (var key in new_data){
					this.$set(this, key, new_data[key]);
				}
			});

			this.socket.on('log_in_succesful', () => {
				this.logged_in = true;
			});
		}
	}
</script>