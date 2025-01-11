
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets_and_constants/constants.dart';
import '../widgets_and_constants/btn_widget.dart';
import 'package:taskati/core/functions/navigator.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/model/task_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/screens/home.dart';



class addTask extends StatefulWidget{
  @override
  addTaskState createState() => addTaskState();

}
class addTaskState  extends State<addTask>{
  var _formKey = GlobalKey<FormState>();
  var titleControler = TextEditingController();
  var noteControler = TextEditingController();
  var dateControler = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  var start_dateControler = TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  var end_dateControler = TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));
  int selectedColor=0;


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color:  Constants.redColor, width: 1.5), // الإطار عند الخطأ
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color:  Constants.redColor, width: 2.5), // الإطار عند التركيز مع الخطأ
          ),
          errorStyle: TextStyle(
            color: Constants.redColor,
            fontSize: 14,
          ),

        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(

          backgroundColor:Constants.mainColor ,
          leading: IconButton(
            onPressed: (){
           pushReplace(context,home());
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          title: Text("Add Task" , style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: titleControler,
                    validator: (value){
                      if(value==null){
                        return "Title is required";
                      }
                      if(value.length<3){
                        return "Title is invalid";
                      }
                      return null;

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Task Title',
                      // labelStyle: TextStyle(color: Constants.redColor)
                    ),
                  ),
                  Text("Note", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: noteControler,
                     validator: (value) {
      if ( value!.isEmpty) {
        return "Note is required";
      }


      return null;
        },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your Notes',
                    ),
                    maxLines: 4,
                  ),
                  Text("Date", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
                  SizedBox(height: 5,),
                  TextFormField(
                    // use intl
                    onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), // تاريخ البداية (اليوم الحالي)
                    firstDate: DateTime.now(), // أقل تاريخ يمكن اختياره
                    lastDate: DateTime(2030), // أكبر تاريخ يمكن اختياره
                  );

                  if (selectedDate != null) {
                    dateControler.text = DateFormat("dd/MM/yyyy").format(selectedDate);
                  }
                },
                    readOnly: true,
                    controller: dateControler,
                    validator: (value) {
      if (value!.isEmpty) {
        return "Date is required";
      }

      DateTime selectedDate = DateFormat("dd/MM/yyyy").parse(value);

       if (selectedDate.isAfter(DateTime(2027))) {
        return "date is so far";
      }
      return null;
        },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      suffixIcon: Icon(Icons.calendar_month ,color: Constants.mainColor,)
                    ),
                  ),
                              SizedBox(height: 5,),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Time", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
                          TextFormField(
                            controller: start_dateControler ,
                            onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()).then((value){
                      if (value!=null) {start_dateControler.text = value.format(context);}
                    });


                },

                            readOnly: true,
                             decoration: InputDecoration(
                              suffixIcon: Icon(Icons.access_time, color:Constants.mainColor ),
                      border: OutlineInputBorder(),
                    ),
                          ),
                        ],
                      ),
                      ),
                                                SizedBox(width: 13,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Time", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
                          TextFormField(
                            controller:end_dateControler ,
//                               validator: (value) {
// // حولنا من نص ل DateTime  
// // باستخدام DateFormat 
//              String startTime = start_dateControler.text;  
// DateTime startDateTime = DateFormat("hh:mm a").parse(startTime);

// String endTime = end_dateControler.text; 
// DateTime endDateTime = DateFormat("hh:mm a").parse(endTime);


    
// // ذا وقت البداية أكبر من وقت النهاية 
//      if (startDateTime.isAfter(endDateTime)) {
//     return "End time must be after Start time";
//   }
//     return null; // إذا ما في خطأ
//   },
                            onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()).then((value){
                      if (value!=null) {end_dateControler.text = value.format(context);}
                    });


                },
                               readOnly: true,
                             decoration: InputDecoration(
                              suffixIcon: Icon(Icons.access_time , color:Constants.mainColor ,),
                      border: OutlineInputBorder(),
                    ),
                    ),
                        ],
                      ),
                      ),
                    ],
                  ),

                SizedBox(height: 10,),
               Row(
                children: [
                   Row(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
              setState(() {
                selectedColor = index;
              });
                      },
                      child: CircleAvatar(
              radius: 12,
              backgroundColor: index == 0
                  ? Constants.mainColor
                  : index == 1
                      ? Colors.deepOrange
                      : Colors.orangeAccent,
              child: selectedColor==index
              ?Icon(
                Icons.check,
                color: Colors.white,
              ) : null

                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              btnWidget(
                title: "Add Task",
                width: 150,
                onPress: (){
              if(_formKey.currentState!.validate()){
      TaskModel newTask = TaskModel(
        id: DateTime.now().toString() + titleControler.text, // المهم شي uniq
        // او ممكن استخدم
        // id :UniqueKey(),
       title: titleControler.text,
       note: noteControler.text,
       date: dateControler.text,
       startTime: start_dateControler.text,
       endTime: end_dateControler.text,
       Color: selectedColor,
       isCompleted: false
       ) ;
       var task_box = Hive.box("task");

       task_box.put(newTask.id, newTask); // key , value
print("task added done , task info : ");

      print("id : ${task_box.get(newTask.id)?.id}");
      print("title : ${task_box.get(newTask.id)?.title}");
      print("date : ${task_box.get(newTask.id)?.date}");



          pushReplace(context, home());
              }
              else{
                // في مشكلة بالقيم
                // بفحص اذا من الوقت


                // حولنا من نص ل DateTime  
// باستخدام DateFormat 
             String startTime = start_dateControler.text;  
DateTime startDateTime = DateFormat("hh:mm a").parse(startTime);

String endTime = end_dateControler.text; 
DateTime endDateTime = DateFormat("hh:mm a").parse(endTime);

String? errorMsg;
    
// ذا وقت البداية أكبر من وقت النهاية 
     if (startDateTime.isAfter(endDateTime)) {
    errorMsg= "End time must be after Start time";
  }
    if(errorMsg!=null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Constants.redColor,
          duration:Duration(seconds: 7),

              action: SnackBarAction(
      label: "ok", 
      textColor:Colors.white,
      backgroundColor:Colors.red,

      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
        ),
      );
    }

              }
                },),

                ],
               )
                  ],
              ),
            ),
          ),
        ),),
    );
  }}