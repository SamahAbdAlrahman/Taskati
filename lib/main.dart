import 'package:flutter/material.dart';
import 'package:taskati/screens/splash.dart';
import 'package:taskati/core/model/task_adapter.dart';
import 'package:taskati/screens/userProfile.dart';
import 'package:taskati/widgets_and_constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
void main() async{
    // بالعادة لما استخدم async
    // في المين
    WidgetsFlutterBinding.ensureInitialized();

    //
    Hive.registerAdapter(TaskAdapter());
    await Hive.initFlutter();
    await Hive.openBox("user");
    await Hive.openBox("task");
    // await Hive.deleteFromDisk();

    runApp(MyApp());
    // runApp(profile());

}





















