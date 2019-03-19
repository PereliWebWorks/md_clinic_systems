
Vue.component('room', {
	props: ['room', 'clients', 'face_treatments', 'applications', 'upgrades', 'employees'],
	// data: function(){
	// 	return {
	// 		room: this.room,
	// 		clients: this.clients
	// 	}
	// },
	template: `
		<form class="room col-4" :id="'room-' + room.id" v-on:submit="submit($event)">
			<h2>Room {{room.name}}</h2>
			<div>Room state: {{room.state}}</div>
			<div class="form-group">
				<label>Employee</label>
				<select class="form-control room-employee-select" name="employee_id">
					<option value="">--select an employee--</option>
					<option
						v-for="employee in employees"
						:key="employee.id"
						:value="employee.id"
					>{{employee.first_name}} {{employee.last_name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>Client:</label>
				<select class="form-control room-client-select" name="client_id">
					<option value="">--select a client--</option>
					<option
						v-for="client in clients"
						:key="client.id"
						:value="client.id"
						:selected="room.client && client.id === room.client.id ? 'selected' : false"
					>{{client.first_name}} {{client.last_name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>First Treatment:</label>
				<select class="form-control room-treatment-select" name="body_treatment_id">
					<option value="">--select a treatment--</option>
					<option
						v-for="treatment in room.allowed_treatments"
						:key="treatment.id"
						:value="treatment.id"
					>{{treatment.name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>Second Treatment:</label>
				<select class="form-control room-second-treatment-select" name="second_body_treatment_id">
					<option value="">--select a treatment--</option>
					<option
						v-for="treatment in room.allowed_treatments"
						:key="treatment.id"
						:value="treatment.id"
					>{{treatment.name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>Face Treatment:</label>
				<select class="form-control face-treatment-select" name="face_treatment_id">
					<option value="">--select a treatment--</option>
					<option
						v-for="face_treatment in face_treatments"
						:key="face_treatment.id"
						:value="face_treatment.id"
					>{{face_treatment.name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>Application:</label>
				<select class="form-control application-select" name="application_id">
					<option value="">--select an application--</option>
					<option
						v-for="application in applications"
						:key="application.id"
						:value="application.id"
					>{{application.name}}</option>
				</select>
			</div>
			<div class="form-group">
				<label>Upgrade:</label>
				<select class="form-control upgrade-select" name="upgrade_id">
					<option value="">--select an upgrade--</option>
					<option
						v-for="upgrade in upgrades"
						:key="upgrade.id"
						:value="upgrade.id"
					>{{upgrade.name}}</option>
				</select>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary">
					<template v-if="room.state === 'available'">Send In Client</template>
					<template v-else-if="room.state === 'needs_cleaning'">Room Cleaning Complete</template>
					<template v-else-if="room.state === 'client_waiting_to_be_seen'">See Client</template>
					<template v-else-if="room.state === 'client_in_treatment'">Treatment Complete</template>
					<template v-else-if="room.state === 'reserved'">Send In Client</template>
				</button>
			</div>
		</form>
	`,
	methods: {
		submit: function(e){
			e.preventDefault();
			var new_state;
			var new_state_id;
			switch(this.room.state){
				case 'available':
					new_state = 'client_waiting_to_be_seen';
					new_state_id = 4;
					break;
				case 'client_waiting_to_be_seen':
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
		}
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

