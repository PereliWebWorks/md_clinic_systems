var models = require('./models.js');

models.Room.findByPk(1).then(room => {  
  room.getRoomLog().then(logs => {
    console.log(JSON.stringify(logs));
  })
  
});