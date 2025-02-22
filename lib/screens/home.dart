import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:taskati/screens/userProfile.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 80),

                   child:  Padding(
                     
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(

                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(imagePath)), // عرض الصورة
                          ),
                          SizedBox(height: 10,),
                          Text("${name}!",
                            style: TextStyle(
                                fontSize: 20,
                                color:Constants.blackColor
                            ),
                          ),
                          Divider(
                            color: Constants.greyColor.withOpacity(0.5),
                            height: 20,
                            thickness: 0.8,
                            indent: 20,
                            endIndent: 20,
                          ),
                          SizedBox(height: 40,),

                          drawerItem(title: "My Profile",icon: Icons.account_circle_outlined,SecondPage: profile(),),
                          SizedBox(height: 20,),
                          drawerItem(title: "Completed Tasks",icon: Icons.check_circle_outline),
                          SizedBox(height: 20,),
                          drawerItem(title: "Add Task",icon: Icons.add_comment_outlined),

                        ],


                    ),

                ),
              ),
            ),
        ),
        backgroundColor: Colors.white,

        // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, ${name}!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold ,
                            color:Constants.blackColor
                        ),
                      ),
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
                  print("Selected Date: ${selectedDate.value}");

                },
              ),

                            SizedBox(height: 20),

Expanded(

  child: ValueListenableBuilder(

    valueListenable: selectedDate, // تتسمع عل اتاريخ المختار

    builder: (context, DateTime date, _) {// لما يصير تغير رح يعيد بناء هاد
      return ValueListenableBuilder(

        valueListenable: Hive.box('task').listenable(), // تتسمع عل البوكس

        builder: (context,Box task_box,child){ // لما يصير تغير رح يعيد بناء هاد

// var tasks=task_box.values.toList();
          // var tasks = task_box.values.where((task) => task.isCompleted == false).toList();

          var filteredTasks = task_box.values.where((task) {
            // 1
            // date : 12/01/2025
            // (task.date) ->  DateTime
            DateTime taskDate = DateFormat("dd/MM/yyyy").parse(task.date).toLocal();

            // 2
            // Selected Date: 2025-01-12 00:00:00.000
            // تحويل التاريخ المختار إلى نفس التنسيق (12/01/2025)
            DateTime selectedDay = DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day);

            // 3
            return taskDate.isAtSameMomentAs(selectedDay) && task.isCompleted == false;
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

class drawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? SecondPage;

  const drawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.SecondPage


  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    // Icons.account_circle_outlined
          child: Icon( icon,
            color: Constants.mainColor,
            // size: 25,
          ),
        ),
        SizedBox(width: 8,),
        ElevatedButton(
          style:ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: (){
            pushReplace(context,SecondPage!);
          },
          child:
          Text(
            title , style: TextStyle(
              color:   Colors.black,
              fontSize: 16,
              // fontWeight: FontWeight.w500
          ),),
        ),
    
      ],
    );
  }
}
