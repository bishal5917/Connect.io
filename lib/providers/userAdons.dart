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
  List<UserAdon> _reqs = [];

  List<UserAdon> get userFriends {
    return [..._friends];
  }

  List<UserAdon> get userRequests {
    return [..._reqs];
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

  Future<void> getUserReqs(String loggedUserId) async {
    String url = "${Config.getUserReqUrl}/$loggedUserId";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<UserAdon> loadedUserAdons = [];
    jsonResp.forEach((element) {
      loadedUserAdons.add(UserAdon(
          id: element['_id'],
          username: element['username'],
          avatar: element['avatar']));
    });
    _reqs = loadedUserAdons;
    notifyListeners();
  }

  Future<void> acceptReq(String userId, String reqId) async {
    String url = Config.acceptReqUrl;
    final response = await http.post(url, body: {
      "userId": userId,
      "reqId": reqId,
    });
    notifyListeners();
  }
}
