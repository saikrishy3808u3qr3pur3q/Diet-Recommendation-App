const mongoose = require('mongoose');

const connectToDB = async () => {
  try {
    await mongoose.connect("mongodb+srv://moonshooter011:yE9hGWA1crQWwXfZ@cluster0.bx5us.mongodb.net/");
    console.log('MongoDB connected');
  } catch (err) {
    console.error('Error connecting to MongoDB:', err);
    throw err;
  }
};

// Export the function instead of executing it directly
module.exports = connectToDB;
