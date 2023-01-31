import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../config.dart';

class Auth with ChangeNotifier {
  String token = "";
  String userId = "";
  String errorMessage = "";
  late Timer authTimer;

  Future<void> Login(String email, String password) async {
    const url = Config.loginUrl;
    final response =
        await http.post(url, body: {'email': email, "password": password});
    final jsonResp = await json.decode(response.body);
    token = await jsonResp['token'];
    userId = await jsonResp["user"]["_id"];
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({"token": token, "userId": userId});
    prefs.setString("userData", userData);
  }

  Future<void> RegisterUser(
      String username, String email, String password, String profPic) async {
    const url = Config.registerUrl;
    final response = await http.post(url, body: {
      'username': username,
      'email': email,
      "password": password,
      'profPic': profPic,
    });
    final jsonResp = await json.decode(response.body);
    token = await jsonResp['token'];
    userId = await jsonResp["user"]["_id"];
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({"token": token, "userId": userId});
    prefs.setString("userData", userData);
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final extractedUserData = prefs.getString('userData');
    final details = await json.decode(extractedUserData);
    token = details['token'] as String;
    userId = details["userId"] as String;
    notifyListeners();
  }

  Future<void> uploadPic(String profPic,String uemail) async {
    var postUri = Uri.parse(Config.fileUploadUrl);
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['profPic'] = uemail;
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', profPic);

    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();

    notifyListeners();
  }

  bool get checkUser {
    autoLogin();
    if (token.isNotEmpty) {
      return true;
    }
    return false;
  }

  String get getUser {
    return userId;
  }

  Future<void> logout() async {
    token = "";
    userId = "";
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
