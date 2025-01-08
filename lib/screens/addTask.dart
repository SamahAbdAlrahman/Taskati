
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets_and_constants/constants.dart';

class addTask extends StatefulWidget{
  @override
  addTaskState createState() => addTaskState();

}
class addTaskState  extends State<addTask>{
  var titleControler = TextEditingController();
  var noteControler = TextEditingController();
  var dateControler = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        backgroundColor:Constants.mainColor ,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text("Add Task" , style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),
              TextFormField(
                controller: titleControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Task Title',
                ),
              ),
              Text("Note", style: TextStyle(color: Constants.mainColor , fontSize: 17 , fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),
              TextFormField(
                controller: noteControler,
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
      lastDate: DateTime(2027), // أكبر تاريخ يمكن اختياره
    );

    if (selectedDate != null) {
      dateControler.text = DateFormat("dd/MM/yyyy").format(selectedDate);
    }
  },
                readOnly: true,
                controller: dateControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                  ),
                  suffixIcon: Icon(Icons.calendar_month ,color: Constants.mainColor,)
                ),
              ),
            ],
          ),
        ),
      ),);
  }}