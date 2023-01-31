import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendRequest extends StatefulWidget {
  final String userId;
  final String reqId;

  SendRequest(this.userId, this.reqId);

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    final userAdonProv = Provider.of<UserAdons>(context);

    if (sent == false) {
      return InkWell(
          onTap: () {
            userAdonProv.sendFrndReq(widget.userId, widget.reqId);
            sent = true;
          },
          child: Icon(Icons.add_circle_outline));
    } else {
      return Container(child: Icon(Icons.add_circle));
    }
  }
}
