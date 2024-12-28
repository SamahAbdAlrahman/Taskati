import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _selectedImage; // لتخزين الصورة التي يتم اختيارها
  final ImagePicker _picker = ImagePicker(); // كائن لتحميل الصور
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عرض الصورة إذا تم اختيار واحدة
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // فتح المعرض مباشرة عند الضغط على الزر
                try {
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                    });
                  }
                } catch (e) {
                  // التعامل مع أي أخطاء
                  print("Error picking image: $e");
                }
              },
              child: Text('Pick Image from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
