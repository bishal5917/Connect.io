import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'dart:io';

class UserAdon with ChangeNotifier {
  final String id;
  final String username;
  final Map<String, dynamic> avatar;

  UserAdon({required this.id, required this.username, required this.avatar});
}

class UserAdons with ChangeNotifier {
  List<UserAdon> _friends = [];

  List<UserAdon> get userFriends {
    return [..._friends];
  }

  Future<void> getUserFriends(String loggedUserId) async {
    String url = "${Config.getUserFrndUrl}/$loggedUserId";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<UserAdon> loadedUserAdons = [];
    jsonResp.forEach((element) {
      loadedUserAdons.add(UserAdon(
          id: element['_id'],
          username: element['username'],
          avatar: element['avatar']));
    });
    _friends = loadedUserAdons;
    notifyListeners();
  }
}
