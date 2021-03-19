import 'package:eatnaija/presentation/screens/login/models/user.dart';

/// message : "Verification Successful"
/// user : {"id":54,"name":"Ugochukwu","email":"ugo@gmail.com","email_verified_at":null,"two_factor_secret":null,"two_factor_recovery_codes":null,"current_team_id":null,"image":null,"created_at":"2020-10-30T17:54:11.000000Z","updated_at":"2020-10-30T17:54:11.000000Z","phone":"08163984463","address":"area 1","otp":"3510","city":"abuja","state":"fct"}
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF0bmFpamEuY29tXC9hcGlcL290cCIsImlhdCI6MTYwNjczODA2NiwibmJmIjoxNjA2NzM4MDY2LCJqdGkiOiJtdVYzZ0FsOXZhRWVGNXVCIiwic3ViIjo1NCwicHJ2IjoiODg3Mzk5MDVjZGVlOTI2NmE2ZjExMDRkYjYxYTk0NGFhN2EyMTJmYSJ9.7lWA5EnXREE1mBLb9kt4OHhaY7okJHWzWHpSvUX1aKw"

class OtpVerifyResponse {
  String _message;
  User _user;
  String _token;

  String get message => _message;

  User get user => _user;

  String get token => _token;

  OtpVerifyResponse({String message, User user, String token}) {
    _message = message;
    _user = user;
    _token = token;
  }

  OtpVerifyResponse.fromJson(dynamic json) {
    _message = json["message"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    map["token"] = _token;
    return map;
  }
}
