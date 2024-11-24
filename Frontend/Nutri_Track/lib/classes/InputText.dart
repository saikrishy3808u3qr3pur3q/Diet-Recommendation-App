import 'package:flutter/material.dart';
import '../variables.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.obsecureText,
    this.hasEnabled,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obsecureText;
  final bool? hasEnabled;

  // @override
  // void initState(){
  //   hasEnabled = true;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left : 4.0,right : 5.0),
      child: TextFormField(
        enabled: hasEnabled,
        keyboardType: TextInputType.emailAddress,
        obscureText: obsecureText,
        controller: controller,
        style : const TextStyle(
          color: blueShade1,
          //fontFamily: 'Schyler',
        ),
        textAlign: TextAlign.center,
        cursorColor: BabyBlue,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(
            icon,
            color : MidnightBlue,
            size: 25.0,
          ),
          // focusColor: Colors.yellow[900],
          hintText: hintText,
          hintStyle: TextStyle(
            color : blueShade1 ,
            fontSize: 12.0,
            //fontFamily: 'Schyler',
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color : colorWhite),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color : Colors.blue),
          ),
          contentPadding: EdgeInsets.only(top:15.0),
        ),
      ),
    );
  }
}