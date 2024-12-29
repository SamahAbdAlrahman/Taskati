import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';

class btnWidget extends StatelessWidget {
  
  const btnWidget({
    super.key,
    this.width=250,
    this.height=45,
    this.bgColor,
    this.txtColor,
    required this.onPress,
    required this.title,

  });

  final String title;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? txtColor;
  final Function() onPress;



  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: onPress,
         child:Text(title , 
         style:btnTitle(txtColor) ,),
         style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 11),
                backgroundColor: bgColor ?? Constants.mainColor, 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    
              ),
        ),
  );
}
}
