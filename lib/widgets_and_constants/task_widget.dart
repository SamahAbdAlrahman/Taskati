import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/widgets_and_constants/constants.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15 , right: 1, left:1),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
                    BoxShadow(
        color: Colors.grey.withOpacity(0.5), 
        offset: Offset(2, 4),               
        blurRadius: 6,            // تشويش           
        spreadRadius: 1,          //مدى الانتشار           
      ),
                  ],
          borderRadius: BorderRadius.circular(10),
          // color: Constants.mainColor,
          color: task.Color==0?Constants.mainColor
          : task.Color==1?Colors.deepOrange
          :Colors.orangeAccent, 

        ),
        child: Row(
          children: [
      Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(task.title ,
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
        
            Text("${task.startTime} : ${task.endTime}",style: TextStyle(
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
       
      RotatedBox(
        quarterTurns: 3,
      child:Text("TODO" ,style:TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500
        ) ,), 
        ),
          ],
        )
      );
  }
}