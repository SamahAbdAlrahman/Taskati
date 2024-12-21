import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets_and_constants/constants.dart';

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}
class _uploadState extends State<upload> { 
@override 
Widget build(BuildContext context) { 
          return MaterialApp(
          debugShowCheckedModeBanner: false,

            home: Scaffold(

body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 70,

      ),
      SizedBox(height: 25,),
      button('Upload from Camera'),
      SizedBox(height: 10,),
      button('Upload from Gallery'),


    ],
  )

),
            )
                    );

}

ElevatedButton button(String title) {
  return ElevatedButton(
      onPressed: ()=>{}, child: Text(title , style:btnTitle() ,),
       style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 11),
              backgroundColor: Constants.mainColor, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

            ),
      );
}
 }
