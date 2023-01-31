import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/Screens/Message.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ConvosList extends StatefulWidget {
  const ConvosList({super.key});

  @override
  State<ConvosList> createState() => _ConvosListState();
}

class _ConvosListState extends State<ConvosList> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final authproviders = Provider.of<Auth>(context, listen: false);
      String loggedUserId = authproviders.userId;
      Provider.of<Conversations>(context, listen: false)
          .getConvos(loggedUserId);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final convProvider = Provider.of<Conversations>(context);
    final convList = convProvider.items;
    return convList.length > 0
        ? ListView.builder(
            itemCount: convList.length,
            itemBuilder: (BuildContext context, int index) {
              return Message(convList[index].id, convList[index].friendname,
                  convList[index].id, convList[index].profPic);
            })
        : Container(
            child: Center(
              child: Text("No Conversations Yet !"),
            ),
          );
  }
}
