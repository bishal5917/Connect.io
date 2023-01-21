import 'package:flutter/material.dart';

class Chat_Sentences extends StatelessWidget {
  final String fid;
  final String fname;
  final String text;
  final String date;

  Chat_Sentences(this.text, this.date);

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
                    child: Text(text)),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(date,
                        style: TextStyle(fontSize: 10, color: Colors.black54)))
              ],
            ),
          ],
        ),
      ],
    );
  }
}
