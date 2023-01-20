import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'dart:io';

class Conversation with ChangeNotifier {
  final String id;
  final String nextId;
  final List<dynamic> members;

  Conversation({required this.id, required this.nextId, required this.members});
}

class Conversations with ChangeNotifier {
  List<Conversation> _items = [];

  List<Conversation> get items {
    return [..._items];
  }

  Future<void> getConvos(String loggedUserId) async {
    String url = "${Config.getConvoUrl}/$loggedUserId";
    final response = await http.get(url);
    final jsonResp = await json.decode(response.body);
    final List<Conversation> loadedConversations = [];
    jsonResp.forEach((element) {
      loadedConversations.add(Conversation(
          id: element['_id'],
          nextId: element['nextId'],
          members: element['members']));
    });
    _items = loadedConversations;
    notifyListeners();
  }

  // Conversation findProdById(String id) {
  //   return items.firstWhere((item) => item.id == id);
  // }

  // Future<void> addReview(num rating, String comment, String prodId) async {
  //   String url = Config.addReviewUrl;
  //   final response = await http.post(url,
  //       body: json.encode(
  //           {"rating": rating, "comment": comment, "ConversationId": prodId}));
  //   notifyListeners();
  // }
}
