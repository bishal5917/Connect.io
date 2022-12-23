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
        appBar: AppBar(
          title: const Text('ChatApp'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                color: Color.fromARGB(255, 178, 182, 182),
                child: Container(
                  // child: Text("Chart"),
                  width: 100,
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
