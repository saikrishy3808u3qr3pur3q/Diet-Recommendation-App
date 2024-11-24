const UserService = require('../services/user.services');

exports.register = async(req,res,next)=>{
  try{
    const {name,email,phone,password} = req.body;
    const user = await UserService.registerUser(name,email,phone,password);

    let tokenData = {user_id:user._id.toString(),name:name,email:email,phone:phone}; 
    const token = await UserService.generateToken(tokenData,"secretkey","1h");

    res.status(200).json({status : true,success : "User registered successfully",token : token});
  }catch(err){
    throw err;
  }
}

exports.login = async(req,res,next)=>{
  try{
    const {email,password} = req.body;
    const user = await UserService.checkUser(email);
    if(!user){
      throw new Error("User doesn't exist");
    }

    const isMatch = await user.comparePassword(password);
    if(isMatch === false) throw new Error("Password is invalid");

    let tokenData = {user_id:user._id.toString(),email:user.email,name:user.name,phone:user.phone}; 
    const token = await UserService.generateToken(tokenData,"secretkey","1h");
    res.status(200).json({
      status : true,
      token : token
    });
  }catch(err){
    throw err;
  }
}