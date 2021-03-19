/// image : "lksjdklfskdj"
/// city : "lksjdklfskdj"
/// state : "lksjdklfskdj"
/// address : "lksjdklfskdj"
/// phone : "lksjdklfskdj"

class UpdateProfileRequest {
  String _image;
  String _city;
  String _state;
  String _address;
  String _phone;

  String get image => _image;
  String get city => _city;
  String get state => _state;
  String get address => _address;
  String get phone => _phone;

  UpdateProfileRequest({
      String image, 
      String city, 
      String state, 
      String address, 
      String phone}){
    _image = image;
    _city = city;
    _state = state;
    _address = address;
    _phone = phone;
}

  UpdateProfileRequest.fromJson(dynamic json) {
    _image = json["image"];
    _city = json["city"];
    _state = json["state"];
    _address = json["address"];
    _phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    map["city"] = _city;
    map["state"] = _state;
    map["address"] = _address;
    map["phone"] = _phone;
    return map;
  }

}