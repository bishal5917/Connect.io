import 'package:chat_app/Screens/chat_sentences.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:chat_app/providers/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  final _controller = ScrollController();
  bool sendmessage = false;
  late IO.Socket socket;

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
    connectSocket();
    Future.delayed(Duration.zero).then((value) {
      _scrollDown();
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      if (args["cid"] != "NaN") {
        Provider.of<Messages>(context, listen: false)
            .fetchMessages(args["cid"] as String);
      }
    });

    super.initState();
  }

  void connectSocket() {
    socket = IO.io("http://192.168.1.64:3050", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": "false"
    });
    socket.connect();
    socket.onConnect((data) => print("Connected To Flutter"));
    socket.emit("/test")
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
