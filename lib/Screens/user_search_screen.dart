import 'package:chat_app/providers/userAdons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<UserAdons>(context).sItems;

    return Scaffold(
        appBar: AppBar(
          title: Text("Search Result : ${searchData.length} persons found"),
        ),
        body: ListView.builder(
          itemCount: searchData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtPjb7Y2_dCpoMBp45tE8RcZTV3WLs5ItqW4hjEN3VnUkPlwveQV6kYw8_cuwT-wsBKB0&usqp=CAU"),
                ),
                title: Text(searchData[index].username),
                trailing: Text("ok"),
              ),
            );
          },
        ));
  }
}
