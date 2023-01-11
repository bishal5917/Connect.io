import 'package:chat_app/Screens/Message.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                color: Color.fromARGB(255, 252, 252, 252),
                child: Container(child: Message()
                    ),
                elevation: 5,
              ),
              Card(
                color: Color.fromARGB(255, 252, 252, 252),
                child: Container(child: Message()
                    ),
                elevation: 5,
              ),
                         Card(
                color: Color.fromARGB(255, 252, 252, 252),
                child: Container(child: Message()
                    ),
                elevation: 5,
              ),
                         Card(
                color: Color.fromARGB(255, 252, 252, 252),
                child: Container(child: Message()
                    ),
                elevation: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
