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

### Step 1: Run the Backend (Flask)
1. Navigate to the **Backend** directory.
2. Install Flask and other dependencies:
   ```bash
   pip install -r requirements.txt

