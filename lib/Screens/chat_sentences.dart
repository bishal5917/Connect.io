import 'package:flutter/material.dart';

class Chat_Sentences extends StatelessWidget {
  const Chat_Sentences({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://picsum.photos/id/237/200/300'),
                radius: 18,
              ),
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5)
                        ]),
                    child: Text("Hi When are we gonna meet ?")),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("12:30 PM",
                        style: TextStyle(fontSize: 10, color: Colors.black54)))
              ],
            ),
          ],
        ),
      ],
    );
  }
}
