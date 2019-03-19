
Vue.component('room', {
	props: ['room', 'clients'],
	// data: function(){
	// 	return {
	// 		room: this.room,
	// 		clients: this.clients
	// 	}
	// },
	template: `
		<div class="room col-4" id="room-{{room.id}}">
			<h2>Room {{room.name}}</h2>
			<div>Room state: {{room.state}}</div>
			<div class="form-group">
				<label>Client:</label>
				<select class="form-control room-client-select">
					<option>--select a client--</option>
					<option
						v-for="client in clients"
						:key="client.id"
						:value="client.id"
						:selected="room.client && client.id === room.client.id ? 'selected' : false"
					>{{client.first_name}} {{client.last_name}}</option>
				</select>
			</div>
		</div>
	`
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
			></room>
		</div>
	`
});

