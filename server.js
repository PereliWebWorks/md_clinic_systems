var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var models = require('./models.js');

var data = {
	clients: [],
	rooms: []
}

app.use(express.static('public'));
app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/index.html');
});

io.on('connection', function(socket){
		//On first connection, get info from db
		var promises = [
			models.Room.findAll(),
			models.Client.findAll(),
			models.BodyTreatment.findAll()
		];
		Promise.all(promises)
		.then(res => {
			//'rooms' is what will be sent to the client
			var rooms_res = res[0];
			var clients_res = res[1];
			var body_treatments_res = res[2];
			//Clear data just in case (should be clear already)
			data.clients = [];
			data.rooms = [];
			data.body_treatments = [];
			//add plain object clients to 'data' object
			clients_res.forEach(c => {
				data.clients.push(c.toJSON());
			});
			//do the same for body treatments
			body_treatments_res.forEach(t => {
				data.body_treatments.push(t.toJSON());
			});
			//Get room logs, room client, and room state and add plain object room info to 'data' object
			promises = [];
			rooms_res.forEach(r => {
				promises.push(
					//get most recent log to get room state and current client (if there is one)
					r.get('most_recent_log')
						.then(log => {
							return Promise.all([
								log.getClient(),
								log.getRoom_state(),
								log.getBody_treatment(),
								log.get('second_body_treatment'),
								log.getFace_treatment(),
								log.getApplication(),
								log.getUpgrade(),
								r.getBody_treatments()
							]);
						})
						.then(res => {
							var client = res[0];
							var state = res[1];
							var body_treatment = res[2];
							var second_body_treatment = res[3];
							var face_treatment = res[4];
							var application = res[5];
							var upgrade = res[6];
							var allowed_treatments = res[7];
							r = r.toJSON(); //convert to plain js object so we can add properties to it
							r.client = client ? client.toJSON() : null;
							r.state = state.name;
							r.body_treatment = body_treatment ? body_treatment.toJSON() : null;
							r.second_body_treatment = second_body_treatment ? second_body_treatment.toJSON() : null;
							r.face_treatment = face_treatment ? face_treatment.toJSON() : null;
							r.application = application ? application.toJSON() : null;
							r.upgrade = upgrade ? upgrade.toJSON() : null;
							r.allowed_treatments = [];
							allowed_treatments.forEach(t => r.allowed_treatments.push(t.toJSON()));
							data.rooms.push(r);
						})
				);
			});
			return Promise.all(promises);
		})
		.then(() => {
			socket.emit('update_data', data);
			console.log('emit 1');
		})
		.catch(err => console.log(err));

		socket.on('new_client', clientInfo => {
			models.Client.create(clientInfo)
			.then(client => {
				client = client.toJSON();
				data.clients.push(client);
				socket.emit('update_data', data);
				socket.emit('message', {type: 'success', message: 'Client added'});
			});
		});
	
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});