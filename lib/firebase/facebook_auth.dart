import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

final fbLogin = FacebookLogin();

Future signInFB() async {
  final FacebookLoginResult result = await fbLogin.logIn(["email"]);
  final String token = result.accessToken.token;
  final response = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,picture.width(400).height(400),first_name,last_name,email&access_token=${token}');
  final profile = jsonDecode(response.body);
  print(profile);
  return profile;
}
