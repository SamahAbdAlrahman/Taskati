import 'package:flutter/material.dart';
import 'package:taskati/screens/splash.dart';
import 'package:taskati/core/model/task_adapter.dart';
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


    // runApp(MyApp());
     @override
    Widget build(BuildContext context){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'taskite App',
            home:Theme(
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
              
              body: MyBody(),
              ),
            )
                    );
    }
}




















