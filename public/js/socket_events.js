var socket = io();

socket.on('update_data', function(new_data){
	Object.assign(data, new_data);
});


$(() => {
	$('#new-client-form').submit( (e) => {
	    e.preventDefault();
	    var data = {
	    	model: 'Client',
	    	data: $('#new-client-form').serializeObject()
	    };
	    socket.emit('new_item', data);
	});
	$('#new-employee-form').submit( (e) => {
	    e.preventDefault();
	    var data = {
	    	model: 'Employee',
	    	data: $('#new-employee-form').serializeObject()
	    };
	    socket.emit('new_item', data);
	});
});