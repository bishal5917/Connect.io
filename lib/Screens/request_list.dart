import 'package:chat_app/Widgets/request_accept.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final authproviders = Provider.of<Auth>(context, listen: false);
      String loggedUserId = authproviders.userId;
      Provider.of<UserAdons>(context, listen: false).getUserReqs(loggedUserId);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final userReqs = Provider.of<UserAdons>(context).userRequests;
    final loggedUser = Provider.of<Auth>(context).userId;
    // print(userFrnds);

    return userReqs.length > 0
        ? ListView.builder(
            itemCount: userReqs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtPjb7Y2_dCpoMBp45tE8RcZTV3WLs5ItqW4hjEN3VnUkPlwveQV6kYw8_cuwT-wsBKB0&usqp=CAU"),
                  ),
                  title: Text(userReqs[index].username),
                  trailing: RequestAccept(loggedUser, userReqs[index].id),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: Text("No Requests Received !"),
            ),
          );
  }
}
