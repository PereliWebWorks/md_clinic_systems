var models = require('./models.js');

models.Room.findByPk(1).then(room => { 
  room.get('current_state')
  .then(state => console.log(state));  
});






