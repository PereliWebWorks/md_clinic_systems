var models = require('./models.js');

models.Room.findByPk(4)
.then(r => {
	return r.getBody_treatments();
	// console.log(r.id);
	// return models.BodyTreatmentRoom.findOne({where: {room_id: r.id}});
})
.then(t => {
	console.log(JSON.stringify(t));
})






