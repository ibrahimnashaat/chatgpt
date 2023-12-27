import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/shared/colors/shared_colors.dart';
import '../shared/api/api_key_constant.dart';
import 'shared_elements_between_chats/chat_message.dart';
import '../shared/models/chat_model.dart';
import '../shared/database/database.dart';
import '../layout/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeneratedChat extends StatefulWidget {
  final List<Map<String, dynamic>> databaseMessages;

  const GeneratedChat({super.key, required this.databaseMessages});

  @override
  State<GeneratedChat> createState() => _GeneratedChatState();
}

class _GeneratedChatState extends State<GeneratedChat> {
  final TextEditingController _textController = TextEditingController();

  final _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];
  List<ChatMessage> _databaseMessages = [];

  late bool isLoading;

  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    isLoading = false;

    _databaseHelper = DatabaseHelper.instance;

    _loadMessagesFromDatabase();
  }

  void _loadMessagesFromDatabase() {
    setState(() {
      _databaseMessages = widget.databaseMessages.map((message) {
        return ChatMessage(
          text: message['text'],
          chatMessageType: message['messageType'] == 'user'
              ? ChatMessageType.user
              : ChatMessageType.bot,
        );
      }).toList();
    });
  }

  Future<void> saveMessage(String text, ChatMessageType messageType) async {
    String type = messageType == ChatMessageType.user ? 'user' : 'bot';
    await _databaseHelper.insertMessage(text, type);
    _loadMessagesFromDatabase();
  }

  Future<String> generateResponse(String prompt) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        'model': 'text-ada-001',
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0
      }),
    );

    // decode the response
    Map<String, dynamic> newResponse = jsonDecode(response.body);

    return newResponse['choices'][0]['text'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: white),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/images/chat_gpt_icon.png',
                            width: 5.w,
                            height: 5.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.0005,
                  color: white,
                ),
              ],
            ),
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: white,
                ),
              ),
            ),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: white,
        ),
        controller: _textController,
        decoration: InputDecoration(
          fillColor: white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          suffixIcon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonAndUserChatColor,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () async {
                  // display user input
                  setState(() {
                    _messages.add(
                      ChatMessage(
                        text: _textController.text,
                        chatMessageType: ChatMessageType.user,
                      ),
                    );
                    isLoading = true;
                  });

                  var input = _textController.text;
                  _textController.clear();

                  Future.delayed(const Duration(
                    milliseconds: 50,
                  )).then((value) => _scrollDown());

                  //save the input text and the type of the users input this data into the data base
                  await saveMessage(input, ChatMessageType.user);

                  //call chatbot api

                  generateResponse(input).then((value) async {
                    // display chatbot response
                    setState(() {
                      isLoading = false;
                      _messages.add(
                        ChatMessage(
                          text: value,
                          chatMessageType: ChatMessageType.bot,
                        ),
                      );
                    });
                    // Save the chat bot response to the database
                    await saveMessage(value, ChatMessageType.bot);
                  });

                  _textController.clear();
                  Future.delayed(
                    const Duration(milliseconds: 50),
                  ).then((value) => _scrollDown());
                },
                icon: Image.asset(
                  'assets/images/send_icon.png',
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        itemCount: _databaseMessages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var message = _databaseMessages[index];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        });
  }
}
