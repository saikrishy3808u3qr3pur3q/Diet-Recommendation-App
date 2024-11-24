import 'package:flutter/material.dart';

class SignClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =Path();
    var hei = size.height;
    var wid =size.width;
    print("$hei$wid");
    // path.moveTo(0, 0);
    path.lineTo(0, 150);
    path.quadraticBezierTo(size.width/2,size.height*0.2, size.width*0.6, 0);
    /*final controlPoint = Offset(size.width * 0.6, size.height 0.5);
    final endPoint = Offset(size.width, size.height / 2);
    */
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    oldClipper != this;
    return true;
  }

}
class SignClip1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =Path();
    var hei = size.height;
    var wid =size.width;
    print("$hei$wid");
    // path.moveTo(0, 0);
    path.lineTo(0, 250);
    path.quadraticBezierTo(size.width*0.7,size.height*0.8, size.width*1.5, size.height*0.3);
    /*final controlPoint = Offset(size.width * 0.6, size.height 0.5);
    final endPoint = Offset(size.width, size.height / 2);
    */
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    oldClipper != this;
    return true;
  }

}
class SignClip2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =Path();
    var hei = size.height;
    var wid =size.width;
    print("$hei$wid");
    // path.moveTo(0, 0);
    path.moveTo(size.width*0.6,0);
    path.quadraticBezierTo(size.width/2,size.height, size.width*1.5, size.height*0.6);
    /*final controlPoint = Offset(size.width * 0.6, size.height 0.5);
    final endPoint = Offset(size.width, size.height / 2);
    */
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    oldClipper != this;
    return true;
  }

}