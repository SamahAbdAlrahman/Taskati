import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets_and_constants/btn_widget.dart';

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
      SizedBox(height: 30,),
      btnWidget(
  title:'Upload from Camera',
  onPress: () {
print('from Camera');
  },
),
      
      SizedBox(height: 10,),
      btnWidget(
  title:'Upload from Gallery',
  onPress: () {
print('from Gallery');
  },
),




    ],
  )

),
            )
                    );

}
 }
