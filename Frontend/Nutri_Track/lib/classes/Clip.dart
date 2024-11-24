import 'package:flutter/cupertino.dart';

class BackgroundWaveClipper10 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    final p0 = size.height*0.6 ;
    path.moveTo(size.width, 0);
    path.moveTo(size.width, size.height*0.1);
    final cp_x=size.width*0 - size.width*1.0;
    final cp_y=size.height *0.5;
    final ep_x=size.width;
    final ep_y=size.height*0.9;
    path.quadraticBezierTo(cp_x, cp_y, ep_x, ep_y);
    //path.lineTo(size.width, size.height);
    //path.lineTo(0, size.height);
    path.close();
    return path;
  }
  // Path getClip(Size size) {
  //   var path = Path();
  //   final p0 = size.height*0.6 ;
  //   path.lineTo(0.0, p0);
  //   final cp_x=size.width*0.36;
  //   final cp_y=size.height *0.3;
  //   final ep_x=size.width;
  //   final ep_y=size.height/2;
  //   path.quadraticBezierTo(cp_x, cp_y, ep_x, ep_y*0.6);
  //   path.lineTo(size.width, 0.0);
  //   path.close();
  //   return path;
  // }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    oldClipper != this;
    return true;
  }
}

class Cardwaveclip extends CustomClipper<Path>{
  @override
  @override
  Path getClip(Size size) {
    var path = Path();
    final p0 = size.height ;
    path.moveTo(size.width* 0.85, 0);
    path.lineTo(size.width*0.6,size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width,0);
    path.close();
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
class outlinewaveclip extends CustomClipper<Path>{
  @override
  @override
  Path getClip(Size size) {
    var path = Path();
    final p0 = size.height ;
    path.moveTo(size.width* 0.83, 0);
    path.lineTo(size.width*0.58,size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width,0);
    path.close();
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

class ReverseCurve extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    final p0 = size.height*0.8;
    path.moveTo(0,550);
    //path.lineTo(0,600);
    final cp_x=size.width*0.4;
    final cp_y=900.0;
    final ep_x=size.width;
    final ep_y=size.height*0.9;
    path.quadraticBezierTo(cp_x, cp_y, ep_x, ep_y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    oldClipper != this;
    return true;
  }
}