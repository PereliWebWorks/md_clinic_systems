var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var models = require('./models.js');

var rooms = false;
app.use(express.static('public'));
app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/index.html');
});

io.on('connection', function(socket){
		//On first connection, get room info from db
		models.Room.findAll()
		.then(res => {
			//'rooms' is what will be sent to the client
			rooms = [];
			var promises = [];
			res.forEach(r => {
				promises.push(
					//get most recent log to get room state and current client (if there is one)
					r.get('most_recent_log')
						.then(log => {
							return Promise.all([
								log.getClient(),
								log.getRoom_state()
							]);
						})
						.then(res => {
							var client = res[0];
							var state = res[1];
							r = r.toJSON(); //convert to plain js object so we can add properties to it
							r.client = client;
							r.state = state.name;
							rooms.push(r);
						})
				);
			});
			return Promise.all(promises);
		})
		.then(() => {
			console.log(rooms);
			socket.emit('update_data', {rooms: rooms});
			console.log('emit 1');
		})
		.catch(err => console.log(err));
	
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});