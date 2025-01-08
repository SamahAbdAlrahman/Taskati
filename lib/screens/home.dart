import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../widgets_and_constants/btn_widget.dart';
import '../widgets_and_constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/functions/navigator.dart';
import 'package:taskati/screens/addTask.dart';

class home extends StatefulWidget{
  @override
  homeState createState() => homeState();

}
class homeState  extends State<home>{
  @override
  Widget build(BuildContext context) {
    var userBox =  Hive.box('user');
    String name = userBox.get('name');
    String imagePath = userBox.get('image');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, ${name}!",style: mainTitle(),),
                      Text("Have a nice day",style: secTitle()),
                    ],
                  ),
Spacer(),
               CircleAvatar(
                 radius: 60,
                 backgroundImage: FileImage(File(imagePath)), // عرض الصورة
               ),
                ],
              ),
           SizedBox(height: 25,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMd().format(DateTime.now()),style: mainTitle(),),
                      Text("Have a nice day",style: secTitle()),
                    ],
                  ),
                  Spacer(),
                  btnWidget(onPress: () { 
                    pushReplace(context,addTask());
                   }, title: '+ add task',width: 135,),
                ],
              ),
              SizedBox(height: 20),
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Constants.mainColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  // setState(() {
                  //   _selectedValue = date;
                  // });
                },
              ),
                            SizedBox(height: 20),

Expanded(
child: ListView.builder(
  itemCount: 5,
  itemBuilder: (contex,index){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.mainColor,
      ),
      child: Row(
        children: [
Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("data cfghjkl fghjkl;tghyui ofghjkl;fghjkl fghjkl" ,
        maxLines: 1, // عدد الأسطر المسموح فيها
  overflow: TextOverflow.ellipsis, // ... 
  style:TextStyle(
        fontSize: 17,
        color: Colors.white,
      ) ,),
      SizedBox(height: 5,),
      Row(
  
        children: [
          Icon(Icons.watch_later_outlined,
          color: Colors.white,
          size: 20,),
              SizedBox(width: 3,),
  
          Text("10Am - 11Am",style: TextStyle(
            color: Colors.white
          ),
          ),
  
        ],
      )
    ],
  ),
),

Container(
height: 50,
width: 1,
color: Colors.white,
),
     
    RotatedBox(quarterTurns: 3,
    child:Text("TODO" ,style:TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w500
      ) ,), ),
        ],
      )
    );
  }
),
),
            ],
          ),

        ),
      )
    );
  }

}