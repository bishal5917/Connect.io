import 'dart:ui';
import 'package:chat_app/Screens/convos_list.dart';
import 'package:chat_app/Screens/friend_list.dart';
import 'package:chat_app/Screens/request_list.dart';
import 'package:chat_app/Widgets/search_widget.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  Widget build(BuildContext context) {
    final authP = Provider.of<Auth>(context);

    return Scaffold(
        appBar: AppBar(
          title: SearchWidget(),
          actions: <Widget>[
            IconButton(
                onPressed: (() {
                  authP.logout();
                }),
                icon: Icon(Icons.logout))
          ],
          bottom: TabBar(controller: _controller, tabs: [
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Friends",
            ),
            Tab(
              text: "Requests",
            ),
          ]),
        ),
        body: TabBarView(
          controller: _controller,
          children: [ConvosList(), FriendList(), RequestList()],
        ));
  }
}
