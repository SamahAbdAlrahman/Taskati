import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/screens/upload.dart';
import 'package:taskati/functions/navigator.dart';
import 'package:lottie/lottie.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home.dart'; 

class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'taskite App',
            home: Scaffold(

body: MyBody(),
            )
                    );
    }
}
class MyBody extends StatefulWidget{
    @override
myState createState() => myState();
}

class myState extends State<MyBody> {
  void initState() {
    super.initState();

    var userBox =  Hive.box('user');


    Future.delayed(Duration(seconds: 5), () {

if(userBox.get("isUploaded")){
 push(context,home());
 
}
else
push(context,upload());

    }    
    
   
    
    );
  }
    @override
    Widget build(BuildContext context){
        return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/anim.json'),
              Text('Taskati',style: mainTitle(),),
              Text('its time to be organized',style: secTitle(),),
            ],
            
           
          ),
        );



    }
}
