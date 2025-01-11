import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/widgets_and_constants/header_profile.dart';
import 'dart:io';
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
          Navigator.pop(context);
          // push(context, home());
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

class custmList extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? c;
  const custmList({
    super.key,
    required this.icon,
    required this.title,
     this.c,



  });

  @override
  Widget build(BuildContext context) {
    return Row(
    
    children: [
      Row(
    children: [
      Container(
        padding:EdgeInsets.all(6) ,
         decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.mainColor.withOpacity(0.5),
                    boxShadow :[
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 1,            // تشويش
                        spreadRadius: 2.5,          //مدى الانتشار
                      ),
                    ]
                ),
        child: Icon(icon , 
        color: Constants.mainColor,
        // size: 25,
        ),
      ),
      SizedBox(width: 15,),
      Text(
        title , style: TextStyle(
          color: c,
          fontSize: 18,
              fontWeight: FontWeight.w500
      ),),
    
      ],
      ),
      Spacer(),
       Container(
        padding:EdgeInsets.all(8) ,
         decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(181, 158, 158, 158).withOpacity(0.23),
                    boxShadow :[
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 1,            // تشويش
                        spreadRadius: 2.5,          //مدى الانتشار
                      ),
                    ]
                ),
        child: Icon(Icons.arrow_forward_ios_rounded,
                  color: const Color.fromARGB(255, 141, 140, 140),
        size: 20,
        ),
      ),
     
    ],    );
  }
}

