import 'package:chat_app/Screens/chat_sentences.dart';
import 'package:chat_app/providers/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      Provider.of<Messages>(context, listen: false)
          .fetchMessages(args["cid"] as String);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final messProvider = Provider.of<Messages>(context);
    final messList = messProvider.items;
    final argso =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mike Alpha"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Chat_Sentences(
                    messList[index].text,
                    messList[index].date,
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                    color: Colors.teal,
                    onPressed: () {},
                    iconSize: 25,
                    icon: Icon(Icons.photo)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: "Type a message ..."),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                    color: Colors.teal,
                    onPressed: () {},
                    iconSize: 25,
                    icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
