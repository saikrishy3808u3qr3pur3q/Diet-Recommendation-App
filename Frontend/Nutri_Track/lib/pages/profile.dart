import 'package:flutter/material.dart';
import '../variables.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name: $child_name",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              "Age: $child_age",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              "Weight: $child_weight kg",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              "Height: $child_height cm",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
