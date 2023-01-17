import 'package:chat_app/Screens/chat_sentences.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mike Alpha"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Chat_Sentences(),
                Chat_Sentences(),
                Chat_Sentences(),
                Chat_Sentences(),
                Chat_Sentences()
              ],
            ),
          ),
          Container(
            child: Text("Type a Message !!! "),
          )
        ],
      ),
    );
  }
}
