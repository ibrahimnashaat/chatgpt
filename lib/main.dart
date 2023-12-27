import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/layout/home.dart';
import 'package:task_chatgpt_app/shared/colors/shared_colors.dart';
import 'package:task_chatgpt_app/shared/cach_helper/shared_preferences.dart';
import 'package:task_chatgpt_app/layout/splash_screen.dart';

import 'chat_pages/chat.dart';
import 'layout/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cachHelper.init();

  Widget widget;
  var onBoarding = cachHelper.getData(key: 'onBoarding');


    if (onBoarding != null) {
      widget = HomePage();
    } else {
      widget = OnBoarding();
    }


  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    required this.startWidget,

  });
  @override
  Widget build(BuildContext context) {

    return  Sizer(

        builder: (BuildContext context, Orientation orientation, DeviceType deviceType)
        {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: homePageColor, // Change this color to your desired color
          ));
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(

            ),

            home: HomePage(),

            // initialRoute: '/',
            // routes: {
            // '/': (context) => SplashScreen(),
            // '/home': (context) => startWidget,
            // },
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