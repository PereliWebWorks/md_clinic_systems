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
					<!-- Modals -->
					<modal
						id="new-client-modal"
						title="Add a Client"
					>
						<b-form @submit.prevent="newItem" id="new-client-form">
							<b-form-input
								type="text"
								name="first_name"
								placeholder="First name"
								required
								:formatter="capitalize"
							/>
							<b-form-input
								type="text"
								name="last_name"
								placeholder="Last name"
								required
								:formatter="capitalize"
							/>
							<input
								type="hidden"
								name="model"
								value="client"
							/>
							<b-button type="submit" variant="primary">Submit</b-button>
						</b-form>
					</modal>
					<!-- End Modals -->
			</div>
			</span>
		</span>
	</div>
</template>


<script>
	import $ from 'jquery';
	import './libraries/jquery.serialize-object.min.js';
	import io from 'socket.io-client';
	import NavBar from './components/NavBar.vue';
	import LogInForm from './components/LogInForm.vue';
	import Room from './components/Room.vue';
	import Modal from './components/Modal.vue';

	export default {
		components: {
			NavBar,
			LogInForm,
			Room,
			Modal
		},
		methods: {
			newItem: function(e){
				var formData = $(e.target).serializeObject();
				var submitData = {
					model: formData.model
				};
				delete formData.model;
				submitData.data = formData;
				this.socket.emit('new_item', submitData);
				//Hide all modals
				$('.modal').modal('hide');
			}
		},
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