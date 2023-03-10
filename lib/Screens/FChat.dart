import 'package:chat_app/Screens/chat_sentences.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:chat_app/providers/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FChat extends StatefulWidget {
  const FChat({super.key});

  @override
  State<FChat> createState() => _FChatState();
}

class _FChatState extends State<FChat> {
  final messageController = TextEditingController();
  final _controller = ScrollController();
  bool sendmessage = false;

  //for storing currently sent message
  final List<Message> sendingMessage = [];

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(microseconds: 5),
      curve: Curves.fastOutSlowIn,
    );
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _scrollDown();
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      final convProvider = Provider.of<Conversations>(context, listen: false);
      final aP = Provider.of<Auth>(context, listen: false);
      convProvider.checkConversation(aP.userId, args["fid"] as String);
      if (convProvider.getConvoId.isNotEmpty) {
        Provider.of<Messages>(context, listen: false)
            .fetchMessages(convProvider.getConvoId);
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    final messProvider = Provider.of<Messages>(context);
    final authProvider = Provider.of<Auth>(context);
    final messList = messProvider.items;
    final argso =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Text(argso['fname'] as String),
      ),
      body: Column(
        children: [
          Expanded(
            child: sendmessage == false
                ? ListView.builder(
                    controller: _controller,
                    itemCount: messList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Chat_Sentences(
                        argso['fid'] as String,
                        argso['fname'] as String,
                        messList[index].text,
                        messList[index].date,
                        messList[index].senderId,
                      );
                    })
                : ListView.builder(
                    controller: _controller,
                    itemCount: sendingMessage.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Chat_Sentences(
                        argso['fid'] as String,
                        argso['fname'] as String,
                        sendingMessage[index].text,
                        sendingMessage[index].date,
                        sendingMessage[index].senderId,
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
                    controller: messageController,
                    decoration: InputDecoration.collapsed(
                        hintText: "Type a message ..."),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                    color: Colors.teal,
                    onPressed: () {
                      _scrollDown();
                      messProvider.sendChat(
                          argso['cid'] as String,
                          authProvider.userId,
                          messageController.text,
                          DateFormat('MM/dd/yyyy hh:mm a')
                              .format(DateTime.now()));
                      sendmessage = true;
                      sendingMessage.add(Message(
                          id: messageController.text +
                              DateTime.now().toIso8601String(),
                          senderId: authProvider.userId,
                          text: messageController.text,
                          date: DateFormat("hh:mm a").format(DateTime.now())));
                      messageController.clear();
                    },
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
