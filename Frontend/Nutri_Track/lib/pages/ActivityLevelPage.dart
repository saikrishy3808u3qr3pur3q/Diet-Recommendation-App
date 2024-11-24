import 'package:flutter/material.dart';
import 'diet_chart_page.dart'; // Import the Diet Chart page

class ActivityLevelPage extends StatefulWidget {
  final int calories;

  const ActivityLevelPage({Key? key, required this.calories}) : super(key: key);

  @override
  _ActivityLevelPageState createState() => _ActivityLevelPageState();
}

class _ActivityLevelPageState extends State<ActivityLevelPage> {
  String? selectedLifestyle;

  void navigateToDietChart() {
    if (selectedLifestyle != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DietChartPage(
            calories: widget.calories,
            lifestyle: selectedLifestyle!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0), // Set the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent, // Make background transparent
            title: const Text('Select Activity Level', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button icon
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView( // Enable scrolling
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How active do you consider yourself as?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Bold and larger font size
                    ),
                    const SizedBox(height: 20),
                    _buildRadioTile('Sedentary Lifestyle: little or no exercise', 'Sedentary'),
                    _buildRadioTile('Slightly Active Lifestyle: Exercise 1-3 times/week', 'Slightly Active'),
                    _buildRadioTile('Moderately Active Lifestyle: Exercise 4-5 times/week', 'Moderately Active'),
                    _buildRadioTile('Active Lifestyle: Daily exercise or intense exercise 3-4 times/week', 'Active'),
                    _buildRadioTile('Very Active Lifestyle: Intense exercise 6-7 times/week', 'Very Active'),
                    const SizedBox(height: 20), // Add space before the button
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: navigateToDietChart,
                  icon: const Icon(Icons.arrow_forward, color: Colors.white), // White icon
                  label: const Text('Next', style: TextStyle(color: Colors.white)), // White text for button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color to match theme
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding inside button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10), // Margin for spacing between tiles
      child: Material(
        elevation: 5, // Enhanced shadow effect
        borderRadius: BorderRadius.circular(12), // Rounded corners for the shadow
        child: RadioListTile<String>(
          title: Text(title, style: const TextStyle(color: Colors.black)),
          value: value,
          groupValue: selectedLifestyle,
          onChanged: (newValue) => setState(() => selectedLifestyle = newValue),
          contentPadding: const EdgeInsets.symmetric(vertical: 15), // Padding inside the radio tile
          tileColor: Colors.white, // Background color of the radio tile
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1), // Border around the tile
            borderRadius: BorderRadius.circular(12), // Border radius
          ),
        ),
      ),
    );
  }
}