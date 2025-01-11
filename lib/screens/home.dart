import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/task_widget.dart';
import '../widgets_and_constants/btn_widget.dart';
import '../widgets_and_constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/screens/addTask.dart';
import 'package:taskati/screens/completedTasks.dart';


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
     ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(DateTime.now()); //

    return Scaffold(
        backgroundColor: Colors.white,

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
              btnWidget(onPress: () {
                push(context,CompletedTasksPage());
              }, title: 'Completed Tasks  ✔️',width: 600,),

              SizedBox(height: 25,),

              Row(
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
                  selectedDate.value = date;
                  print(selectedDate.value);

                },
              ),

                            SizedBox(height: 20),

Expanded(
child: ValueListenableBuilder(
valueListenable: selectedDate,
    builder: (context, DateTime date, _) {

      return ValueListenableBuilder(
        valueListenable: Hive.box('task').listenable(), // تتسمع عل البوكس
        builder: (context,Box task_box,child){ // لما يصير تغير رح يعيد بناء هاد
          // كلهن
          // var tasks=task_box.values.toList();
          // تاسكات مش مكتملة الكل
          // var tasks = task_box.values.where((task) => task.isCompleted == false).toList();

          // var task_by_Date = task_box.values.where((task) {
          //   return task.date.toString().substring(0, 10) ==
          //       date.toString().substring(0, 10);
          // }).toList();
          DateFormat dateFormat = DateFormat('yyyy-MM-dd');  // تعديل التنسيق حسب الحاجة

          var filteredTasks = task_box.values.where((task) {
            DateTime taskDate = DateTime.parse(task.date);  // تأكد من التنسيق الصحيح
            String taskDateFormatted = dateFormat.format(taskDate);
            String selectedDateFormatted = dateFormat.format(selectedDate.value);

            return taskDateFormatted == selectedDateFormatted && task.isCompleted == false;
          }).toList();


          return  ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (contex,index){
                return Dismissible(

                  child: TaskWidget(task:filteredTasks[index] ,),

                  onDismissed: (direction) {
                    var completed_task = task_box.getAt(index); // يلي سحبناه

                    if (direction == DismissDirection.startToEnd) {
                      // تاسكات مكتملة
                      //  السحب من اليسار إلى اليمين
                      completed_task.isCompleted = true;
                      task_box.put(completed_task.id, completed_task);


                    } else if (direction == DismissDirection.endToStart) {
                      // من اليمين إلى اليسار
                      task_box.deleteAt(index);
                    }
                  },

                  key: UniqueKey(),
                  // done
                  background: Container(
                    margin: EdgeInsets.only(bottom: 17 ,top: 2),
                    decoration: BoxDecoration(

                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(2, 4),
                            blurRadius: 6,            // تشويش
                            spreadRadius: 1,          //مدى الانتشار
                          ),
                        ]

                    ),
                    child: Row(
                      children: [
                        Icon(Icons.done , color: Colors.white),
                        Text("Done" ,style: btnTitle(Colors.white), ),
                      ],
                    ),
                  ),
                  // delete
                  secondaryBackground: Container(
                    margin: EdgeInsets.only(bottom: 17 ,top: 2),

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 4),
                          blurRadius: 6,            // تشويش
                          spreadRadius: 1,          //مدى الانتشار
                        ),
                      ],
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),


                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Delete" ,style: btnTitle(Colors.white), ),

                        Icon(Icons.delete , color: Colors.white),
                      ],
                    ), ),


                  // task

                );
              }
          );
        },
      );
    },
),
),

            ],
          ),

        ),
      )
    );
  }

}
