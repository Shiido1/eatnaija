/// currentPassword : "lskjdlf"
/// newPassword : "lsdkjflksjdf"

class ChangePasswordRequest {
  String _currentPassword;
  String _newPassword;

  String get currentPassword => _currentPassword;
  String get newPassword => _newPassword;

  ChangePasswordRequest({
      String currentPassword, 
      String newPassword}){
    _currentPassword = currentPassword;
    _newPassword = newPassword;
}

  ChangePasswordRequest.fromJson(dynamic json) {
    _currentPassword = json["currentPassword"];
    _newPassword = json["newPassword"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currentPassword"] = _currentPassword;
    map["newPassword"] = _newPassword;
    return map;
  }

}