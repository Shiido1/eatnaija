/// email : "paul4nank@gmail.com"
/// phone : "07031676998"
/// state : "Abuja"
/// city : "Abuja"
/// address : "Opposite National Hospital Maitama"
/// image : "lksjdkfsdf"
/// name : "Nandom Kumchi"
/// password : "1234"

class RegisterRequest {
  String _email;
  String _phone;
  String _state;
  String _city;
  String _address;
  String _image;
  String _name;
  String _password;

  String get email => _email;
  String get phone => _phone;
  String get state => _state;
  String get city => _city;
  String get address => _address;
  String get image => _image;
  String get name => _name;
  String get password => _password;

  RegisterRequest({
      String email, 
      String phone, 
      String state, 
      String city, 
      String address, 
      String image, 
      String name, 
      String password}){
    _email = email;
    _phone = phone;
    _state = state;
    _city = city;
    _address = address;
    _image = image;
    _name = name;
    _password = password;
}

  RegisterRequest.fromJson(dynamic json) {
    _email = json["email"];
    _phone = json["phone"];
    _state = json["state"];
    _city = json["city"];
    _address = json["address"];
    _image = json["image"];
    _name = json["name"];
    _password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["phone"] = _phone;
    map["state"] = _state;
    map["city"] = _city;
    map["address"] = _address;
    map["image"] = _image;
    map["name"] = _name;
    map["password"] = _password;
    return map;
  }

}