import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track/pages/BMI_Gauge.dart';
import 'package:nutri_track/pages/bmr_page.dart';
import 'package:nutri_track/pages/child_info.dart';
import 'package:nutri_track/pages/z_score_height.dart';
import 'package:nutri_track/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bmi_page.dart';            // Import your BMI page
import 'z_score_page.dart';      // Import your Z-Score page
import 'update_page.dart';       // Import your Update page
import 'diet_chart_page.dart';   // Import your Diet Chart page
import 'advice_page.dart';        // Import your Advice page
import 'needs_page.dart';         // Import your Needs page

class DashBoard extends StatefulWidget {
  final String? token; // JWT token is nullable now

  const DashBoard({this.token, Key? key}) : super(key: key); // Constructor accepts nullable token

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = "Guest";
  late SharedPreferences prefs;

  @override
  void initState() {
    check_token();
    super.initState();
  }

  void check_token() async {
    await initSharedPref();
    final token_data = await initSharedPref();
    String? child_data = prefs.getString('childDatas');
    print("Token passed to dashboard : " + token_data!);
    if (child_data != null) {
      Map<String, dynamic> childInfo_full =  jsonDecode(child_data); // Convert JSON string back to map
      Map<String, dynamic> childInfo = childInfo_full["data"];
      print(childInfo['weight']);
      setState(() {
        child_name = childInfo["name"];
        child_weight = childInfo['weight']/1;
        child_height = childInfo["height"]/1;
        child_age = (childInfo["age"]/1);
        print(child_age);
      });
    }
    if (token_data != null) {
      // Decode token and extract data
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token_data);
      print("Username is : " + decodedToken['name']);
      setState(() {
        user_name = decodedToken['name'];
        userName = decodedToken['name']; // Update userName with the extracted data
      });
    }
  }

  Future<String?> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    String? token_data = prefs.getString('token');
    return token_data;
  }

  @override
  Widget build(BuildContext context) {
    print("Child's name :" + child_name);
    print("child's weight : $child_weight");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black), // Hamburger menu icon
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        title: Text("Hi $userName,", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Display
            Text(
              "${child_name}'s Chart",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 270,
              child: BMIGauge(height: child_height/100, weight: child_weight/1), // BMI Gauge widget
            ),
            SizedBox(height: 20),
            Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Action Buttons (Routing to different pages)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              children: [
                _buildTappableBox(context, 'BMI', BMIPage()),
                _buildTappableBox(context, 'Z-Score', ZScorePage()),
                _buildTappableBox(context, 'Update', childInfoUpdate()),
                _buildTappableBox(context, 'Suggest Diet Chart', DietChartPage(calories: 1000, lifestyle: '',)),
                _buildTappableBox(context, 'Seek Advice', AdvicePage()),
                _buildTappableBox(context, 'BMR', BMRCalculator()),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', ),
        ],
        selectedItemColor: Colors.blue,
      ),
      // Drawer for the hamburger menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        userName + " !",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF673AB7),
              ),
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Terms of Service'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),  // Use 'leading' for the icon on the left
              title: Text('Log out'),
              onTap: () async {
                await prefs.remove('token');
                await prefs.remove('childDatas');
                Navigator.pushNamed(context,'/signin');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tappable Box Widget with Navigation
  Widget _buildTappableBox(BuildContext context, String action, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              action,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }
}
