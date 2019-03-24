var models = require('./models.js');

models.Employee.findAll({where: {location_id: 1}})
.then(r => {
	console.log(r);
});






