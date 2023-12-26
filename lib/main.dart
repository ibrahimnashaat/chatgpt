import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/home.dart';
import 'package:task_chatgpt_app/shared_colors.dart';
import 'package:task_chatgpt_app/shared_preferences.dart';
import 'package:task_chatgpt_app/splash_screen.dart';

import 'chat.dart';
import 'on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cachHelper.init();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  Sizer(

        builder: (BuildContext context, Orientation orientation, DeviceType deviceType)
        {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: color4, // Change this color to your desired color
          ));
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(

            ),

            home:ChatPage(),
          );
        }
    );
  }
}
// initialRoute: '/',
// routes: {
// '/': (context) => SplashScreen(),
// '/home': (context) => HomePage(),
// },