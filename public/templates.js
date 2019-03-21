
Vue.component('room', {
	props: ['room', 'clients', 'face_treatments', 'applications', 'upgrades', 'employees'],
	data: function(){
		return {
			seconds_since_last_state_change: 0
		}
	},
	template: `
		<form class="room col-4" :id="'room-' + room.id" v-on:submit="submit($event)">
			<h5>Room {{room.name}}: {{capitalize(room.state.split('_').join(' '))}}</h5>
			<div class="form-group row">
				<label class="col-4 col-form-label col-form-label-sm">Employee:</label>
				<select class="col-8 form-control form-control-sm col-6 room-employee-select" name="employee_id">
					<option value=""></option>
					<option
						v-for="employee in employees"
						:key="employee.id"
						:value="employee.id"
						:selected="room.employee && employee.id === room.employee.id ? 'selected' : false"
					>{{employee.first_name}} {{employee.last_name}}</option>
				</select>
			</div>
			<span v-bind:class="{'d-none': room.state === 'reserved' || room.state === 'needs_cleaning'}">

			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">Client:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 
					room-client-select" 
					name="client_id"
					v-bind:class="{disabled: room.state !== 'available'}"
				>
					<option value=""></option>
					<option
						v-for="client in clients"
						:key="client.id"
						:value="client.id"
						:selected="room.client && client.id === room.client.id ? 'selected' : false"
					>{{client.first_name}} {{client.last_name}}</option>
				</select>
			</div>
			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">First Treatment:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 room-treatment-select" 
					name="body_treatment_id" 
					v-bind:class="{disabled: room.state !== 'available' && room.state !== 'client_waiting'}"
				>
					<option value=""></option>
					<option
						v-for="treatment in room.allowed_treatments"
						:key="treatment.id"
						:value="treatment.id"
						:selected="room.body_treatment && treatment.id === room.body_treatment.id ? 'selected' : false"
					>{{treatment.name}}</option>
				</select>
			</div>
			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">Second Treatment:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 room-second-treatment-select" 
					name="second_body_treatment_id" 
					v-bind:class="{disabled: room.state !== 'available' && room.state !== 'client_waiting'}"
				>
					<option value=""></option>
					<option
						v-for="treatment in room.allowed_treatments"
						:key="treatment.id"
						:value="treatment.id"
						:selected="room.second_body_treatment && treatment.id === room.second_body_treatment.id ? 'selected' : false"
					>{{treatment.name}}</option>
				</select>
			</div>
			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">Face Treatment:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 face-treatment-select" 
					name="face_treatment_id" 
					v-bind:class="{disabled: room.state !== 'available' && room.state !== 'client_waiting'}">
					<option value=""></option>
					<option
						v-for="face_treatment in face_treatments"
						:key="face_treatment.id"
						:value="face_treatment.id"
						:selected="room.face_treatment && face_treatment.id === room.face_treatment.id ? 'selected' : false"
					>{{face_treatment.name}}</option>
				</select>
			</div>
			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">Application:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 application-select" 
					name="application_id" 
					v-bind:class="{disabled: room.state !== 'available' && room.state !== 'client_waiting'}">
					<option value=""></option>
					<option
						v-for="application in applications"
						:key="application.id"
						:value="application.id"
						:selected="room.application && application.id === room.application.id ? 'selected' : false"
					>{{application.name}}</option>
				</select>
			</div>
			<div 
				class="form-group row"
			>
				<label class="col-4 col-form-label col-form-label-sm">Upgrade:</label class="col-4 col-form-label col-form-label-sm">
				<select 
					class="form-control form-control-sm col-8 upgrade-select" 
					name="upgrade_id" 
					v-bind:class="{disabled: room.state !== 'available' && room.state !== 'client_waiting'}"
				>
					<option value=""></option>
					<option
						v-for="upgrade in upgrades"
						:key="upgrade.id"
						:value="upgrade.id"
						:selected="room.upgrade && upgrade.id === room.upgrade.id ? 'selected' : false"
					>{{upgrade.name}}</option>
				</select>
			</div>
			</span>
			<span class="row">
				<div class="form-group col-6">
					<button type="submit" class="btn btn-primary">
						<template v-if="room.state === 'available'">Send In Client</template>
						<template v-else-if="room.state === 'needs_cleaning'">Room Cleaning Complete</template>
						<template v-else-if="room.state === 'client_waiting'">See Client</template>
						<template v-else-if="room.state === 'client_in_treatment'">Treatment Complete</template>
						<template v-else-if="room.state === 'reserved'">Send In Client</template>
					</button>
				</div>
				<div 
					class="col-6"
					v-if="room.state === 'client_waiting' || room.state === 'client_in_treatment'"
				>
					<span v-if="room.state === 'client_waiting'">
						Waiting for: {{formatSeconds(seconds_since_last_state_change)}}
					</span>
					<span v-if="room.state === 'client_in_treatment'">
						Treatment complete in: {{formatSeconds(1 - seconds_since_last_state_change)}}
					</span>
				</div>
			</span>
		</form>
	`,
	methods: {
		submit: function(e){
			e.preventDefault();
			var new_state;
			var new_state_id;
			switch(this.room.state){
				case 'available':
					new_state = 'client_waiting';
					new_state_id = 4;
					break;
				case 'client_waiting':
					new_state = 'client_in_treatment';
					new_state_id = 3;
					break;
				case 'client_in_treatment':
					new_state = 'needs_cleaning';
					new_state_id = 2;
					break;
				case 'needs_cleaning':
					new_state = 'available';
					new_state_id = 1;
					break;
			}
			//Create room log
			var data = {
				model: 'RoomLog',
				data: $('#room-' + this.room.id).serializeObject()
			}
			data.data.room_state_id = new_state_id;
			data.data.room_id = this.room.id;
			for(var key in data.data){
				if (data.data[key] === '') data.data[key] = null;
			}
			socket.emit('new_item', data);
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
		}
	},
	created: function(){
		var self = this;
		setInterval(function() {
	          self.$data.seconds_since_last_state_change = Math.floor((Date.now() - (new Date(self.room.time_of_last_state_change))) / 1000); 
	      }, 1000);
	}
});

Vue.component('rooms-info', {
	// props: {
	// 	rooms: Array
	// },
	data: function(){
		return data;
	},
	template: `
		<div class="row">
			<room
				v-for="room in rooms"
				:key="room.id"
				:room="room"
				:clients="clients"
				:face_treatments="face_treatments"
				:applications="applications"
				:upgrades="upgrades"
				:employees="employees"
			></room>
		</div>
	`
});

Vue.component('weight-measurement-modal-body', {
	props: ['clients'],
	data: function(){
		return {
			selectedClientId: this.clients[0] ? this.clients[0].id : false
		}
	},
	computed: {
		selectedClient: function(){
			return this.clients.find(c => c.id === this.selectedClientId)
		}
	},
	methods: {
		newWeightMeasurement: function(e){
			socket.emit('new_item', {
				model: 'WeightMeasurement',
				data: {
					weight: e.target.elements.weight.value,
					client_id: this.selectedClientId
				}
			});
		}
	},
	template: `
		<div class="modal-body">
			<label>Select Client</label>
			<select v-model="selectedClientId">
				<option
					v-for="client in clients"
					:key="client.id"
					:value="client.id"
				>{{client.first_name}} {{client.last_name}}</option>
			</select>
			<div v-if="selectedClient">
				<h3>{{selectedClient.first_name}} {{selectedClient.last_name}}</h3>
				<table class="table table-striped table-bordered table-sm">
					<tbody>
						<tr 
							v-for="measurement in selectedClient.weight_measurements"
							:key="measurement.id"
						>
							<td>{{formatDateTime(measurement.created_at)}}</td>
							<td>{{measurement.weight}} lbs</td>
						</tr>
					</tbody>
				</table>
				<form @submit.prevent="newWeightMeasurement">
					<h4>Add a Weight Measurement</h4>
					<div class="form-group">
						<label>Weight: </label>
						<input type="number" required name="weight" />
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	`
});

