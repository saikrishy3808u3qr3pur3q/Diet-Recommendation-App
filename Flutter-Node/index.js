const app = require('../Flutter-Node/app'); 
const connectToDB = require('../Flutter-Node/config/db');
const userModel = require('../Flutter-Node/model/user.model');

const PORT = 3000;

app.get('/',(req,res)=>{
  res.send("Hello World.");
});

connectToDB();

app.listen(PORT, () => {
  console.log(`Server running on Port ${PORT}.`);
});


