var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var models = require('./models.js');

var data = {
	employees: [],
	clients: [],
	rooms: [],
	body_treatments: [],
	face_treatments: [],
	applications: [],
	upgrades: [],
	locations: []
}

app.use(express.static('public'));
app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/index.html');
});

io.on('connection', function(socket){
		//On first connection, get info from db
		var models_to_query = ['Room', 'Client', 'BodyTreatment', 'FaceTreatment', 'Application', 'Upgrade', 'Employee', 'Location'];
		var promises = [
			models.Room.findAll(),
			models.Client.findAll(),
			models.BodyTreatment.findAll(),
			models.FaceTreatment.findAll(),
			models.Application.findAll(),
			models.Upgrade.findAll(),
			models.Employee.findAll(),
			models.Location.findAll()
		];
		Promise.all(promises)
		.then(res => {
			//'rooms' is what will be sent to the client
			var rooms_res = res[0];
			var clients_res = res[1];
			var body_treatments_res = res[2];
			var face_treatments_res = res[3];
			var applications_res = res[4];
			var upgrades_res = res[5];
			var employees_res = res[6];
			var locations_res = res[7];
			//Clear data just in case (should be clear already)
			data = {
				employees: [],
				clients: [],
				rooms: [],
				body_treatments: [],
				face_treatments: [],
				applications: [],
				upgrades: [],
				locations: []
			}
			//add plain object clients to 'data' object
			clients_res.forEach(c => {
				data.clients.push(c.toJSON());
			});
			//do the same for body treatments
			body_treatments_res.forEach(t => {
				data.body_treatments.push(t.toJSON());
			});
			face_treatments_res.forEach(t => {
				data.face_treatments.push(t.toJSON());
			});
			applications_res.forEach(t => {
				data.applications.push(t.toJSON());
			});
			upgrades_res.forEach(t => {
				data.upgrades.push(t.toJSON());
			});
			employees_res.forEach(t => {
				data.employees.push(t.toJSON());
			});
			locations_res.forEach(t => {
				data.locations.push(t.toJSON());
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
			console.log('emiting data');
		})
		.catch(err => console.log(err));

		socket.on('new_item', item_info => {
			models[item_info.model].create(item_info.data)
			.then(item => {
				item = item.toJSON();
				//data.clients.push(client);
				if (item_info.model !== 'RoomLog'){
					data[item_info.model.toLowerCase() + 's'].push(item);
					socket.emit('update_data', data);
					socket.emit('message', {type: 'success', message: item_info.model + ' added'});
				}
				//Else get new room info
			})
			.catch(err => console.log(err));
		});
	
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});