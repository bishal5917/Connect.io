import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';

class OpenFriendChat extends StatefulWidget {
  final String frndName;
  final String frndId;

  OpenFriendChat(this.frndName, this.frndId);

  @override
  State<OpenFriendChat> createState() => _OpenFriendChatState();
}

class _OpenFriendChatState extends State<OpenFriendChat> {
  @override
  Widget build(BuildContext context) {
    final userAdonProv = Provider.of<UserAdons>(context);
    final authProv = Provider.of<Auth>(context);
    final convoProv = Provider.of<Conversations>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/open_fchat', arguments: {
          "cid": "NaN",
          "fname": widget.frndName,
          "fid": widget.frndId
        });
        // convoProv.createChat(authProv.userId, widget.frndId);
        // Navigator.pushNamed(context, "/");
      },
      child: Icon(Icons.message_outlined),
    );
  }
}
