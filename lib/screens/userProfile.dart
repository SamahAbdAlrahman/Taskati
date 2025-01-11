import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/widgets_and_constants/header_profile.dart';
import 'dart:io';
import '../widgets_and_constants/list_widget.dart';
import 'home.dart';
class profile extends StatefulWidget{
  @override
profileStet createState() => profileStet();
}
class profileStet extends State <profile>{
  @override
  Widget build(BuildContext context) {
    var userBox =  Hive.box('user');
    String name = userBox.get('name');
    String imagePath = userBox.get('image');

return MaterialApp(
  debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
  appBar: AppBar(
    backgroundColor: Constants.mainColor,
    leading: IconButton(
        onPressed: (){
          // Navigator.pop(context);
          push(context, home());
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
title: Text("Profile",
style: TextStyle(
  color: Colors.white,
  // fontSize: 22,
  fontWeight: FontWeight.w500
),),
    centerTitle: true,

  ),
  body: SingleChildScrollView(
    child: Column(
      children: [
    headerProfile(),
    
    Container(
    child:  Padding(
                padding: EdgeInsets.only(left: 45,right: 45,top: 12),
                child:Column(
    children: [
     
    
        custmList(icon: Icons.settings,title: "Setting",),
        SizedBox(height: 20,),
        custmList(icon: Icons.person_pin,title: "User Management",),
        SizedBox(height: 20,),
              custmList(icon: Icons.info,title: "Information",),
    
        SizedBox(height: 59,),
              custmList(icon: Icons.feed,title: "Feedback",),
    
        SizedBox(height: 20,),
        custmList(icon: Icons.logout,title: "Logout",c:Constants.redColor),
    
    
    
        
    
    ],
    ),
    ),
    )
      ],
    ),
  ),
),
);
  }
}

