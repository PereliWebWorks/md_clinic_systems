const Sequelize = require('sequelize');

const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './db.db',
  define: {
  	underscored: true,
  	timestamps: false,
  	createdAt: 'created_at',
	updatedAt: false
  }
});

/*
sequelize
.authenticate()
.then(() => {
console.log('Connection has been established successfully.');
})
.catch(err => {
console.error('Unable to connect to the database:', err);
});
*/



var models = {};

models.Location = sequelize.define('location', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});




models.Employee = sequelize.define('employee', {
	first_name: {
		type: Sequelize.STRING,
		allowNull: false
	},
	last_name: {
		type: Sequelize.STRING,
		allowNull: false
	}
},
{
	timestamps: true
});




models.Client = sequelize.define('client', {
	first_name: {
		type: Sequelize.STRING,
		allowNull: false
	},
	last_name: {
		type: Sequelize.STRING,
		allowNull: false
	}
},
{
	timestamps: true
});




models.Room = sequelize.define('room', {
	name: {
		type: Sequelize.STRING
	}
});



models.Application = sequelize.define('application', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});



models.Upgrade = sequelize.define('upgrade', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});



models.BodyTreatment = sequelize.define('body_treatment', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});



models.FaceTreatment = sequelize.define('face_treatment', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});




models.WeightMeasurement = sequelize.define('weight_measurement', {
	weight: {
		type: Sequelize.DECIMAL,
		allowNull: false
	}
},
{
	timestamps: true
});




models.RoomState = sequelize.define('room_state', {
	name: {
		type: Sequelize.STRING,
		allowNull: false
	}
});


models.BodyTreatmentRoom = sequelize.define('body_treatment_room');




models.RoomLog = sequelize.define('room_log');



//Relationships

models.Location.hasMany(models.Employee);
models.Employee.belongsTo(models.Location);

models.Location.hasMany(models.Room);
models.Room.belongsTo(models.Location);

models.Client.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Client);
models.Room.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Room);
models.RoomState.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.RoomState);
models.BodyTreatment.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.BodyTreatment);
models.RoomLog.belongsTo(models.BodyTreatment, {foreignKey: 'second_body_treatment_id', sourceKey: 'id'});
models.FaceTreatment.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.FaceTreatment);
models.Application.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Application);
models.Upgrade.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Upgrade);

models.Client.hasMany(models.WeightMeasurement);
models.WeightMeasurement.belongsTo(models.Client);

models.Room.hasMany(models.BodyTreatmentRoom);
models.BodyTreatment.hasMany(models.BodyTreatmentRoom);
models.BodyTreatmentRoom.belongsTo(models.Room);
models.BodyTreatmentRoom.belongsTo(models.BodyTreatment);

module.exports = models;