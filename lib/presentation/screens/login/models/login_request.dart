/// email : "paul4nank@gmail.com"
/// password : "1234"

class LoginRequest {
  String _email;
  String _password;

  String get email => _email;
  String get password => _password;

  LoginRequest({
      String email, 
      String password}){
    _email = email;
    _password = password;
}

  LoginRequest.fromJson(dynamic json) {
    _email = json["email"];
    _password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }

}