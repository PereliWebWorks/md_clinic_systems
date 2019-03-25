

var models = require('./models.js');

models.RoomState.findAll({
	
})
.then(s => {
	return s[0].get('next_state');
})
.then(s => console.log(s.toJSON()));