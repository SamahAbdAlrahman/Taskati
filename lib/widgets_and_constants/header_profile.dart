import 'package:flutter/material.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class headerProfile extends StatefulWidget {
  
  const headerProfile({
    super.key,
    // required this.imagePath,
    // required this.name,
  });

  // final String imagePath;
  // final String name;

  @override
  State<headerProfile> createState() => _headerProfileState();
}
class _headerProfileState extends State<headerProfile> {
  @override
  Widget build(BuildContext context) {
        var userBox =  Hive.box('user');
    String name = userBox.get('name');
    String imagePath = userBox.get('image');
      TextEditingController nameController = TextEditingController();

    return Center(
      child: Container(
    
        margin: EdgeInsets.only(top: 40,bottom: 10 ),
        child: Column(
          children: [
            Stack(
              children: [
                // img
                Container(
                  decoration: BoxDecoration(
    
                      boxShadow :[
                        BoxShadow(
                          color: Constants.mainColor.withOpacity(0.5),
                          offset: Offset(0, 0),
                          blurRadius: 60,            // تشويش
                          // spreadRadius: 0,          //مدى الانتشار
                        ),
                      ],
                    shape: BoxShape.circle,
                    border: Border.all(      // إضافة الإطار
                      color: Colors.white,    // لون الإطار
                      width: 2,              // سمك الإطار
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage : FileImage(File(imagePath)),
                  ),
                ),
              //  icon
                Container(
    
                  padding:EdgeInsets.all(2),
                  margin:EdgeInsets.only(
                      // top: 110 ,
                      left: 105
                  ) ,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constants.mainColor,
                      boxShadow :[
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                          blurRadius: 1,            // تشويش
                          spreadRadius: 2.5,          //مدى الانتشار
                        ),
                      ]
                  ),
    
                    child: IconButton(
                      icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                       size: 25,
                                 ),
                             onPressed: () {
                              showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
   
        shadowColor :  Constants.mainColor,
        backgroundColor : Colors.white,
        title: Text("Choose what to edit"),
        // titleTextStyle: TextStyle(fontSize: 22),/
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // img
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Edit your image"),
              onTap: ()async {
// 

                Navigator.pop(context); 
                 showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
             shadowColor :  Constants.mainColor,
        backgroundColor : Colors.white,
          title: Text("Choose Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () async {
                  Navigator.pop(context); 
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    setState(() {
                      var userBox = Hive.box('user');
                      userBox.put('image', pickedImage.path); 
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context); 
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    setState(() {
                      var userBox = Hive.box('user');
                      userBox.put('image', pickedImage.path); 
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
              },
            ),
            // name
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit your name"),
              onTap: () {
                Navigator.pop(context); 
       showDialog(
    context: context,
    builder: (BuildContext context) {
                    String? errorText;

      return AlertDialog(
        
         shadowColor :  Constants.mainColor,
        backgroundColor : Colors.white,
        title: Text(""),
        content: TextField(
          controller: nameController,
          // errorText:errorText,
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "write here your name",
            border: OutlineInputBorder(),
           errorText: errorText,

          ),
          
        ),
        
        actions: [
         
          TextButton(
            child: Text("Save"),

            onPressed: () {
              var userBox = Hive.box('user'); 



              userBox.put('name', nameController.text);
              Navigator.pop(context); 
              setState(() {
                        userBox.put('name', nameController.text);
                        name = userBox.get('name');

              });


            },
          ),
           TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context); 
            },
            
          ),
        ],
      );
    },
  ); 
 },
            ),
           //  cancel
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text("Cancel"),
              onTap: () {
                Navigator.pop(context);  
              },
            ),
          ],
        ),
      );
    },
  );
                               },
    
  ),
    
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("${name}",
                style: TextStyle(
                color: Constants.mainColor,
                fontSize: 21,
                fontWeight: FontWeight.w500
            ),
        ),
            Divider(
              color: Constants.mainColor.withOpacity(0.5),
              height: 30,         
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        )
      ),
    );
  }
}
