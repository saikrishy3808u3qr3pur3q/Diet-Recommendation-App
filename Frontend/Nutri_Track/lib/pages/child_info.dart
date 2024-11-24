import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/Clip.dart';
import '../classes/InputText.dart';
import '../variables.dart';


class childInfo extends StatefulWidget {
  const childInfo({super.key});

  @override
  State<childInfo> createState() => _childInfoState();
}

class _childInfoState extends State<childInfo> {

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodGrpController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  List<TextEditingController> _controllers = [];
  late SharedPreferences prefs;
  String user_id = "";

  @override
  void initState() {
    super.initState();
    // Initialize the list with one controller
    check_token();
    _addNewInputField();
  }

  void check_token() async {
    final token_data = await initSharedPref();
    print("Token passed to Child Entry : " + token_data!);
    if (token_data != null) {
      // Decode token and extract data
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token_data);
      print("UserID is : " + decodedToken['user_id']);
      setState(() {
        user_id = decodedToken['user_id']; // Update userID with the extracted data!
      });
    }
  }

  Future<String?> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    String? token_data = prefs.getString('token');
    return token_data;
  }

  // Function to add a new TextEditingController
  void _addNewInputField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  // Function to remove a TextEditingController (optional)
  void _removeInputField(int index) {
    setState(() {
      if (_controllers.length > 1) {
        _controllers.removeAt(index);
      }
    });
  }

  // Function to get the input values (optional)
  List<String> _getValues() {
    return _controllers.map((controller) => controller.text).toList();
  }

  int calculateAge(String dobString) {
    DateFormat dateFormat = DateFormat("dd-MMMM-yyyy");
    DateTime dob = dateFormat.parse(dobString);
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) age--;
    return age;
  }

  Future<bool?> ChildEntry () async{
    if(nameController.text.isNotEmpty && heightController.text.isNotEmpty && heightController.text.isNotEmpty && bloodGrpController.text.isNotEmpty && weightController.text.isNotEmpty){
      var child_age_local = calculateAge(DOBController.text);
      List<String> condition_values = _getValues();
      print("Making child entry\n");
      Map<String, dynamic> childData = {
        "data" : {
          'name': nameController.text,
          'age': child_age_local,
          "dob" : DOBController.text,
          'height' : double.parse(heightController.text),
          'weight' : double.parse(weightController.text),
          "conditions" : condition_values,
          "blood" : bloodGrpController.text,
        }
      };
      String childString = jsonEncode(childData);
      prefs.setString("childDatas", childString);
      var reqBody = {
        "userid" : user_id,
        "name" : nameController.text,
        "dob" : DOBController.text,
        "age" : child_age_local,
        "weight" : weightController.text,
        "height" : heightController.text,
        "conditions" : condition_values,
        "blood" : bloodGrpController.text,
      };
      var response = await http.post(Uri.parse(child_entry_url),
          headers: {
            "Content-type" : "application/json"
          },
          body: jsonEncode(reqBody)
      );
      if(response.statusCode == 200){
        final responseBody = response.body.trim();
        if(responseBody.isNotEmpty){
          Map<String,dynamic> data = jsonDecode(responseBody);
          print("Checking status of response : ");
          bool flag_res = data["status"];
          print(flag_res);
          return flag_res;
        }
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text(
          "Child Details",
          style: TextStyle(
            color: MidnightBlue,
            fontWeight: FontWeight.w300, fontSize: 35,
          ),
        ),
        flexibleSpace: Container(
          //padding: const EdgeInsets.fromLTRB(95,30,0,30),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [BabyBlue , TiffanyBlue],
              )
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: 730,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [TiffanyBlue,BabyBlue]),
                    ),
                  ),
                  ClipPath(
                    clipper: BackgroundWaveClipper10(),
                    child:Container(
                      width: screenSize.width,
                      height: 730,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).padding.top - 10,
                      left: MediaQuery.of(context).padding.left + 10,
                      right: MediaQuery.of(context).padding.right + 10,
                      child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Child Name :",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 370,
                              child: InputField(
                                controller: nameController,
                                hintText: "Enter the name of the child",
                                icon: Icons.child_care_sharp,
                                obsecureText: false,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Date of Birth :",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 370,
                              child: TextFormField(
                                cursorColor: Colors.transparent,
                                readOnly: true,
                                style: const TextStyle(
                                  color: blueShade1,
                                ),
                                textAlign: TextAlign.center,
                                controller: DOBController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_month,
                                      color: MidnightBlue,
                                      size: 25,
                                    ),
                                    hintText: "Choose the DOB",
                                    hintStyle: TextStyle(
                                      color: blueShade1,
                                      fontFamily: 'Schyler',
                                      fontSize: 12.0,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorWhite),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorWhite),
                                    )),
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)))!;
                                  String dateFormatter = date.toIso8601String();
                                  DateTime dt = DateTime.parse(dateFormatter);
                                  var formatter = DateFormat('dd-MMMM-yyyy');
                                  DOBController.text = formatter.format(dt);
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Weight (in Kg):",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 370,
                              child: InputField(
                                controller: weightController,
                                hintText: "Enter the weight of the child",
                                icon: Icons.monitor_weight,
                                obsecureText: false,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Height (in cm):",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 370,
                              child: InputField(
                                controller: heightController,
                                hintText: "Enter the height of the child",
                                icon: Icons.man,
                                obsecureText: false,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Blood Group :",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 370,
                              child: DropdownButtonFormField<String>(
                                value: bloodGrpController.text.isEmpty ? null : bloodGrpController.text,  // Initial value
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.bloodtype),  // Add the blood group icon
                                ),
                                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                                    .map((bloodGroup) {
                                  return DropdownMenuItem<String>(
                                    value: bloodGroup,
                                    child: Text(bloodGroup),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  bloodGrpController.text = newValue ?? '';  // Update the controller
                                },
                                hint: Text("Select Blood Group"),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Any existing illness or disease :",
                                style: TextStyle(
                                  color: MidnightBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 90,
                              width: screenSize.width ,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _controllers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InputField(
                                                  controller: _controllers[index],
                                                  hintText: "Enter the illness",
                                                  icon: Icons.note_add_outlined,
                                                  obsecureText: false,
                                                )
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                    Icons.remove_circle,
                                                    color: MidnightBlue,
                                                ),
                                                onPressed: () => _removeInputField(index), // Remove input field
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 116,
                                    height: 30,
                                    child: ElevatedButton.icon(
                                      onPressed: _addNewInputField, // Add new input field
                                      icon: Icon(
                                          Icons.add,
                                          color: MidnightBlue,
                                          size: 12,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(TiffanyBlue),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,  // Square border
                                          ),
                                        ),
                                      ),
                                      label: Text(
                                          'Add more',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MidnightBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Button to get the values (optional)
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     List<String> values = _getValues();
                                  //     print(values); // You can print or process the values
                                  //   },
                                  //   child: Text('Submit'),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child : ElevatedButton(
                                onPressed: () async {
                                  await ChildEntry();
                                  Navigator.pushNamed(context, '/dashboard');
                                  // print(response.body + 'AAAAAAAAAAAAAAAAAAAA');
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: MidnightBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(TiffanyBlue),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))  // Square border
                                    ),
                                  ),
                                ),
                              )
                            )
                          ]
                      )
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
