import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/home.dart';
import 'package:task_chatgpt_app/shared_colors.dart';
import 'package:task_chatgpt_app/shared_preferences.dart';




class Swiping {
  late final String image;
  late final String text1;
  late final String text2;
  late final String text3;
  late final String text4;

  Swiping({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  });
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<Swiping> swipingScreens = [
    Swiping(
        image: 'assets/images/icon1_onboarding.png',
        text1: 'Examples',
        text2: '"Explain quantum computing in simple terms"',
        text3: '"Got any creative ideas for a 10 year old’s birthday?"',
        text4: '"How do I make an HTTP request in Javascript?"'
    ),
    Swiping(
        image: 'assets/images/icon2_onboarding.png',
        text1: 'Capabilities',
        text2: 'Remembers what user said earlier in the conversation',
        text3: 'Allows user to provide follow-up corrections',
        text4: 'Trained to decline inappropriate requests'
    ),
    Swiping(
        image: 'assets/images/icon3_onboarding.png',
        text1: 'Limitations',
        text2: 'May occasionally generate incorrect information',
        text3: 'May occasionally produce harmful instructions or biased content',
        text4: 'Limited knowledge of world and events after 2021'
    ),

  ];

  var pageController = PageController();
  bool isLast = false;

  void submit() {
    cachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: color1,

      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
          top: 80.0
        ),
        child: SizedBox(

          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Image.asset('assets/images/chat_gpt_icon.png',

                  width: 6.w,
                  height: 6.h,

                ),


                SizedBox(
                  height: 2.h,
                ),

                Text('Welcome to',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: color2

                  ),

                ),
                Text('ChatGPT',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: color2

                  ),

                ),
                SizedBox(
                  height: 2.h,
                ),
                Text('Ask anything, get your answer',

                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: color2

                  ),

                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.54,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == swipingScreens.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        onBoarding(swipingScreens[index],index),
                    itemCount: swipingScreens.length,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color3
                  ),

                  child: MaterialButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        pageController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },

                    child: isLast?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Let\'s Chat',

                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: color2

                          ),

                        ),

                        SizedBox(
                          width: 2.w,
                        ),

                        Icon(
                          Icons.arrow_forward,
                          color: color2,
                          size: 16.0,
                        ),
                      ],
                    ): Text('Next',

                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: color2

                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget onBoarding(Swiping wid, int index) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        '${wid.image}',
        width: 6.w,
        height: 6.h,

      ),
      Text('${wid.text1}',

        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: color2

        ),

      ),
      SizedBox(
        height: 4.h,
      ),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color2.withOpacity(0.2)
        ),
        padding: EdgeInsets.all(20.0),
        child: Text(
          '${wid.text2}',
          //      'I have developed meaningful relationships with individuals of all ages, including seven-year-old Hillary. Many of my mentees come from disadvantaged backgrounds',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color2

          ),
        ),
      ),
      SizedBox(
        height: 2.h,
      ),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color2.withOpacity(0.2)
        ),
        padding: EdgeInsets.all(20.0),
        child: Text(
          '${wid.text3}',
          //      'I have developed meaningful relationships with individuals of all ages, including seven-year-old Hillary. Many of my mentees come from disadvantaged backgrounds',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color2

          ),
        ),
      ),
      SizedBox(
        height: 2.h,
      ),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color2.withOpacity(0.2)
        ),
        padding: EdgeInsets.all(20.0),
        child: Text(
          '${wid.text4}',
          //      'I have developed meaningful relationships with individuals of all ages, including seven-year-old Hillary. Many of my mentees come from disadvantaged backgrounds',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color2

          ),
        ),
      ),


      SizedBox(
        height: 4.h,
      ),


       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             width: MediaQuery.of(context).size.width*0.08,
             height: MediaQuery.of(context).size.height*0.002,
             color: index == 0 ? color3 : color2,
           ),
           SizedBox(
             width: 3.w,
           ),
           Container(
             width: MediaQuery.of(context).size.width*0.08,
             height: MediaQuery.of(context).size.height*0.002,
             color: index == 1 ? color3 :color2,
           ),
           SizedBox(
             width: 3.w,
           ),
           Container(
             width: MediaQuery.of(context).size.width*0.08,
             height: MediaQuery.of(context).size.height*0.002,
             color: index == 2 ? color3 :color2,
           ),
         ],
       ),

    ],
  );
}
