import 'package:flutter/material.dart';

import 'constants.dart';

class custmList extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? c;
  final Function()? onPress;

  const custmList({
    super.key,
    required this.icon,
    required this.title,
    this.c,
    this.onPress,




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
            ElevatedButton(
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: onPress,
              child:
              Text(
                title , style: TextStyle(
                  color:  c ?? Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),),
            ),

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

