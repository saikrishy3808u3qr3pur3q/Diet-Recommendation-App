const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const { Schema } = mongoose;

const userSchema = new Schema({
  email : {
    type : String,
    lowercase : true,
    required : true,
    // unique : true
  },
  password : {
    type : String,
    required : true
  },
  name : {
    type : String,
    required : false,
  },
  phone : {
    type : String,
    required : false,
  }
});

userSchema.pre('save',async function(){
  try{
    var user = this;
    const salt = await(bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(user.password,salt);
    user.password = hashpass;
  }catch(err){
    throw err;
  }
});

userSchema.methods.comparePassword = async function(userPassword){
  try{
    const isMatch = await bcrypt.compare(userPassword,this.password);
    return isMatch;
  }catch(err){
    throw err;
  }
}

const userModel = mongoose.model('UserDatas',userSchema);

module.exports = userModel;