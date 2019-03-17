var roomCount = 6;
var data = {
	rooms: []
}
for (var i = 0 ; i < roomCount ; i++){
	data.rooms[i] = {
		id: i,
		roomTitle: '' + (i + 1),
		roomState: 'available',
		currentClient: false
	}
}
console.log('index loaded');