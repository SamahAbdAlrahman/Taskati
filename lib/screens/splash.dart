import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/screens/upload.dart';
import 'package:taskati/functions/navigator.dart';
import 'package:lottie/lottie.dart';

import 'package:hive_flutter/hive_flutter.dart';

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

    Future.delayed(Duration(seconds: 5), () {

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
