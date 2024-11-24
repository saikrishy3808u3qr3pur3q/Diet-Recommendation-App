import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ZScoreHeightGraph extends StatelessWidget {
  final int userAge;
  final double userHeight;

  // Sample data for height over age (age from 1 to 18)
  List<int> age = List.generate(18, (index) => index + 1);  // Age from 1 to 18
  List<double> averageHeight = [
    60, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165
  ]; // Example height in cm for ages 1 to 18 (average height)

  // Z-score adjustments: height changes for each Z-score line
  List<double> heightMinus1 = [];
  List<double> heightPlus1 = [];
  List<double> heightMinus2 = [];
  List<double> heightPlus2 = [];

  ZScoreHeightGraph({required this.userAge, required this.userHeight}) {
    // Generate heights for different Z-scores
    for (int i = 0; i < averageHeight.length; i++) {
      heightMinus1.add(averageHeight[i] - 5); // Z-score -1 (lower by 5cm)
      heightPlus1.add(averageHeight[i] + 3); // Z-score +1 (higher by 5cm)

      // Bring Z-score -2 and +2 closer to the average by reducing the offset
      heightMinus2.add(averageHeight[i] - (i)*1.5); // Z-score -2, closer downward curve
      heightPlus2.add(averageHeight[i] + (i)*1.46); // Z-score +2, closer upward curve
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
          title: AxisTitle(text: 'Height (cm)'),
          minimum: 60,  // Increased minimum value for more spacing
          maximum: 180,  // Increased maximum value for more spacing
          interval: 10,  // Increased interval for more spacing
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <CartesianSeries>[
          // Z-score 0 (Average height) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => averageHeight[age - 1],
            name: 'Z-score 0 (Average)',
            color: Colors.blue,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score -1 (Below average) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => heightMinus1[age - 1],
            name: 'Z-score -1',
            color: Colors.red,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score +1 (Above average) - Curved Line
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => heightPlus1[age - 1],
            name: 'Z-score +1',
            color: Colors.green,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score -2 (Much below average) - Smooth curve
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => heightMinus2[age - 1],
            name: 'Z-score -2',
            color: Colors.orange,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // Z-score +2 (Much above average) - Smooth curve
          SplineSeries<int, int>(
            dataSource: age,
            xValueMapper: (int age, _) => age,
            yValueMapper: (int age, _) => heightPlus2[age - 1],
            name: 'Z-score +2',
            color: Colors.purple,
            width: 2, // Increased line thickness
            markerSettings: MarkerSettings(isVisible: false), // Remove circles
          ),
          // User's height as a blue dot
          ScatterSeries<int, int>(
            dataSource: userHeight == 0 ? [] : [userAge],  // Only show if height is provided
            xValueMapper: (int age, _) => userAge,
            yValueMapper: (int age, _) => userHeight,
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
