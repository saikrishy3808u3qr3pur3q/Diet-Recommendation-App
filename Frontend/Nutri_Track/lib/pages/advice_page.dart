import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Child Nutrition Advice',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18.0),
        ),
      ),
      home: AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  final List<String> adviceList = [
    "1. Offer a variety of foods: Include fruits, vegetables, whole grains, and proteins.",
    "2. Make meals fun: Use colorful fruits and vegetables to make plates appealing.",
    "3. Encourage healthy snacks: Offer nuts, yogurt, or fruits instead of sugary snacks.",
    "4. Promote hydration: Encourage your child to drink water instead of sugary drinks.",
    "5. Be a role model: Show healthy eating habits by eating nutritious foods yourself.",
    "6. Limit portion sizes: Teach your child to listen to their hunger cues and not to overeat.",
    "7. Involve children in meal preparation: This encourages them to try new foods.",
    "8. Avoid using food as a reward: It can create an unhealthy relationship with food.",
    "9. Educate about nutrition: Teach your child why healthy eating is important.",
    "10. Consult with a pediatrician: Get personalized advice for your child's dietary needs."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Nutrition Advice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Nutrition Tips for Your Child',
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: adviceList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        adviceList[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}