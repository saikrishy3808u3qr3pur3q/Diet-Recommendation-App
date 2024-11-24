const userModel = require('../model/user.model');
const jwt = require('jsonwebtoken');

class UserService{
  static async registerUser(name,email,phone,password){
    try{
      const createUser = new userModel({name,email,phone,password});
      return await createUser.save();
    }catch(err){
      throw err;
    }
  }
  static async checkUser(email){
    try{
      var old_user =  await userModel.findOne({email});
      return old_user;
    }catch(err){
      throw err;
    }
  }
  static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn : jwt_expiry});
  }
}

module.exports = UserService;