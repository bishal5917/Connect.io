import 'package:chat_app/Widgets/open_friend_chat.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final authproviders = Provider.of<Auth>(context, listen: false);
      String loggedUserId = authproviders.userId;
      Provider.of<UserAdons>(context, listen: false)
          .getUserFriends(loggedUserId);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final userFrnds = Provider.of<UserAdons>(context).userFriends;
    final userProv = Provider.of<Auth>(context);
    // print(userFrnds);

    return userFrnds.length > 0
        ? ListView.builder(
            itemCount: userFrnds.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtPjb7Y2_dCpoMBp45tE8RcZTV3WLs5ItqW4hjEN3VnUkPlwveQV6kYw8_cuwT-wsBKB0&usqp=CAU"),
                  ),
                  title: Text(userFrnds[index].username),
                  trailing: OpenFriendChat(
                      userFrnds[index].username, userFrnds[index].id),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: Text("No Friends Yet"),
            ),
          );
  }
}
