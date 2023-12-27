import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/shared/colors/shared_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
        return Scaffold(
          backgroundColor: mainColor,
          body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/chat_gpt_icon.png',
                  width: MediaQuery.of(context).size.width * 0.22,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'ChatGPT',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
