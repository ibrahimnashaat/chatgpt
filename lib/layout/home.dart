import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/shared/colors/shared_colors.dart';
import 'package:task_chatgpt_app/layout/splash_screen.dart';
import '../chat_pages/chat.dart';
import '../shared/database/database.dart';
import '../chat_pages/generated_chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseHelper _databaseHelper;

  String newChatButtonText = 'loading...';

  bool clicked = false;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _fetchMessagesFromDatabase(context);
  }

  Future<void> _fetchMessagesFromDatabase(BuildContext context) async {
    try {
      List<Map<String, dynamic>> messages = await _databaseHelper.getMessages();
      print('Messages from the database: $messages');

      String lastUserMessage = getLastUserMessage(messages);

      setState(() {
        newChatButtonText =
            lastUserMessage.isNotEmpty ? lastUserMessage : 'Loading...';
      });

      if (clicked) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GeneratedChat(databaseMessages: messages)),
        );
      }
    } catch (e) {
      print('Error fetching messages from the database: $e');
    }
  }

  String getLastUserMessage(List<Map<String, dynamic>> messages) {
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i]['messageType'] == 'user') {
        return messages[i]['text'];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: homePageColor,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatPage()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              'New Chat',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: white),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.0005,
                      color: white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              newChatButtonText != "Loading..."
                  ? Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    clicked = true;
                                    _fetchMessagesFromDatabase(context);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: white.withOpacity(0.6),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        newChatButtonText,
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: white.withOpacity(0.6),
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                            ),
                            child: Container(
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.0005,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Expanded(
                      child: SizedBox(),
                    ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.001,
                color: white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () async {
                      await DatabaseHelper.instance.deleteDatabase();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: white.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Clear conversations',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: white.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Upgrade to Plus',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                        const Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.028,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: buttonAndUserChatColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.light_mode_outlined,
                          color: white.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Light mode',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.update,
                          color: white.withOpacity(0.6),
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Updates & FAQ',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent),
                        ),
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
