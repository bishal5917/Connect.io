import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'dart:io';

class Conversation with ChangeNotifier {
  final String id;
  final String friendname;
  final List<dynamic> members;
  final Map<String, dynamic> fr_avatar;

  Conversation(
      {required this.id,
      required this.friendname,
      required this.members,
      required this.fr_avatar});
}

class Conversations with ChangeNotifier {
  List<Conversation> _items = [];
  String convoId = "";
  String targetId = "";

  List<Conversation> get items {
    return [..._items];
  }

  String get getConvoId {
    return convoId;
  }

  Future<void> getConvos(String loggedUserId) async {
    String url = "${Config.getConvoUrl}/$loggedUserId";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<Conversation> loadedConversations = [];
    jsonResp.forEach((element) {
      loadedConversations.add(Conversation(
          id: element['_id'],
          friendname: element['friendname'],
          members: element['members'],
          fr_avatar: element['fr_avatar']));
    });
    _items = loadedConversations;
    notifyListeners();
  }

  Future<void> checkConversation(String uid, String fid) async {
    String url = "${Config.getCheckConvoUrl}/$uid/$fid";
    final response = await http.get(url);
    if (response.statusCode == 404) {
      return;
    }
    final jsonResp = await json.decode(response.body);
    convoId = jsonResp['_id'];
    notifyListeners();
  }

  Future<void> createChat(String uid, String fid) async {
    String url = Config.createChatUrl;
    final response = await http.post(url, body: {
      "senderId": uid,
      "receiverId": fid,
    });
    notifyListeners();
  }

  Future<void> getTarget(String cid, String uid) async {
    String url = "${Config.getTargetUrl}/$cid/$uid";
    final response = await http.get(url);
    targetId = response.body;
    notifyListeners();
  }
}
