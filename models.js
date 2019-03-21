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
	},
	password: {
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
			return this.get('most_recent_log')
			.then(log => {
				return log.getRoom_state();
			})
			.then(state => {
				return state.name;
			});
		},
		current_info_json: function(){
			return this.get('most_recent_log')
			.then(log => {
				return Promise.all([
					log.getClient(),
					log.getRoom_state(),
					log.getBody_treatment(),
					log.get('second_body_treatment'),
					log.getFace_treatment(),
					log.getApplication(),
					log.getUpgrade(),
					this.getBody_treatments(),
					log.getEmployee(),
					log.created_at
				])
				.then(res => {
					var r = this.toJSON();
					var client = res[0];
					var state = res[1];
					var body_treatment = res[2];
					var second_body_treatment = res[3];
					var face_treatment = res[4];
					var application = res[5];
					var upgrade = res[6];
					var allowed_treatments = res[7];
					var employee = res[8];
					var time_of_last_state_change = res[9];
					r.client = client ? client.toJSON() : null;
					r.state = state.name;
					r.body_treatment = body_treatment ? body_treatment.toJSON() : null;
					r.second_body_treatment = second_body_treatment ? second_body_treatment.toJSON() : null;
					r.face_treatment = face_treatment ? face_treatment.toJSON() : null;
					r.application = application ? application.toJSON() : null;
					r.upgrade = upgrade ? upgrade.toJSON() : null;
					r.allowed_treatments = [];
					allowed_treatments.forEach(t => r.allowed_treatments.push(t.toJSON()));
					r.employee = employee ? employee.toJSON() : null;
					r.time_of_last_state_change = time_of_last_state_change;
					return r;
				})
			})
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
	timestamps: true,
	getterMethods: {
		second_body_treatment: function(){
			return models.BodyTreatment.findOne({where: {'id': this.second_body_treatment_id}});
		}
	}
});



//Relationships

models.Location.hasMany(models.Employee);
models.Employee.belongsTo(models.Location, {foreignKey: 'location_id'});

models.Location.hasMany(models.Room);
models.Room.belongsTo(models.Location, {foreignKey: 'location_id'});

models.Client.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Client, {foreignKey: 'client_id'});
models.Room.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Room, {foreignKey: 'room_id'});
models.RoomState.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.RoomState, {foreignKey: 'room_state_id'});
models.BodyTreatment.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.BodyTreatment, {foreignKey: 'body_treatment_id'});
models.RoomLog.belongsTo(models.BodyTreatment, {foreignKey: 'second_body_treatment_id', sourceKey: 'id'});
models.FaceTreatment.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.FaceTreatment, {foreignKey: 'face_treatment_id'});
models.Application.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Application, {foreignKey: 'application_id'});
models.Upgrade.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Upgrade, {foreignKey: 'upgrade_id'});
models.Employee.hasMany(models.RoomLog);
models.RoomLog.belongsTo(models.Employee, {foreignKey: 'employee_id'});

models.Client.hasMany(models.WeightMeasurement);
models.WeightMeasurement.belongsTo(models.Client, {foreignKey: 'client_id'});

models.Room.belongsToMany(models.BodyTreatment, {through: models.BodyTreatmentRoom});
models.BodyTreatment.belongsToMany(models.Room, {through: models.BodyTreatmentRoom});
//models.BodyTreatmentRoom.hasOne(models.Room);
//models.BodyTreatmentRoom.hasOne(models.BodyTreatment);

// sequelize.sync();

module.exports = models;