import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../utils.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(signUpEmailPwEndPoint);
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    print(json.decode(response.body));
  }
}
