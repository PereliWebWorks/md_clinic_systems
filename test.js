var models = require('./models.js');

models.RoomLog.findByPk(10)
.then(r => {
	console.log(r.toJSON());
});






