import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/shared_colors.dart';
import 'package:task_chatgpt_app/splash_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:color4,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: [

              SizedBox(
                height: 1.h,
              ),

             Column(
               children: [
                 Padding(
                   padding: EdgeInsets.only(top: 10.0),
                   child: Container(
                     width: double.infinity,

                     child: MaterialButton(
                       onPressed: (){},
                       child: Row(
                         children: [
                           Icon(Icons.chat_bubble_outline,
                             color: color2,
                             size: 20,
                           ),
                           SizedBox(
                             width: 4.w,
                           ),
                           Text('New Chat',
                             style: TextStyle(
                                 fontFamily: 'Raleway',
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.w700,
                                 color: color2

                             ),),
                           Spacer(),
                           Icon(Icons.arrow_forward_ios,
                             color: color2,
                             size: 20,
                           )
                         ],
                       ),

                     ),
                   ),
                 ),
                 Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: 20,
                     end: 20,
                   ),
                   child: Container(
                     width: double.infinity,
                     height: MediaQuery.of(context).size.height*0.0005 ,
                     color: color2,
                   ),
                 ),
               ],
             ),
             SizedBox(
               height: 1.h,
             ),
             SizedBox(
               width: double.infinity,
               height: MediaQuery.of(context).size.height*0.5,
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.only(top: 10.0),
                     child: Container(
                       width: double.infinity,

                       child: MaterialButton(
                         onPressed: (){},
                         child: Row(
                           children: [
                             Icon(Icons.chat_bubble_outline,
                               color: color2.withOpacity(0.6),
                               size: 20,
                             ),
                             SizedBox(
                               width: 4.w,
                             ),
                             Text('New Chat',
                               style: TextStyle(
                                   fontFamily: 'Raleway',
                                   fontSize: 12.sp,
                                   fontWeight: FontWeight.w500,
                                   color: color2

                               ),),
                             Spacer(),
                             Icon(Icons.arrow_forward_ios,
                               color: color2.withOpacity(0.6),
                               size: 20,
                             )
                           ],
                         ),

                       ),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsetsDirectional.only(
                       start: 20,
                       end: 20,
                     ),
                     child: Container(
                       width: double.infinity,
                       height: MediaQuery.of(context).size.height*0.0005,
                       color: color2,
                     ),
                   ),
                 ],
               ),
             ),

              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.001 ,
                color: color2,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,

                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline,
                          color: color2.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('Clear conversations',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: color2

                          ),),

                      ],
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,

                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.person_outline,
                          color: color2.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('Upgrade to Plus',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: color2

                          ),),
                        Spacer(),
                       Container(
                         width: MediaQuery.of(context).size.width*0.15,
                         height: MediaQuery.of(context).size.height*0.028,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           color: color2,
                         ),
                         child: Text('NEW',
                           style: TextStyle(
                               fontFamily: 'Raleway',
                               fontSize: 12.sp,
                               fontWeight: FontWeight.w600,
                               color: color3

                           ),
                         textAlign: TextAlign.center,
                         ),
                       ),
                      ],
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,

                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.light_mode_outlined,
                          color: color2.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('Light mode',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: color2

                          ),),

                      ],
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,

                  child: MaterialButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.update,
                          color: color2.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('Updates & FAQ',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: color2

                          ),),

                      ],
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,

                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('Logout',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent

                          ),),

                      ],
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
