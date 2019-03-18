var socket = io();

socket.on('update_data', function(new_data){
	Object.assign(data, new_data);
	//console.log(data);
});