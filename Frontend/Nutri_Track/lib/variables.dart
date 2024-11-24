import 'package:flutter/material.dart';

String user_name = "";
String child_name = "";
double child_height = 1.0;
double child_weight = 1.0;
double child_age = 1.0;
double weight_to_lose = 0.0;
double weeks_needed = 0.0;
double bmr_needed = 0.0;
double activity_level = 0.0;
double gender_child_male = 0.0;
double gender_child_female = 0.0;

final url = "https://node-nutritrack.onrender.com/";
final signup_url = url + "registration";
final signin_url = url + "login";
final child_entry_url = url + "childEntry";
final child_retrieve_url = url + "childRetrieve";

Color def_color = Color(0xFFD8BCFC);
const MidnightBlue=Color.fromRGBO(12, 97, 112,1);
const BlueGreen =Color.fromRGBO(55, 190, 176,1);
const TiffanyBlue =Color.fromRGBO(164, 229, 224,1);
const BabyBlue=Color.fromRGBO(219,245,240,1);
const aqua=Color.fromRGBO(4, 236,240,1);
const background=Color.fromRGBO(207, 255,248,1);
const Color colorWhite = Colors.white;
const Color colorGrey = Colors.grey;
const blueShade1 = Color.fromRGBO(33, 158, 188,1);