import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ZScoreWeightGraph extends StatelessWidget {
  final int userAge;
  final double userWeight;

  // Sample data for weight over age (age from 1 to 18)
  List<int> age = List.generate(18, (index) => index + 1);  // Age from 1 to 18
  List<double> averageWeight = [
    3.5, 6.5, 9.5, 12, 14.5, 17, 19.5, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52
  ]; // Example weight in kg for ages 1 to 18 (average weight)

  // Z-score adjustments: weight changes for each Z-score line
  List<double> weightMinus1 = [];
  List<double> weightPlus1 = [];
  List<double> weightMinus2 = [];
  List<double> weightPlus2 = [];

  ZScoreWeightGraph({required this.userAge, required this.userWeight}) {
    // Generate weights for different Z-scores
    for (int i = 0; i < averageWeight.length; i++) {
      weightMinus1.add(averageWeight[i] - 1.5); // Z-score -1 (lower by 1.5kg)
      weightPlus1.add(averageWeight[i] + 1.5); // Z-score +1 (higher by 1.5kg)

      // Bring Z-score -2 and +2 closer to the average by reducing the offset
      weightMinus2.add(averageWeight[i] - (i) * 0.5); // Z-score -2, closer downward curve
      weightPlus2.add(averageWeight[i] + (i) * 0.45); // Z-score +2, closer upward curve
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(
          title: AxisTitle(text: 'Age (years)'),
          majorGridLines: MajorGridLines(width: 0),
          interval: 1,
          edgeLabelPlacement: EdgeLabelPlacement.shift, // To make sure age labels are spaced properly
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Weight (kg)'),
          minimum: 0,  // Adjusted minimum value for more spacing
          maximum: 60,  // Adjusted maximum value for more spacing
          interval: 5,  // Increased interval for more spacing
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <CartesianSeries>[
          // Z-score 0 (Average weight) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => averageWeight[age - 1],
            name: 'Z-score 0 (Average)',
            color: Colors.blue,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score -1 (Below average) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => weightMinus1[age - 1],
            name: 'Z-score -1',
            color: Colors.red,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score +1 (Above average) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => weightPlus1[age - 1],
            name: 'Z-score +1',
            color: Colors.green,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score -2 (Much below average) - Smooth curve
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => weightMinus2[age - 1],
            name: 'Z-score -2',
            color: Colors.orange,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score +2 (Much above average) - Smooth curve
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => weightPlus2[age - 1],
            name: 'Z-score +2',
            color: Colors.purple,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // User's weight as a blue dot
          ScatterSeries<int, int>(
            dataSource: userWeight == 0 ? [] : [userAge],  // Only show if weight is provided
            xValueMapper: (int age, _) => userAge,
            yValueMapper: (int age, _) => userWeight,
            color: Colors.blue,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              color: Colors.blue,
              borderColor: Colors.blue,
              borderWidth: 2,
              height: 8,  // Size of the dot
              width: 8,
            ),
          ),
        ],
      ),
    );
  }
}
