var socket = io();

socket.on('update_data', function(new_data){
	Object.assign(data, new_data);
});

socket.on('log_in_succesful', function(){
	data.logged_in = true;
})

socket.on('message', function(m){
	var type = m.type;
	var text = m.message;
	//If it has danger or success class, remove
	$('#message').removeClass('alert-success').removeClass('alert-danger').addClass('alert-' + type).addClass('show');
	$('#message-text').html(text);
});


$(() => {
	$('#new-client-form').submit( (e) => {
	    
	});
	$('#new-employee-form').submit( (e) => {
	    
	});
});