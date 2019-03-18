
Vue.component('room', {
	props: ['room'],
	template: `
		<div class="room col-4">
			<h2>Room {{room.name}}</h2>
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
			></room>
		</div>
	`
});

console.log('Templates loaded');