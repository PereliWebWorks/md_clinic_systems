<template>

	<form 
		class="room col-4 d-flex flex-column" 
		:id="'room-' + room.id" 
		@submit="submit($event)"
		:class="roomClass"
	>
		<h5>Room {{room.name + (room.turbo ? ' (turbo)' : '')}}: {{capitalize(room.state.split('_').join(' '))}}</h5>
		<div class="form-row">
			<room-select-field
				label="Employee"
				name="employee_id"
				:options="employees.map(e => {return {name: e.first_name + ' ' + e.last_name, value: e.id}})"
				:roomState="room.state"
				:selectedOption="room.employee ? room.employee.id : false"
				required="true"
			/>
		</div>
		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">
			<label class="col-4 col-form-label col-form-label-sm ">Client</label>
			<client-autocomplete-field
				:clientList="autocompleteClientList"
				:selectedClientName="room.client ? room.client.first_name + ' ' + room.client.last_name : ''"
				:disabled="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved'].includes(room.state)"
				:onSelect="updateSelectedClient"
				:onClear="clearSelectedClient"
				additionalClasses="col-8"
			/>
		</div>
		<div class="form-row" v-if="displayClientMeasurementAlert">
			<b-badge
				class="col-4 offset-4"
				variant="danger"
			>Needs Measurements</b-badge>
		</div>
		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">

			<room-select-field
				label="Treatment 1"
				name="body_treatment_id"
				:options="room.allowed_treatments.map(t => {return {name: t.name, value: t.id}})"
				:roomState="room.state"
				:selectedOption="room.body_treatment ? room.body_treatment.id : false"
				:disabledStates="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved']"
				required="true"
			/>
		</div>
		
		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">

			<room-select-field
				label="Treatment 2"
				name="second_body_treatment_id"
				:options="room.allowed_treatments.map(t => {return {name: t.name, value: t.id}})"
				:roomState="room.state"
				:selectedOption="room.second_body_treatment ? room.second_body_treatment.id : false"
				:disabledStates="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved']"

			/>
		</div>

		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">

			<room-select-field
				label="Face Treatment"
				name="face_treatment_id"
				:options="face_treatments.map(t => {return {name: t.name, value: t.id}})"
				:roomState="room.state"
				:selectedOption="room.face_treatment ? room.face_treatment.id : false"
				:disabledStates="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved']"

			/>
		</div>

		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">

			<room-select-field
				label="App"
				name="application_id"
				:options="applications.map(t => {return {name: t.name, value: t.id}})"
				:roomState="room.state"
				:selectedOption="room.application ? room.application.id : false"
				:disabledStates="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved']"

			/>
		</div>

		<div class="form-row" v-if="!['needs_cleaning', 'reserved'].includes(room.state)">

			<room-select-field
				label="Upgrade"
				name="upgrade_id"
				:options="upgrades.map(t => {return {name: t.name, value: t.id}})"
				:roomState="room.state"
				:selectedOption="room.upgrade ? room.upgrade.id : false"
				:disabledStates="['client_waiting', 'treatment_being_applied', 'client_in_treatment', 'needs_cleaning', 'reserved']"

			/>
		</div>

		<div class="form-row mt-auto">
			<div class="form-group col-6">
				<button type="submit" class="btn btn-primary btn-sm">
					<template v-if="room.state === 'available'">Send In Client</template>
					<template v-else-if="room.state === 'needs_cleaning'">Cleaning Complete</template>
					<template v-else-if="room.state === 'client_waiting'">See Client</template>
					<template v-else-if="room.state === 'treatment_being_applied'">Start Treatment</template>
					<template v-else-if="room.state === 'client_in_treatment'">Treatment Complete</template>
					<template v-else-if="room.state === 'reserved'">Room Now Available</template>
				</button>
			</div>
			<div class="form-group col-6" v-if="room.state === 'available'">
				<button 
					class="btn btn-primary btn-sm"
					@click="reserve"
				>
					Reserve Room
				</button>
			</div>
			<small 
				class="col-6"
				v-if="room.state === 'client_waiting' || room.state === 'client_in_treatment'"
			>
				<span v-if="room.state === 'client_waiting'">
					Waiting for: {{formatSeconds(seconds_since_last_state_change)}}
				</span>
				<span v-if="room.state === 'client_in_treatment'">
					Treatment complete in: {{formatSeconds(treatment_length - seconds_since_last_state_change)}}
				</span>
			</small>
		</div>
	</form>
	
</template>

<script>
	import $ from 'jquery';
	import '../libraries/jquery.serialize-object.min.js';
	import ClientAutocompleteField from './ClientAutocompleteField.vue';
	import RoomSelectField from './RoomSelectField.vue';
	import DateDiff from 'date-diff';


	export default {
		components: {
			RoomSelectField,
			ClientAutocompleteField
		},
		props: ['room', 'clients', 'autocompleteClientList', 'face_treatments', 'applications', 'upgrades', 'employees', 'socket'],
		data: function(){
			return {
				seconds_since_last_state_change: 0,
				treatment_length: 3,
				selectedClientId: this.room.client ? this.room.client.id : false
			}
		},
		computed: {
			roomClass: function(){
				var roomClass = this.room.state;
				if (this.room.state === 'client_in_treatment' &&  this.seconds_since_last_state_change > this.treatment_length) roomClass += ' danger';
				return roomClass;
			},
			selectedClient: function(){
				if (this.selectedClientId === false) return false;
				return this.clients.find(c => c.id === this.selectedClientId);
			},
			displayClientMeasurementAlert: function(){
				//If the state isn't right, don't display
				if (!['available', 'client_waiting', 'treatment_being_applied', 'client_in_treatment'].includes(this.room.state)) return false;
				//If the room doesn't have a client, don't display it
				if (this.selectedClient === false) return false;
				var client = this.selectedClient;
				//If the client has no measurements, display it
				if (client.client_measurements.length === 0) return true;
				//If the client hasn't had a measurement in 3 weeks, display it
				var latest_measurement = client.client_measurements[client.client_measurements.length - 1];
				var diff = new DateDiff(Date.now(), new Date(latest_measurement));
				if (diff.days() >= 21) return true;
				return false;
			}
		},
		methods: {
			submit: function(e){
				e.preventDefault();
				//Set state timer to 0
				this.seconds_since_last_state_change = 0;
				//Create room log
				var data = {
					model: 'RoomLog',
					data: $('#room-' + this.room.id).serializeObject()
				}
				data.data.room_state_id = this.room.next_state_id;
				data.data.room_id = this.room.id;
				for(var key in data.data){
					if (data.data[key] === '') data.data[key] = null;
				}
				this.socket.emit('new_item', data);
			},
			reserve: function(e){
				this.room.next_state_id = 5; //Id for reserved state
				this.submit(e);
			},
			formatSeconds: function(s){
				var string = '';
				var negativeTime = false;
				if (s < 0){
					negativeTime = true;
					s *= -1;
				}
				var minutes = Math.floor(s / 60);
				var seconds = s - minutes * 60;
				seconds = seconds + ''; //convert seconds to string
				if (seconds.length === 1) seconds = '0' + seconds;
				if (negativeTime) string += '-';
				string += minutes + ':' + seconds; 
				return string;
			},
			updateSelectedClient: function(obj){
				this.selectedClientId = obj.value;
			},
			clearSelectedClient: function(){
				this.selectedClientId = false;
			}
		},
		created: function(){
			var self = this;
			var alarm = new Audio('mp3/alarm.mp3');
			alarm.loop = true;
			alarm.pause();
			setInterval(function() {
		          self.$data.seconds_since_last_state_change = Math.floor((Date.now() - (new Date(self.room.time_of_last_state_change))) / 1000); 
							var time_left = self.treatment_length - self.$data.seconds_since_last_state_change;
		      		//If time is past treatment_length, play alarm
		      		if (self.room.state === 'client_in_treatment' && time_left < 0 && alarm.paused) {
		      			alarm.play();
		      		}
		      		else if (!alarm.paused){
		      			alarm.pause();
		      			alarm.currentTime = 0;
		      		}
		      }, 1000);
		}
	}
</script>