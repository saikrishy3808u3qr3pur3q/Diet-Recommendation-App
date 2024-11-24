import 'package:flutter/material.dart';
import 'package:nutri_track/pages/z_score_height.dart';
import 'package:nutri_track/pages/z_score_weight.dart';

class ZScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Z-Score')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: ZScoreHeightGraph(userAge: 10, userHeight: 130.0),
            ),
            Container(
              height: 400,
              child: ZScoreWeightGraph(userAge: 10, userWeight: 37.0),
            )
          ],
        ),
      ),
    );
  }
}
