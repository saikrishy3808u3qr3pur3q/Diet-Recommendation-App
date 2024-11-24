# Diet-Recommendation-App

## Project Overview
The **Diet-Recommendation-App** is a Flutter-based mobile application that provides personalized diet recommendations based on a child's BMI, BMR, activity level, and weight goals. The application interacts with a Flask backend and a Node.js server to fetch recommendations and store user data. The data is stored in MongoDB via Atlas.

The project is divided into the following directories:

1. **Backend**: Contains the Flask code that handles diet recommendations.
2. **Frontend**: Contains the Flutter app code where the main app logic and UI are implemented.
3. **Flutter-Node**: Contains the Node.js backend that handles interactions with MongoDB.

## Requirements

### Flutter Setup
- Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Ensure that you have the Flutter SDK installed and set up for your development environment.

### Node.js Setup
- Install Node.js: [Node.js Installation Guide](https://nodejs.org/en/download/)
- Install required Node.js dependencies:
  ```bash
  cd Flutter-Node
  npm install
### MongoDB Setup
- Create a MongoDB Atlas account: [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
- Set up a cluster and database for storing user data.
- **Important**: Replace the MongoDB connection string in the `Diet_Recommendation_app\Flutter-Node\config\db.js` backend with your own Atlas connection string.


## Running the Project
### Step 1 : Start the Node.js Server
- Once the dependencies are installed and the environment variables are configured, you can start the Node.js server by running:
  ```bash
  node app.js

This will start the server on the port defined in your server.js or .env file (default is 5000).

- To use nodemon for automatic reloading when you make code changes, you can install it globally:

  ```bash
  npm install -g nodemon
- Then, run the server with nodemon:
  ```bash
  nodemon server.js
  
- Test the Server Locally
Once the server is running, you can test it by navigating to http://localhost:5000 in your browser or using tools like Postman or cURL. For example, if you have an endpoint like /recommend for fetching diet recommendations, you can test it by making a request to:

  ```bash
  http://localhost:5000/recommend
  
### Step 2: Run the Backend (Flask)
1. Navigate to the **Backend** directory.
2. Install Flask and other dependencies:
   ```bash
   pip install -r requirements.txt
3. Start the flask Server
   ```bash
   python app.py
The Flask server will start running at http://10.0.2.2:5000. Make sure to use this URL in your Flutter app when making requests from an Android emulator. or you could upadte as per your requirements
   
### Fetching Recommendations
The Diet-Recommendation-App frontend makes a POST request to the /recommend endpoint, passing user attributes (age, weight, height, BMI, BMR, etc.) in the request body.

### Example Request Body
The frontend sends a POST request with a payload similar to this:

```json
{
  "attributes": {
    "age": 10,
    "weight": 25,
    "height": 120,
    "BMI": 17.36,
    "BMR": 1400,
    "activity_level": "moderate",
    "gender_F": 0,
    "gender_M": 1
  },
  "meal_preferences": {
    "Breakfast": "banana",
    "Lunch": "salad"
  },
  "weight_goal_kg": 10,
  "weeks": 6
}


