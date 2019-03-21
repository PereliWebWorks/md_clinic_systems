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
			models.Client.findAll({include: [{model: models.WeightMeasurement}]}),
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
			//Add body treatments and other things
			//Clients and rooms info has some special stuff so we'll add it later
			clients_res.forEach(c => {
				data.clients.push(c.toJSON());
			});
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
					// r.get('current_info_json')
					new Promise((resolve, reject) => {
						r.get('current_info_json')
						.then(room_info => {
							data.rooms.push(room_info);
							resolve();
						})
					})
				);
			});
			//Also add weight measurements for each client

			// clients_res.forEach(c => {
			// 	promises.push(new Promise((resolve, reject) => {
			// 		c.getWeight_Measurements()
			// 		.then(m => {
			// 			var client = c.toJSON();
			// 			client.weight_measurements = m.toJSON();
			// 		})
			// 	}));
			// });
			return Promise.all(promises);
		})
		.then(() => {
			//Sort the rooms
			data.rooms.sort((r1, r2) => {
				return r1.id - r2.id;
			});
			socket.emit('update_data', data);
			console.log('emiting data');
		})
		.catch(err => console.log(err));

		socket.on('new_item', item_info => {
			models[item_info.model].create(item_info.data)
			.then(item => {
				item = item.toJSON();
				//data.clients.push(client);
				if (item_info.model === 'RoomLog'){
					//Else get new room info
					models.Room.findByPk(item.room_id)
					.then(room => {
						return room.get('current_info_json');
					})
					.then(new_room_info => {
						//Find room in 'data' by id, then replace it
						data.rooms.forEach(r => {
							if (r.id === new_room_info.id){
								Object.assign(r, new_room_info);
								io.emit('update_data', data);
								console.log('New room data emitted');
								return false;
							}
						})
					})
					.catch(err => console.log(err));
				}
				else if (item_info.model === 'WeightMeasurement'){
					//Find client in 'data' by id, and add the new weight measurement
					data.clients.forEach(c => {
						if (c.id === item.client_id){
							c.weight_measurements.push(item);
							return;
						}
					});
					io.emit('update_data', data);
				}
				else {
					data[item_info.model.toLowerCase() + 's'].push(item);
					socket.emit('update_data', data);
					socket.emit('message', {type: 'success', message: item_info.model + ' added'});
				}
			})
			.catch(err => console.log(err));
		});
	
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});