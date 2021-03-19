/// status : "false"
/// message : "Your current password does not match with the password you provided. Please try again."

class ChangePasswordResponse {
  String _status;
  String _message;

  String get status => _status;
  String get message => _message;

  ChangePasswordResponse({
      String status, 
      String message}){
    _status = status;
    _message = message;
}

  ChangePasswordResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    return map;
  }

}