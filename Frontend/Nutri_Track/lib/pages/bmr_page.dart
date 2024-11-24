import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nutri_track/variables.dart';

class BMRCalculator extends StatefulWidget {
  @override
  _BMRCalculatorState createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  final _formKey = GlobalKey<FormState>();
  double _weight = child_weight;
  double _height = child_height;
  double _age = child_age;
  String _gender = 'Male';
  String _activityLevel = 'Sedentary';
  double _bmr = 0;
  double _calories = 0;

  void _calculateBMR() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        if (_gender == 'Male') {
          _bmr = 66 + (6.23 * _weight*2.204) + (12.7 * _height*0.3937) - (6.8 * _age);
        } else {
          _bmr = 655 + (4.35 * _weight*2.204) + (4.7 * _height*0.3937) - (4.7 * _age);
        }

        switch (_activityLevel) {
          case 'Sedentary':
            _calories = _bmr * 1.2;
            break;
          case 'Lightly Active':
            _calories = _bmr * 1.375;
            break;
          case 'Moderately Active':
            _calories = _bmr * 1.55;
            break;
          case 'Very Active':
            _calories = _bmr * 1.725;
            break;
          case 'Extra Active':
            _calories = _bmr * 1.9;
            break;
        }
      });
    }
  }

  void _generateDietChart() {
    if (_calories > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sample Diet Chart'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Based on your daily calorie needs: ${_calories.toStringAsFixed(2)} calories'),
                  SizedBox(height: 16),
                  Text('Breakfast (30%): ${(_calories * 0.3).toStringAsFixed(2)} calories'),
                  Text('Lunch (35%): ${(_calories * 0.35).toStringAsFixed(2)} calories'),
                  Text('Dinner (25%): ${(_calories * 0.25).toStringAsFixed(2)} calories'),
                  Text('Snacks (10%): ${(_calories * 0.1).toStringAsFixed(2)} calories'),
                  SizedBox(height: 16),
                  Text('Note: This is a basic distribution. Consult a nutritionist for a personalized diet plan.'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please calculate your BMR first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(child_age);
    return Scaffold(
      appBar: AppBar(
        title: Text('BMR & Calorie Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kgs)'),
                keyboardType: TextInputType.number,
                initialValue: child_weight.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                onSaved: (value) => _weight = double.parse(value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (cms)'),
                keyboardType: TextInputType.number,
                initialValue: child_height.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                onSaved: (value) => _height = double.parse(value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                initialValue: child_age.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onSaved: (value) => _age = double.parse(value!),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _activityLevel,
                decoration: InputDecoration(labelText: 'Activity Level'),
                items: ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active', 'Extra Active']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _activityLevel = value!;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kg) to lose : '),
                keyboardType: TextInputType.number,
                initialValue: "0",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                onSaved: (value) => weight_to_lose = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weeks needed : '),
                keyboardType: TextInputType.number,
                initialValue: "0",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter proper value';
                  }
                  return null;
                },
                onSaved: (value) => weeks_needed = double.parse(value!),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Calculate'),
                onPressed: _calculateBMR,
              ),
              SizedBox(height: 24),
              Text(
                'Your BMR: ${_bmr.toStringAsFixed(2)} calories/day',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Calories to maintain weight: ${_calories.toStringAsFixed(2)} calories/day',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Generate Diet Chart'),
                onPressed: () {
                  gender_child_male = (_gender == 'Male') ? 1 : 0;
                  gender_child_female = (_gender != 'Male') ? 1 : 0;
                  bmr_needed = _bmr;
                  activity_level = _calories/_bmr;
                  Navigator.pushNamed(context, '/dietchart');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
