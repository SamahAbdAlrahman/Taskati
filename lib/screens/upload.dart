import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/btn_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // file

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}
class _uploadState extends State<upload> { 
    File? _selectedImage; // لتخزين الصورة التي يتم اختيارها
  final ImagePicker _picker = ImagePicker(); // كائن لتحميل الصور
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




    ],
  )

),
            )
                    );

}
 }
