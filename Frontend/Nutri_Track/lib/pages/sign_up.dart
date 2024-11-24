import 'dart:convert';

import 'package:nutri_track/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Classes/Clipsign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late SharedPreferences prefs;
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final TextEditingController t4 = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState(){
    // TODO : implement initState
    initSharedPref();
    super.initState();
  }

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    child:
                    ClipPath(
                      clipper: SignClip2(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding:EdgeInsets.all(100),
                        child:Text(""),
                        decoration: BoxDecoration(
                            color: MidnightBlue
                        ),
                      ),
                    ),
                ),
                Positioned(
                    child:
                    ClipPath(
                      clipper: SignClip1(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding:EdgeInsets.fromLTRB(75,130,0,0),
                        child:Text("Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: blueShade1,
                        ),
                      ),
                    ),
                ),
                Positioned(
                    child:
                    ClipPath(
                      clipper: SignClip(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding:EdgeInsets.all(100),
                        child:Text(""),
                        decoration: BoxDecoration(
                          color: MidnightBlue,
                        ),
                      ),
                    )
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,0, 20, 0),
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: TextField(
                focusNode: _focusNode,
                controller: t1,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height:20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,0, 20, 0),
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,0, 20, 0),
              child: TextField(
                controller: t3,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,0, 20, 0),
              child: TextField(
                controller: t4,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 130,),
                Container(
                  decoration: BoxDecoration(
                    color: blueShade1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    icon: Icon(
                        Icons.navigate_next
                    ),
                    onPressed: () async{
                      if(t2.text.isNotEmpty && t4.text.isNotEmpty){
                        print("Hello1");
                        var reqBody = {
                          "name" : t1.text,
                          "email" : t2.text,
                          "phone" : t3.text,
                          "password" : t4.text
                        };
                        var response = await http.post(Uri.parse(signup_url),
                          headers: {
                            "Content-type" : "application/json"
                          },
                          body: jsonEncode(reqBody)
                        );
                        if (response.statusCode == 200) {
                          final responseBody = response.body.trim();
                          if(responseBody.isNotEmpty) {
                            print("Entering signup!\n");
                            var jsonResponse = jsonDecode(responseBody);
                            if(jsonResponse['status']){
                              var myToken = jsonResponse['token'];
                              print("Token generated during signup : " + myToken);
                              prefs.setString('token', myToken);
                            }
                            else{
                              print('Something went wrong!');
                            }
                          }
                        }
                        Navigator.pushNamed(context, '/childEntry');
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Container(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(child: Text(
                    "About Us?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                    ),
                  ),
                ),
               ),
              ],
            )
          ],
        ),
      ),
    );
  }
}