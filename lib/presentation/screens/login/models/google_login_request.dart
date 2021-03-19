/// email : "paul4nank@gmail.com"
/// name : "paul4nank@gmail.com"
/// image : "paul4nank@gmail.com"

class GoogleLoginRequest {
  String _email;
  String _name;
  String _image;

  String get email => _email;
  String get name => _name;
  String get image => _image;

  GoogleLoginRequest({
      String email, 
      String name, 
      String image}){
    _email = email;
    _name = name;
    _image = image;
}

  GoogleLoginRequest.fromJson(dynamic json) {
    _email = json["email"];
    _name = json["name"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["name"] = _name;
    map["image"] = _image;
    return map;
  }

}