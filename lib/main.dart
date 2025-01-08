import 'package:flutter/material.dart';
import 'package:taskati/screens/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
void main() async{
    // بالعادة لما استخدم async
    // في المين
    WidgetsFlutterBinding.ensureInitialized();

    //
    await Hive.initFlutter();
    await Hive.openBox("user");

    runApp(MyApp());
}




















