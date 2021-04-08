/// id : 62
/// name : "Nandom Kumchi"
/// email : "paul4nank@gmail.com"
/// email_verified_at : null
/// two_factor_secret : null
/// two_factor_recovery_codes : null
/// current_team_id : null
/// image : null
/// created_at : "2020-11-17T13:52:12.000000Z"
/// updated_at : "2020-11-17T13:52:12.000000Z"
/// phone : "07031676998"
/// address : "Opposite National Hospital Maitama"
/// otp : "4839"
/// city : "Abuja"
/// state : "Abuja"

class User {
  int _id;
  String _name;
  String _email;
  dynamic _emailVerifiedAt;
  dynamic _twoFactorSecret;
  dynamic _twoFactorRecoveryCodes;
  dynamic _currentTeamId;
  dynamic _image;
  String _createdAt;
  String _updatedAt;
  String _phone;
  String _address;
  String _otp;
  String _city;
  String _state;
  String _token;
  int _cart;
  List<Map<String,int>> cartItems=[];

  int get id => _id;
  String get name => _name;
  String get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get twoFactorSecret => _twoFactorSecret;
  dynamic get twoFactorRecoveryCodes => _twoFactorRecoveryCodes;
  dynamic get currentTeamId => _currentTeamId;
  dynamic get image => _image;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get phone => _phone;
  String get address => _address;
  String get otp => _otp;
  String get city => _city;
  String get state => _state;

  String get token => _token;
  int get cart => _cart;

  set token(String value) {
    _token = value;
  }

  set cart(int value) {
    _cart = value;
  }

  set id(int value) {
    _id = value;
  }
  User({
      int id, 
      String name, 
      String email, 
      dynamic emailVerifiedAt, 
      dynamic twoFactorSecret, 
      dynamic twoFactorRecoveryCodes, 
      dynamic currentTeamId, 
      dynamic image, 
      String createdAt, 
      String updatedAt, 
      String phone, 
      String address, 
      String otp, 
      String city, 
      String state, String token, int cart}){
    _id = id;
    _name = name;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _twoFactorSecret = twoFactorSecret;
    _twoFactorRecoveryCodes = twoFactorRecoveryCodes;
    _currentTeamId = currentTeamId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _phone = phone;
    _address = address;
    _otp = otp;
    _city = city;
    _state = state;
    _token = token;
    _cart = cart;
}

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _emailVerifiedAt = json["email_verified_at"];
    _twoFactorSecret = json["two_factor_secret"];
    _twoFactorRecoveryCodes = json["two_factor_recovery_codes"];
    _currentTeamId = json["current_team_id"];
    _image = json["image"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _phone = json["phone"];
    _address = json["address"];
    _otp = json["otp"];
    _city = json["city"];
    _state = json["state"];
    _cart = json["cart"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["email_verified_at"] = _emailVerifiedAt;
    map["two_factor_secret"] = _twoFactorSecret;
    map["two_factor_recovery_codes"] = _twoFactorRecoveryCodes;
    map["current_team_id"] = _currentTeamId;
    map["image"] = _image;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["phone"] = _phone;
    map["address"] = _address;
    map["otp"] = _otp;
    map["city"] = _city;
    map["state"] = _state;
    map["token"] = _token;
    map["cart"] = _cart;
    return map;
  }

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set emailVerifiedAt(dynamic value) {
    _emailVerifiedAt = value;
  }

  set twoFactorSecret(dynamic value) {
    _twoFactorSecret = value;
  }

  set twoFactorRecoveryCodes(dynamic value) {
    _twoFactorRecoveryCodes = value;
  }

  set currentTeamId(dynamic value) {
    _currentTeamId = value;
  }

  set image(dynamic value) {
    _image = value;
  }

  set createdAt(String value) {
    _createdAt = value;
  }

  set updatedAt(String value) {
    _updatedAt = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set address(String value) {
    _address = value;
  }

  set otp(String value) {
    _otp = value;
  }

  set city(String value) {
    _city = value;
  }

  set state(String value) {
    _state = value;
  }
}