import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutri_track/variables.dart';

class DietChartPage extends StatefulWidget {
  final int calories;
  final String lifestyle;

  const DietChartPage({Key? key, required this.calories, required this.lifestyle}) : super(key: key);

  @override
  _DietChartPageState createState() => _DietChartPageState();
}

class _DietChartPageState extends State<DietChartPage> {
  Map<String, dynamic>? recommendation;

  @override
  void initState() {
    super.initState();
    fetchRecommendation();
  }

  // Helper function to capitalize the first letter
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Function to fetch recommendation from the Flask server
  Future<void> fetchRecommendation() async {
    final url = Uri.parse('http://10.0.2.2:5000/recommend'); // Use emulator's localhost

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "attributes": {
            "age": child_age,
            "weight": child_weight,
            "height": child_height / 100,
            "BMI": child_weight / ((child_height / 100) * (child_height / 100)),
            "BMR": bmr_needed,
            "activity_level": activity_level,
            "gender_F": 0,
            "gender_M": 1
          },
          "meal_preferences": {
            "Breakfast": "banana",
            "Lunch": "salad"
          },
          "weight_goal_kg": weight_to_lose,
          "weeks": weeks_needed
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          recommendation = jsonDecode(response.body);
          print(recommendation);
        });
      } else {
        print('Failed to get recommendation. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recommendation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Personalized Diet Plan',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: recommendation == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calories Section in a Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calories Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Adjusted Calories: ${recommendation!['adjusted_calories'].toStringAsFixed(2)}'),
                    Text('Base Calories: ${recommendation!['base_calories'].toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),

            // Macronutrient Targets Section in a Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Macronutrient Targets',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...recommendation!['macronutrient_targets'].entries.map((entry) => Text(
                      '${capitalize(entry.key)}: ${entry.value.toStringAsFixed(2)}',
                    )),
                  ],
                ),
              ),
            ),

            // Recommended Foods Section in a Card with sub-cards for each meal
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Foods',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: recommendation!['recommended_foods'].map<Widget>((mealData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${mealData['meal']}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: mealData['foods'].map<Widget>((food) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          food['name'],
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text('Calories: ${food['nutrition']['calories']}'),
                                        Text('Carbohydrates: ${food['nutrition']['carbohydrates']}g'),
                                        Text('Protein: ${food['nutrition']['protein']}g'),
                                        Text('Saturated Fat: ${food['nutrition']['saturated_fat']}g'),
                                        Text('Sodium: ${food['nutrition']['sodium']}mg'),
                                        Text('Sugar: ${food['nutrition']['sugar']}g'),
                                        Text('Total Fat: ${food['nutrition']['total_fat']}g'),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
