import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'dart:io';

class UserAdon with ChangeNotifier {
  final String id;
  final String username;
  final String profPic;
  final String email;
  final List<dynamic> friends;

  UserAdon(
      {required this.id,
      required this.username,
      required this.profPic,
      required this.email,
      required this.friends});
}

class UserAdons with ChangeNotifier {
  String isUnameAvailable = "";
  int usernamestatusCde = 0;
  List<UserAdon> _friends = [];
  List<UserAdon> _reqs = [];
  List<UserAdon> _sitem = [];

  List<UserAdon> get userFriends {
    return [..._friends];
  }

  List<UserAdon> get userRequests {
    return [..._reqs];
  }

  List<UserAdon> get sItems {
    return [..._sitem];
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
          profPic: element['profPic'],
          email: element['email'],
          friends: element['friends']));
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
          profPic: element['profPic'],
          email: element['email'],
          friends: element['friends']));
    });
    _reqs = loadedUserAdons;
    notifyListeners();
  }

  Future<void> searchUsers(String searchKey) async {
    String url = "${Config.searchUserUrl}?uname=$searchKey";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<UserAdon> loadedUserAdons = [];
    jsonResp.forEach((element) {
      loadedUserAdons.add(UserAdon(
          id: element['_id'],
          username: element['username'],
          profPic: element['profPic'],
          email: element['email'],
          friends: element['friends']));
    });
    _sitem = loadedUserAdons;
    notifyListeners();
  }

  Future<void> acceptReq(String userId, String reqId) async {
    String url = Config.acceptReqUrl;
    final response = await http.put(url, body: {
      "userId": userId,
      "reqId": reqId,
    });
    notifyListeners();
  }

  Future<void> sendFrndReq(String userId, String sendId) async {
    String url = Config.sendReqUrl;
    final response = await http.put(url, body: {
      "userId": userId,
      "sendId": sendId,
    });
    notifyListeners();
  }

  Future<void> checkUsernameAvailability(String uvalue) async {
    String url = "${Config.checkUsernameAvail}/$uvalue";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      usernamestatusCde = 200;
      isUnameAvailable = "";
    } else if (response.statusCode == 403) {
      isUnameAvailable = "Username is already taken !";
      usernamestatusCde = 403;
    }
    notifyListeners();
  }
}
