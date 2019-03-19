const Sequelize = require('sequelize');

const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './db.db',
  logging: false,
  define: {
  	underscored: true,
  	timestamps: false,
  	createdAt: 'created_at',
	updatedAt: false
  }
});





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
	},

},
{
	getterMethods: {
		most_recent_log: function(){
			return models.RoomLog.findOne({
				order: [['created_at', 'DESC']],
				where: {room_id: this.id}
			});
		},
		current_state: function(){
			this.get('most_recent_log')
			.then(log => {
				return log.getRoom_state();
			})
			.then(state => {
				return state.name;
			});
		}
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




models.RoomLog = sequelize.define('room_log', {}, {
	getterMethods: {
		second_body_treatment: function(){
			return models.BodyTreatment.findOne({where: {'id': this.second_body_treatment_id}});
		}
	}
});



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

models.Room.belongsToMany(models.BodyTreatment, {through: models.BodyTreatmentRoom});
models.BodyTreatment.belongsToMany(models.Room, {through: models.BodyTreatmentRoom});
//models.BodyTreatmentRoom.hasOne(models.Room);
//models.BodyTreatmentRoom.hasOne(models.BodyTreatment);

sequelize.sync();

module.exports = models;