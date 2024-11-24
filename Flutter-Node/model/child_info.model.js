const mongoose = require('mongoose');

const { Schema } = mongoose;

const childSchema = new Schema({
  userid:{
    type: String,
    required : true,
  },
  name : {
    type : String,
    required : true,
  },
  dob : {
    type : String,
    required : true,
  },
  age : {
    type : Number,
    required : true,
  },
  weight : {
    type : Number,
    required : true,
  },
  height : {
    type : Number,
    required : true,
  },
  conditions : {
    type : [String],
    default : [],
  },
  vacinations : {
    type : [String],
    default : [],
  },
  blood : {
    type : String,
    required : true
  }
});

const childModel = mongoose.model('ChildDatas',childSchema);

module.exports = childModel;

