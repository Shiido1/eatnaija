/// otp : 4839
/// userid : 62
/// message : "Registration Successful"

class RegisterResponse {
  int _otp;
  int _userid;
  String _message;

  int get otp => _otp;
  int get userid => _userid;
  String get message => _message;

  RegisterResponse({
      int otp, 
      int userid, 
      String message}){
    _otp = otp;
    _userid = userid;
    _message = message;
}

  RegisterResponse.fromJson(dynamic json) {
    _otp = json["otp"];
    _userid = json["userid"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["otp"] = _otp;
    map["userid"] = _userid;
    map["message"] = _message;
    return map;
  }

}