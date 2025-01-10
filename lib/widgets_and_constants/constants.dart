import 'package:flutter/material.dart';

class Constants {
  static const Color mainColor =Color.fromARGB(255, 78, 91, 232); 
  static const Color greyColor = Color.fromARGB(157, 0, 0, 0); 
  static const Color blackColor = Color.fromARGB(250, 0, 0, 0);
  static const Color redColor = Color.fromARGB(255, 248, 17, 0);
// Constants.redColor

}
TextStyle mainTitle (){
  return TextStyle(
    fontSize: 30, 
    fontWeight: FontWeight.bold ,
    color:Constants.blackColor 
    );
}
TextStyle secTitle (){
  return TextStyle(
    fontSize: 14,
    color:Constants.greyColor
    );
}
TextStyle btnTitle(Color? r) {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: r ?? Colors.white,
  );
}
