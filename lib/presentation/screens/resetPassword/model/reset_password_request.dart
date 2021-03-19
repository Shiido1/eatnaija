/// email : "paul4nan@gmail.com"

class ResetPasswordRequest {
  String _email;

  String get email => _email;

  ResetPasswordRequest({
      String email}){
    _email = email;
}

  ResetPasswordRequest.fromJson(dynamic json) {
    _email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    return map;
  }

}