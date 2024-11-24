from flask import Flask, request, jsonify
import pandas as pd
import joblib

# Load models and data files
try:
    mean_shift_model = joblib.load('mean_shift_model.pkl')  # Only loading the MeanShift model
    linear_regression_model = joblib.load('linear_regression_model.pkl')
except Exception as e:
    print(f"Error loading model files: {e}")

# Load and preprocess recipes data
try:
    recipes_data = pd.read_csv('RAW_recipes.csv')
    nutrient_data = pd.read_csv('Dataset.csv')

    # Extract nutrition information
    nutrition_split = recipes_data['nutrition'].str.strip('[]').str.split(",", expand=True)
    nutrition_split.columns = ['calories', 'total fat (PDV)', 'sugar (PDV)', 'sodium (PDV)', 
                               'protein (PDV)', 'saturated fat (PDV)', 'carbohydrates (PDV)']
    nutrition_split = nutrition_split.astype(float)  # Convert to floats for clustering
    recipes_data = pd.concat([recipes_data, nutrition_split], axis=1)
except Exception as e:
    print(f"Error loading or preprocessing CSV files: {e}")

# Apply clustering to the recipes based on nutrition data
try:
    required_features = ['calories', 'total fat (PDV)', 'sugar (PDV)', 'sodium (PDV)', 
                         'protein (PDV)', 'saturated fat (PDV)', 'carbohydrates (PDV)']
    
    # Predict clusters with MeanShift only
    recipes_data['meanshift_cluster'] = mean_shift_model.predict(recipes_data[required_features].fillna(0))
except Exception as e:
    print(f"Error applying MeanShift clustering model: {e}")

# Flask app setup
app = Flask(__name__)

# Function to calculate macronutrients based on calorie intake
def calculate_macronutrients(user_calories):
    return {
        "total_fat": (user_calories * 0.30) / 9,
        "sugar": (user_calories * 0.10) / 4,
        "sodium": (user_calories * 0.05) / 4,
        "protein": (user_calories * 0.15) / 4,
        "saturated_fat": (user_calories * 0.10) / 9,
        "carbohydrates": (user_calories * 0.30) / 4,
    }

# Adjust calories based on weight goal
def adjust_calories_for_goal(calories, weight_goal_kg, weeks):
    calories_per_kg = 7700  # Approximate calories in 1 kg of body weight
    daily_calorie_adjustment = (calories_per_kg * weight_goal_kg) / (weeks * 7)
    return calories + daily_calorie_adjustment

# Generate food recommendations with balanced meals and nutritional details
def get_food_recommendations(target_calories):
    # Define approximate calorie distribution for breakfast, lunch, and dinner
    calorie_distribution = {
        "Breakfast": target_calories * 0.25,  # 25% for breakfast
        "Lunch": target_calories * 0.35,      # 35% for lunch
        "Dinner": target_calories * 0.40      # 40% for dinner
    }
    recommendations = []

    # Iterate through each meal type and generate meal recommendations
    for meal, meal_calories in calorie_distribution.items():
        # Filter recipes based on the closest calorie count to the meal target
        filtered_recipes = recipes_data[(recipes_data['calories'] <= meal_calories * 1.2) & (recipes_data['calories'] >= meal_calories * 0.8)]
        
        # If no recipe matches within range, broaden search criteria
        if filtered_recipes.empty:
            filtered_recipes = recipes_data[(recipes_data['calories'] <= meal_calories * 1.5) & (recipes_data['calories'] >= meal_calories * 0.5)]
        
        # Sample up to 3 recipes and include nutritional info for each
        sample_recipes = filtered_recipes.sample(n=min(3, len(filtered_recipes)))
        meal_recommendations = [
            {
                "name": recipe['name'],
                "nutrition": {
                    "calories": recipe['calories'],
                    "total_fat": recipe['total fat (PDV)'],
                    "sugar": recipe['sugar (PDV)'],
                    "sodium": recipe['sodium (PDV)'],
                    "protein": recipe['protein (PDV)'],
                    "saturated_fat": recipe['saturated fat (PDV)'],
                    "carbohydrates": recipe['carbohydrates (PDV)']
                }
            }
            for _, recipe in sample_recipes.iterrows()
        ]
        recommendations.append({"meal": meal, "foods": meal_recommendations})
    
    return recommendations

@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.get_json()
    attributes = data.get("attributes", {})
    weight_goal_kg = data.get("weight_goal_kg", 0)
    weeks = data.get("weeks", 0)

    # Predict base calories needed to maintain current weight
    try:
        user_features = [
            attributes["age"], attributes["weight"], attributes["height"], attributes["BMI"],
            attributes["BMR"], attributes["activity_level"], attributes["gender_F"], attributes["gender_M"]
        ]
        base_calories = linear_regression_model.predict([user_features])[0]
    except KeyError:
        return jsonify({"error": "Missing or incorrect user attribute keys"}), 400

    # Adjust calories for weight goal
    adjusted_calories = adjust_calories_for_goal(base_calories, weight_goal_kg, weeks)
    macronutrient_targets = calculate_macronutrients(adjusted_calories)

    # Generate balanced food recommendations with nutritional details
    recommendations = get_food_recommendations(adjusted_calories)

    return jsonify({
        "recommended_foods": recommendations,
        "base_calories": base_calories,
        "adjusted_calories": adjusted_calories,
        "macronutrient_targets": macronutrient_targets
    })

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
