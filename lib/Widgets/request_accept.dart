import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class RequestAccept extends StatefulWidget {
  const RequestAccept({super.key});

  @override
  State<RequestAccept> createState() => _RequestAcceptState();
}

class _RequestAcceptState extends State<RequestAccept> {
  bool accepted = false;
  @override
  Widget build(BuildContext context) {
    if (accepted == false) {
      return InkWell(
          onTap: () {
            accepted = true;
          },
          child: Icon(Icons.check_circle_outline_sharp));
    } else {
      return Container(child: Icon(Icons.check_circle));
    }
  }
}
