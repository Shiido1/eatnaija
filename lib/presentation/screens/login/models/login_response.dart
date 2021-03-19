import 'user.dart';

/// message : "Login Successful"
/// user : {"id":62,"name":"Nandom Kumchi","email":"paul4nank@gmail.com","email_verified_at":null,"two_factor_secret":null,"two_factor_recovery_codes":null,"current_team_id":null,"image":null,"created_at":"2020-11-17T13:52:12.000000Z","updated_at":"2020-11-17T13:52:12.000000Z","phone":"07031676998","address":"Opposite National Hospital Maitama","otp":"4839","city":"Abuja","state":"Abuja"}
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF0bmFpamEuY29tXC9hcGlcL2xvZ2luXC91c2VyIiwiaWF0IjoxNjA1NjIzNTU2LCJuYmYiOjE2MDU2MjM1NTYsImp0aSI6IjFVSUdUUG5iMGl1U3MzVEYiLCJzdWIiOjYyLCJwcnYiOiI4ODczOTkwNWNkZWU5MjY2YTZmMTEwNGRiNjFhOTQ0YWE3YTIxMmZhIn0.B7mZVqYZV40M1shoNE1GmYK9XR6lsNcFYGJY1rz_4y0"

class LoginResponse {
  String _message;
  User _user;
  String _token;
  int _cart;

  String get message => _message;
  User get user => _user;
  String get token => _token;

  int get cart => _cart;

  set cart(int value) {
    _cart = value;
  }

  LoginResponse({
      String message, 
      User user, 
      String token, int cart}){
    _message = message;
    _user = user;
    _token = token;
    _cart = cart;
}

  LoginResponse.fromJson(dynamic json) {
    _message = json["message"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _token = json["token"];
    _cart = json["cart"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    map["token"] = _token;
    map["cart"] = _cart;
    return map;
  }

}