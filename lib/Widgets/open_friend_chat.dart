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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/open_chat', arguments: {
          "cid": "asiajisajs",
          "fname": widget.frndName,
          "fid": widget.frndId
        });
      },
      child: Icon(Icons.message_outlined),
    );
  }
}
