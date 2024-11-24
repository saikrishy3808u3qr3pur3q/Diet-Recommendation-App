import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIGauge extends StatelessWidget {
  final double height;
  final double weight;

  BMIGauge({required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(height, weight);

    return Container(
      child: Center(
    child: SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
      minimum: 10,
      maximum: 40,
      labelsPosition: ElementsPosition.inside,
      labelOffset: -30,
      ranges: <GaugeRange>[
        GaugeRange(
          startValue: 10,
          endValue: 18.5,
          color: Colors.red,
          label: 'Underweight',
          labelStyle: GaugeTextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
          startWidth: 20,
          endWidth: 20,
        ),
        GaugeRange(
          startValue: 18.5,
          endValue: 24.9,
          color: Colors.green,
          label: 'Healthy',
          labelStyle: GaugeTextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
          startWidth: 20,
          endWidth: 20,
        ),
        GaugeRange(
          startValue: 24.9,
          endValue: 40,
          color: Colors.red,
          label: 'Overweight',
          labelStyle: GaugeTextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
          startWidth: 20,
          endWidth: 20,
        ),
      ],
      pointers: <GaugePointer>[
        NeedlePointer(
          value: bmi,
          needleColor: Colors.black,
          needleLength: 0.8,
          needleStartWidth: 1,
          needleEndWidth: 3,
          knobStyle: KnobStyle(
            color: Colors.black,
            borderColor: Colors.black,
          ),
        ),
      ],
      annotations: <GaugeAnnotation>[
        GaugeAnnotation(
          widget: Container(
            child: Text(
              'BMI: ${bmi.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          angle: 90,
          positionFactor: 0.5,
        ),
      ],
    ),
    ],
    ),
    ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Gauge'),
        centerTitle: true,
      ),
      body: Center(
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 10,
              maximum: 40,
              labelsPosition: ElementsPosition.inside,
              labelOffset: -30,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 10,
                  endValue: 18.5,
                  color: Colors.red,
                  label: 'Underweight',
                  labelStyle: GaugeTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 18.5,
                  endValue: 24.9,
                  color: Colors.green,
                  label: 'Healthy',
                  labelStyle: GaugeTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 24.9,
                  endValue: 40,
                  color: Colors.red,
                  label: 'Overweight',
                  labelStyle: GaugeTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                  startWidth: 20,
                  endWidth: 20,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: bmi,
                  needleColor: Colors.black,
                  needleLength: 0.8,
                  needleStartWidth: 1,
                  needleEndWidth: 3,
                  knobStyle: KnobStyle(
                    color: Colors.black,
                    borderColor: Colors.black,
                  ),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    child: Text(
                      'BMI: ${bmi.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double calculateBMI(double height, double weight) {
    return weight / (height * height); // height in meters
  }
}
