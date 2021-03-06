require('dotenv').config();
var S = require('string');
var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var models = require('./models.js');
const crypto = require('crypto');

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

app.use(express.static('dist'));
app.get('/', function(req, res){
  res.sendFile(__dirname + '/dist/index.html');
});

io.on('connection', function(socket){
		//On first connection, get info from db
		//Start by sending locations
		models.Location.findAll()
		.then(locations => {
			data.locations = locations.map(l => l.toJSON());
			var d = {
				locations: data.locations
			}
			socket.emit('update_data', d);
			//If we're in development environment and not requiring log in, take us straight to the home page
			if (process.env.ENVIRONMENT === 'development' && process.env.REQUIRE_LOG_IN === 'false'){
				console.log('skipping log in');
				return logIn({location_id: 1}, socket);
			}
		})
		.catch(console.log);



		socket.on('new_item', item_info => {
			if (!socket.authorized){
				console.log('not authorized');
				socket.emit('message', {type: 'danger', message: 'You must log in before doing that'});
				return;
			}
			console.log('Adding new item');
			//Convert the model name to something sequelize can read
			item_info.model = S(item_info.model).titleCase().replaceAll('_', '').s;
			//If model is room_log, add null fields because sequelize sucks balls
			if (item_info.model === 'RoomLog'){
				var fieldsToAdd = ['client_id', 'body_treatment_id', 'second_body_treatment_id', 'face_treatment_id', 'application_id', 'upgrade_id'];
				fieldsToAdd.forEach(f => {
					if (!item_info.data[f]) item_info.data[f] = null;
				});
			}

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
				else if (item_info.model === 'ClientMeasurement'){
					//Find client in 'data' by id, and add the new weight measurement
					data.clients.forEach(c => {
						if (c.id === Number(item.client_id)){
							c.client_measurements.push(item);
							return;
						}
					});
					io.emit('update_data', data);
				}
				else {
					data[item_info.model.toLowerCase() + 's'].push(item);
					if (!('location_id' in item) || item.location_id == socket.location_id)
						socket.emit('update_data', data);
					socket.emit('message', {type: 'success', message: item_info.model + ' added'});
				}
			})
			.catch(err => console.log(err));
		});

		socket.on('log_in', credentials => {
			logIn(credentials, socket)
			.catch(console.log);
		});
	
});

function logIn(log_in_data, socket){
	return new Promise((resolve, reject) => {
		//Check credentials if we're not in dev mode requiring log in etc
		if (process.env.ENVIRONMENT !== 'development' || process.env.REQUIRE_LOG_IN !== 'false'){

			var hash = crypto.createHash('sha256');
			hash.update(log_in_data.password);
			// console.log(hash.digest('hex'));

			//If valid, add socket events and shit and send data
			if (hash.digest('hex') !== data.locations.find(l => l.id == log_in_data.location_id).password){
				socket.emit('message', {type: 'danger', message: 'Password incorrect'});
				return;
			}
		}
		socket.location_id = Number(log_in_data.location_id);
		socket.authorized = true;

		var models_to_query = ['Room', 'Client', 'BodyTreatment', 'FaceTreatment', 'Application', 'Upgrade', 'Employee', 'Location'];
		var promises = [
			models.Room.findAll({where: {location_id: socket.location_id}}),
			models.Client.findAll({
				include: [
					{
						model: models.ClientMeasurement
					}
				]
			}),
			models.BodyTreatment.findAll(),
			models.FaceTreatment.findAll(),
			models.Application.findAll(),
			models.Upgrade.findAll(),
			models.Employee.findAll({where: {location_id: socket.location_id}}),
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
		
			return Promise.all(promises);
		})
		.then(() => {
			//Sort the rooms
			data.rooms.sort((r1, r2) => {
				return r1.id - r2.id;
			});
			socket.emit('update_data', data);
			socket.emit('log_in_succesful');
			console.log('emiting data');
			return resolve();
		})
		.catch(err => reject(err));

		
	});
}

http.listen(3000, function(){
  console.log('listening on *:3000');
  if (process.env.ENVIRONMENT === 'development'){
  	var opn = require("opn");
  	opn('http://localhost:3000/');
  }
});