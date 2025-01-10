import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/btn_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/functions/navigator.dart';
import '../widgets_and_constants/constants.dart';
import 'home.dart'; // file

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}
class _uploadState extends State<upload> { 
  File? _selectedImage; // لتخزين الصورة التي يتم اختيارها
  final ImagePicker _picker = ImagePicker(); //  لتحميل الصور
  var nameController = TextEditingController();
  var NameFormKey = GlobalKey<FormState>();
    @override
Widget build(BuildContext context) { 
          return MaterialApp(
          debugShowCheckedModeBanner: false,

            home: Scaffold(

appBar: AppBar(
  actions: [
    TextButton(
        onPressed: ()async{
if(NameFormKey.currentState!.validate() ){

  // var userBox = await Hive.openBox('user'); // فتحناه في المين لانه 
  var userBox = Hive.box('user');

  userBox.put('name', nameController.text);
  userBox.put('image', _selectedImage?.path);
  userBox.put("isUploaded", true);


  pushReplace(context,home());

}
else if (_selectedImage == null) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error', style: mainTitle()),
        content: Text('Please select a profile image', style: secTitle()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

else {
  print("Invalid name !");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Invalid !' , style: mainTitle(),),
        content: Text('Enter Valid Name',style: secTitle(),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // إغلاق الـ Dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
        },
        child: Text("Done",style: TextStyle(color: Constants.mainColor,fontSize: 16),)),
    Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Icon(Icons.done,color: Constants.mainColor,),
    )

  ],
),
body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12),
  child: Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!) // تحميل الصورة إذا كانت موجودة
                        : null, // إذا لم يتم اختيار صورة، لا يتم عرض شيء
                    child: _selectedImage == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey) // رمز افتراضي
                        : null,
                  ),
          SizedBox(height: 30,),
          btnWidget(
      title:'Upload from Camera',
      onPress: () async {
                       final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.camera,
                      );
      
                      if (pickedFile != null) {
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                        });
                      }
      
                  },
        ),
      
          SizedBox(height: 10,),
          btnWidget(
      title:'Upload from Gallery',
      onPress: () async {
                       final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
      
                      if (pickedFile != null) {
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                        });
                      }
      
                  },
      
        ),
          SizedBox(height: 10,),
      
          Divider(
              color: Constants.greyColor,
              thickness: 1.5,
          indent: 20,
          endIndent: 20,
          ),
      
          SizedBox(height: 10,),
      
        Form(
          key: NameFormKey,
          child: TextFormField(
            validator: (value){
              if(value!.isEmpty){
                return "your name is required";
              }
              else if(!RegExp(r'^[A-Z][a-z]{2,8}$').hasMatch(value)){
                return "Name must start with a capital letter and be more than two characters !";
              }
              else
                return null; // كله تمام

            },
            controller: nameController,
          decoration: InputDecoration(
                hintText: "enter your name ...",
                hintStyle: secTitle(),
                labelText: "Name",
                enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.greyColor,

          ),
          borderRadius: BorderRadius.circular(10)
                )
          ,
                focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.mainColor,

            ),
            borderRadius: BorderRadius.circular(10)
                )
          ,


          ),
          ),
        ),
      
        ],
      ),
    )

  ),
),
            )
                    );

}
 }
