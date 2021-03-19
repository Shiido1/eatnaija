import 'package:eatnaija/presentation/screens/login/models/user.dart';

/// status : "true"
/// message : "Profile Updated"
/// user : {"id":18,"name":"Eze ThankGod","email":"thankgodeze98@gmail.com","email_verified_at":"1","current_team_id":null,"image":null,"created_at":"2020-10-05T10:49:45.000000Z","updated_at":"2020-11-25T13:16:35.000000Z","phone":null,"address":null,"otp":"5368","city":null,"state":null,"profile_photo_url":"https://ui-avatars.com/api/?name=Eze+ThankGod&color=7F9CF5&background=EBF4FF"}

class UpdateUserResponse {
  String _status;
  String _message;
  User _user;

  String get status => _status;
  String get message => _message;
  User get user => _user;

  UpdateUserResponse({
      String status, 
      String message, 
      User user}){
    _status = status;
    _message = message;
    _user = user;
}

  UpdateUserResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }

}
