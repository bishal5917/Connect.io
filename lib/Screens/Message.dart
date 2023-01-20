import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Message extends StatefulWidget {
  final String userId;
  final String pic;

  Message(this.userId, this.pic);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<Conversations>(context, listen: false)
          .getUserInfo(widget.userId);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final friendName = Provider.of<Conversations>(context).username;
    final imgUrl = Provider.of<Conversations>(context).imageUrl;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/open_chat');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.blueAccent),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ]),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.pic),
                radius: 36,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(friendName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(fontSize: 10, color: Colors.black54))
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tap to open chat ...",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
