import 'package:flutter/material.dart';
import 'package:task_chatgpt_app/shared/colors/shared_colors.dart';

import '../../shared/models/chat_model.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;

  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.chatMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessageType == ChatMessageType.bot ? Padding(
      padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8.0,
          right: 60.0
      ),
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 10),
        padding:const  EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:white.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:const EdgeInsets.all(8),
              decoration:const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: white,
                ),

              ),
            ),
          ],
        ),
      ),
    ) : Padding(
      padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 100.0,
          right: 8
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding:const  EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: buttonAndUserChatColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:const EdgeInsets.all(8),
              decoration:const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: white,
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}