import 'package:chat_app/Screens/Message.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final authproviders = Provider.of<Auth>(context, listen: false);
      String loggedUserId = authproviders.userId;
      Provider.of<Conversations>(context, listen: false)
          .getConvos(loggedUserId);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final convProvider = Provider.of<Conversations>(context);
    final convList = convProvider.items;

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
        body: ListView.builder(
            itemCount: convList.length,
            itemBuilder: (BuildContext context, int index) {
              return Message(
                  convList[index].nextId, "https://picsum.photos/id/237/200/300");
            }));
  }
}
