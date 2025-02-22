import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/screens/upload.dart';
import 'package:taskati/core/functions/navigator.dart';
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

      if (userBox.get("isUploaded") != null && userBox.get("isUploaded") == true) {
        pushReplace(context,home());
 
}
else
        pushReplace(context,upload());

    }    
    
   
    
    );
  }
    @override
    Widget build(BuildContext context){
        return  Container(
          color: Colors.white,

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/anim.json'),
                Text('Taskati',style: mainTitle(),),
                Text('its time to be organized',style: secTitle(),),
              ],


            ),
          ),
        );



    }
}
