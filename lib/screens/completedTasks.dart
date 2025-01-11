import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/widgets_and_constants/task_widget.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:taskati/screens/home.dart';


class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    backgroundColor: Constants.mainColor,
    leading: IconButton(
        onPressed: (){
          // Navigator.pop(context);
          push(context, home());
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
title: Text("Completed Tasks",
style: TextStyle(
  color: Colors.white,
  // fontSize: 22,
  fontWeight: FontWeight.w500
),),
    centerTitle: true,

  ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
            "Great job! Keep going and complete your tasks!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('task').listenable(),
                  builder: (context, Box taskBox, child) {
                    var tasks = taskBox.values.where((task) => task.isCompleted == true).toList();

                    if (tasks.isEmpty) {
                      return Center(child: Text("No completed tasks yet!"));
                    }

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var task = tasks[index];
                        return TaskWidget(task: task); // عرض المهمة
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
