import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestAccept extends StatefulWidget {
  final String userId;
  final String reqId;

  RequestAccept(this.userId, this.reqId);

  @override
  State<RequestAccept> createState() => _RequestAcceptState();
}

class _RequestAcceptState extends State<RequestAccept> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final userAdonProv = Provider.of<UserAdons>(context);

    if (accepted == false) {
      return InkWell(
          onTap: () {
            userAdonProv.acceptReq(widget.userId, widget.reqId);
            accepted = true;
          },
          child: Icon(Icons.check_circle_outline_sharp));
    } else {
      return Container(child: Icon(Icons.check_circle));
    }
  }
}
