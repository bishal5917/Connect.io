import 'package:chat_app/Screens/Chat.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  final user = true;
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        home: !user ? HomeScreen() : LoginScreen(),
        routes: {
          '/open_chat': (context) => Chat(),
        });
  }
}
