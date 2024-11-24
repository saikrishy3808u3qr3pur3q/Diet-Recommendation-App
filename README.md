
# Diet Recommendation App

## Used Tech Stacks

<p align="center">
 <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/053661a4-7f9c-48bd-96cd-b85a90a15e22">
&nbsp;
  <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/b7a28016-8d2f-4ce4-9989-b4b83c897615">
&nbsp;
 <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/f5b676c3-69d8-4e36-a928-40d133120f82">
</p>

## Reason for Starting the Project

In today's fast-paced world, maintaining a balanced diet and monitoring health metrics like BMI and Z-scores for children is crucial. This app is designed to help individuals track their diets, monitor health data, and receive personalized diet recommendations based on activity levels and goals.

<br>
<p align="center">
   <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/cd43feba-2d83-43a6-81c0-683ce986b2f6">
 &nbsp;
   <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/929bc7c7-b588-4dd1-9a84-1c0d734d78dc" >
 &nbsp;
    <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/5a5381d9-c732-467d-913b-5d58a39dae10">
    &nbsp;
     <img width="200" alt="image" src="https://github.com/saikrishy3808u3qr3pur3q/Diet-Recommendation-App/assets/114069009/2377fe72-88d2-42e6-9987-e0fa888556bf">
</p>

## Uses of the App

- **Track Diets**: 
  - Input your dietary preferences and restrictions to get personalized meal plans.
  
- **BMI and Z-Score Monitoring**: 
  - Input age and weight data to calculate BMI and track growth patterns for children and teens.
  
- **Activity Level & Goal-Based Recommendations**: 
  - Set your activity level (e.g., sedentary, active, or highly active) and goal (e.g., weight loss, gain, or maintenance) to receive a customized diet plan.
  
- **Personalized Plans**: 
  - Receive suggestions based on your unique needs, including calorie intake adjustments for weight management.

---

## Future Development Scope

- **Integration with Wearables**: Future versions of the app could integrate with fitness trackers to provide real-time data and adjust diet plans accordingly.
- **AI-Powered Recommendations**: Implement machine learning to provide smarter, data-driven diet plans based on user behavior.

---

## Installation Process and Using It

To run the app locally, follow these steps:

### 1. Clone the repository:
```sh
git clone <repository-url>
```

### 2. Navigate to the project directory:
```sh
cd diet-recommendation-app
```

### 3. Install Node.js dependencies:
For the backend (Node.js):
```sh
cd backend
npm install
```

### 4. Set up the MongoDB Atlas:
- Sign up or log in to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).
- Create a new cluster and get the connection string for your database.
- Replace the connection string in the `backend/config/db.js` file with your own MongoDB connection URL, including your username and password.

### 5. Install frontend dependencies:
For the frontend (Flutter):
```sh
cd ../frontend
flutter pub get
```

### 6. Set up Firebase (if used):
- For Android: Download and add `google-services.json`.
- For iOS: Download and add `GoogleService-Info.plist`.

### 7. Run the app:
For backend:
```sh
cd backend
npm start
```
For frontend (Flutter):
```sh
cd ../frontend
flutter run
```

---

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

