import 'dart:convert';
// import 'dart:js';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nutri_track/pages/dashboard.dart';
import 'package:nutri_track/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/Clipsign.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late SharedPreferences prefs;

  @override
  void initState(){
    // TODO : implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async{
    if(t1.text.isNotEmpty && t2.text.isNotEmpty){
      var reqBody = {
        "email" : t1.text,
        "password" : t2.text
      };
      var response = await http.post(Uri.parse(signin_url),
          headers: {
            "Content-type" : "application/json"
          },
          body: jsonEncode(reqBody)
      );
      if (response.statusCode == 200) {
        final responseBody = response.body.trim();
        if(responseBody.isNotEmpty) {
          print("Entering login!\n");
          var jsonResponse = jsonDecode(responseBody);
          if(jsonResponse['status']){
            var myToken = jsonResponse['token'];
            print("Token generated during login : " + myToken);
            prefs.setString('token', myToken);
            Map<String, dynamic> decodedToken = JwtDecoder.decode(myToken);
            var reqBody2 = {
              "userid" : decodedToken["user_id"],
            };
            var response2 = await http.post(Uri.parse(child_retrieve_url),
                headers: {
                  "Content-type" : "application/json"
                },
                body: jsonEncode(reqBody2)
            );
            print("UserID during login : " + decodedToken["user_id"]);
            if(response2.statusCode == 200){
              final responseBody2 = response2.body.trim();
              if(responseBody2.isNotEmpty){
                var jsonResponse2 = jsonDecode(responseBody2);
                print(jsonResponse2);
                if(jsonResponse2["status"]){
                  var child_data = jsonResponse2["data"];
                  print(jsonResponse2["success"]);
                  String child_datas = jsonEncode(jsonResponse2);
                  print("Fetching child info to prefs");
                  print(child_data);
                  prefs.setString('childDatas', child_datas);
                }
              }
            }
            Navigator.push(context as BuildContext,MaterialPageRoute(builder: (context) => DashBoard(token: myToken)));
          }
          else{
            print('Something went wrong!');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                          height: 400,
                          padding:EdgeInsets.all(100),
                          child:Text(""),
                          decoration: const BoxDecoration(
                            color: MidnightBlue,
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      child:
                      ClipPath(
                        clipper: SignClip1(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          padding:EdgeInsets.fromLTRB(75,150,0,0),
                          child:Text("Welcome",
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
                          height: 400,
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
                    labelText: 'Email',
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
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 30,
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
                      color: colorWhite,
                      padding: EdgeInsets.all(20),
                      icon: Icon(
                          Icons.navigate_next
                      ),
                      onPressed: () async {
                        try{
                          loginUser();
                        }catch(err){
                          throw err;
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Container(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/update');
                    },
                    child: Container(child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                      ),
                    ),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}