import 'package:chat_app/Screens/Message.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {},
          ),
          title: Text(
            "CHATS",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(onPressed: (() {}), icon: Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [Message(), Message(), Message()],
        ));
  }
}
