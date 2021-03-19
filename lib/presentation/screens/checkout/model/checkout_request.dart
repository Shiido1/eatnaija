/// city : "lkjslkdjfls"
/// state : "lkjslkdjfls"
/// address : "lkjslkdjfls"
/// phone : "lkjslkdjfls"
/// total : "lkjslkdjfls"

class CheckoutRequest {
  String _city;
  String _state;
  String _address;
  String _phone;
  String _total;

  String get city => _city;
  String get state => _state;
  String get address => _address;
  String get phone => _phone;
  String get total => _total;

  CheckoutRequest({
      String city, 
      String state, 
      String address, 
      String phone, 
      String total}){
    _city = city;
    _state = state;
    _address = address;
    _phone = phone;
    _total = total;
}

  CheckoutRequest.fromJson(dynamic json) {
    _city = json["city"];
    _state = json["state"];
    _address = json["address"];
    _phone = json["phone"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["city"] = _city;
    map["state"] = _state;
    map["address"] = _address;
    map["phone"] = _phone;
    map["total"] = _total;
    return map;
  }

}