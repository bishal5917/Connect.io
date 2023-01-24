import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'dart:io';

class Message with ChangeNotifier {
  final String id;
  final String senderId;
  final String text;
  final String date;

  Message(
      {required this.id,
      required this.senderId,
      required this.text,
      required this.date});
}

class Messages with ChangeNotifier {
  List<Message> _items = [];

  List<Message> get items {
    return [..._items];
  }

  Future<void> fetchMessages(String convId) async {
    String url = "${Config.getMessages}/$convId";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<Message> loadedMessages = [];
    jsonResp.forEach((element) {
      loadedMessages.add(Message(
          id: element['_id'],
          senderId: element['senderId'],
          text: element['text'],
          date: element['createdAt']));
    });
    _items = loadedMessages;
    notifyListeners();
  }

  Future<void> sendChat(String conversationId, String senderId, String text,
      String createdAt) async {
    String url = Config.sendMessUrl;
    final response = await http.post(url, body: {
      "conversationId": conversationId,
      "senderId": senderId,
      "text": text,
      "createdAt": createdAt
    });
    notifyListeners();
  }
}
