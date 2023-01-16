import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.blueAccent
              ),
              shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/237/200/300'),
              radius: 30,
            ),
          ),
        ],
      ),
    );
  }
}
