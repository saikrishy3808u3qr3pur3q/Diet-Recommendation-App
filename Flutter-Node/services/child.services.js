const childModel = require('../model/child_info.model');

class ChildService{
  static async registerChild(userid,name,dob,age,weight,height,conditions,blood){
    try{
      const createUser = new childModel({userid,name,dob,age,weight,height,conditions,blood});
      return await createUser.save();
    }catch(err){
      throw err;
    }
  }
  static async retrieveChild(userid){
    try{
      const child = await childModel.findOne({userid}); 
      return child;
    }catch(err){
      throw err;
    }
  }
}

module.exports = ChildService;