var socket = io();

socket.on('update_data', function(new_data){
	Object.assign(data, new_data);
});


$(() => {
	$('#new-client-form').submit( (e) => {
	    e.preventDefault();
	    var data = $('#new-client-form').serializeObject();
	    socket.emit('new_client', data);
	});
});