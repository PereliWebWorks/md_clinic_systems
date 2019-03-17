
Vue.component('room', {
	props: ['room'],
	template: `
		<div class="room col-xs-4">
			<h2>Room {{room.title}}</h2>
		</div>
	`
});

Vue.component('rooms-info', {
	props: ['rooms'],
	template: `
		<div>
			<room
				v-for="room in rooms"
				:key="room.id"
				:room="room"
			></room>
		</div>
	`
});

console.log('Templates loaded');