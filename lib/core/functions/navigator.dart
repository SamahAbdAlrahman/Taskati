import 'package:flutter/material.dart';

push(BuildContext context,Widget SecondPage){
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SecondPage;
  }));

}
pushReplace(BuildContext context,Widget SecondPage){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return SecondPage;
  }));

}