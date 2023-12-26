import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_chatgpt_app/shared_colors.dart';
import 'package:http/http.dart' as http;

import 'api_key_constant.dart';
import 'chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
   TextEditingController _textController = TextEditingController();
   final _scrollController = ScrollController();
   final List<ChatMessage> _messages = [];
  late bool isLoading;
  @override
  void initState(){
    super.initState();
    isLoading =false;
  }



  Future<String>  generateResponse(String prompt) async{

   const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com","/v1/completions");
    final response = await http.post(url,
    headers: {
      'Content-Type':' application/json',
      'Authorization':'Bearer $apiKey'
    },
      body: jsonEncode(
        {
          'model':'gpt-3.5-turbo-0301',
          'prompt':prompt,
          'temperature':0,
          'max_token': 2000,
          'top_p':1,
          'frequency_penalty':0.0,
          'presence_penalty':0.0
        }
      )
    );

    //decode the response

    Map<String, dynamic> newresponse = jsonDecode(response.body);
    return newresponse['choices'][0]['text'];

  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color1,
        body: Column(
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.0005 ,
                  color: color2,
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
                                  color: color2,
                                ),
              ),
                            ),
            Row(
            children: [
              //input field
              _buildInput(),

              //submit button
              _buildSubmit(),
            ],
                            ),
          ],
        ),
      ),
    );
  }


  Expanded _buildInput(){
   return Expanded(
       child: TextField(
         textCapitalization: TextCapitalization.sentences,
         style: TextStyle(
           color: color2,
         ),
         controller: _textController,
         decoration: InputDecoration(
           fillColor: color4,
           filled: true,
           border: InputBorder.none,
           focusedBorder: InputBorder.none,
           enabledBorder: InputBorder.none,
           errorBorder: InputBorder.none,
           disabledBorder: InputBorder.none,
         ),
       ) ,
   );
  }

   Widget _buildSubmit (){

    return Visibility(
        child:  Container(
          color: color2,
          child: IconButton(
            onPressed: (){
          // display user input
              setState(() {
                _messages.add(
                    ChatMessage(
                        text: _textController.text,
                        chatMessageType: ChatMessageType.user,
                    ),);
                isLoading = true;
              });

              var input = _textController.text;
              _textController.clear();
              Future.delayed(Duration(
                milliseconds: 50,
              )).then((value) => _scrollDown());

              //call chatbot api

              generateResponse(input).then((value){
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
              } );

              _textController.clear();
              Future.delayed(

                Duration(
                  milliseconds: 50
                ),

              ).then((value) => _scrollDown());

            },
            icon: Icon(Icons.send,
            color: color3,
            ),
          ),
        ),
    );

   }

   void _scrollDown (){

    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration:Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut);

   }


   ListView _buildList(){
    return ListView.builder(
      itemCount: _messages.length,
        controller: _scrollController,
        itemBuilder: (context, index){
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );


        }
    );
   }


}





class ChatMessageWidget extends StatelessWidget{

  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget(
  {
    super.key,
    required this.text,
    required this.chatMessageType
}
      );


  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(16),
        color: chatMessageType == ChatMessageType.bot ?
        color2: color3,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  )
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: color2,
                  ),
                ),
              ),
            ],
          ),
      ),

      );
  }

}








