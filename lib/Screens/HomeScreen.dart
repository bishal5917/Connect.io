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
    final authP = Provider.of<Auth>(context);
    final convList = convProvider.items;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CONNECT.IO",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
            IconButton(
                onPressed: (() {
                  authP.logout();
                }),
                icon: Icon(Icons.logout))
          ],
        ),
        body: ListView.builder(
            itemCount: convList.length,
            itemBuilder: (BuildContext context, int index) {
              return Message(convList[index].id, convList[index].friendname,
                  convList[index].id, convList[index].fr_avatar);
            }));
  }
}
