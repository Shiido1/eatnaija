/// Requests : [{"id":4,"name":"Joel Nelson","phone":"07032205576","address1":"Gwarimpa Housing Estate Abuja","address2":null,"city":"f.c.t","state":"Abuja","user_id":"4","price":"3000","product":"jollof rice","payment_status":"1","vendor_id":"2","cart_id":"2","product_id":"1","quantity":"1","image":"170410115312-african-food---jollof-rice-full-169_1601589752.jpg","accept":"0","reject":"1","delivered":"0","created_at":"2020-10-04T17:42:07.000000Z","updated_at":"2020-11-05T10:13:25.000000Z"},{"id":3,"name":"Eze ThankGod","phone":"08163984463","address1":"plot707 durumi 2 abuja","address2":null,"city":"abuja","state":"FCT","user_id":"3","price":"3000","product":"jollof rice","payment_status":"1","vendor_id":"2","cart_id":"1","product_id":"1","quantity":"1","image":"170410115312-african-food---jollof-rice-full-169_1601589752.jpg","accept":"1","reject":"0","delivered":"1","created_at":"2020-10-04T12:01:14.000000Z","updated_at":"2020-11-05T11:30:26.000000Z"}]

class FoodOrderResponse {
  List<Requests> _requests;

  List<Requests> get requests => _requests;

  FoodOrderResponse({
      List<Requests> requests}){
    _requests = requests;
}

  FoodOrderResponse.fromJson(dynamic json) {
    if (json["Requests"] != null) {
      _requests = [];
      json["Requests"].forEach((v) {
        _requests.add(Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_requests != null) {
      map["Requests"] = _requests.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// name : "Joel Nelson"
/// phone : "07032205576"
/// address1 : "Gwarimpa Housing Estate Abuja"
/// address2 : null
/// city : "f.c.t"
/// state : "Abuja"
/// user_id : "4"
/// price : "3000"
/// product : "jollof rice"
/// payment_status : "1"
/// vendor_id : "2"
/// cart_id : "2"
/// product_id : "1"
/// quantity : "1"
/// image : "170410115312-african-food---jollof-rice-full-169_1601589752.jpg"
/// accept : "0"
/// reject : "1"
/// delivered : "0"
/// created_at : "2020-10-04T17:42:07.000000Z"
/// updated_at : "2020-11-05T10:13:25.000000Z"

class Requests {
  int _id;
  String _name;
  String _phone;
  String _address1;
  dynamic _address2;
  String _city;
  String _state;
  String _userId;
  String _price;
  String _product;
  String _paymentStatus;
  String _vendorId;
  String _cartId;
  String _productId;
  String _quantity;
  String _image;
  String _accept;
  String _reject;
  String _delivered;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get address1 => _address1;
  dynamic get address2 => _address2;
  String get city => _city;
  String get state => _state;
  String get userId => _userId;
  String get price => _price;
  String get product => _product;
  String get paymentStatus => _paymentStatus;
  String get vendorId => _vendorId;
  String get cartId => _cartId;
  String get productId => _productId;
  String get quantity => _quantity;
  String get image => _image;
  String get accept => _accept;
  String get reject => _reject;
  String get delivered => _delivered;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Requests({
      int id, 
      String name, 
      String phone, 
      String address1, 
      dynamic address2, 
      String city, 
      String state, 
      String userId, 
      String price, 
      String product, 
      String paymentStatus, 
      String vendorId, 
      String cartId, 
      String productId, 
      String quantity, 
      String image, 
      String accept, 
      String reject, 
      String delivered, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _phone = phone;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _userId = userId;
    _price = price;
    _product = product;
    _paymentStatus = paymentStatus;
    _vendorId = vendorId;
    _cartId = cartId;
    _productId = productId;
    _quantity = quantity;
    _image = image;
    _accept = accept;
    _reject = reject;
    _delivered = delivered;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Requests.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phone = json["phone"];
    _address1 = json["address1"];
    _address2 = json["address2"];
    _city = json["city"];
    _state = json["state"];
    _userId = json["user_id"];
    _price = json["price"];
    _product = json["product"];
    _paymentStatus = json["payment_status"];
    _vendorId = json["vendor_id"];
    _cartId = json["cart_id"];
    _productId = json["product_id"];
    _quantity = json["quantity"];
    _image = json["image"];
    _accept = json["accept"];
    _reject = json["reject"];
    _delivered = json["delivered"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address1"] = _address1;
    map["address2"] = _address2;
    map["city"] = _city;
    map["state"] = _state;
    map["user_id"] = _userId;
    map["price"] = _price;
    map["product"] = _product;
    map["payment_status"] = _paymentStatus;
    map["vendor_id"] = _vendorId;
    map["cart_id"] = _cartId;
    map["product_id"] = _productId;
    map["quantity"] = _quantity;
    map["image"] = _image;
    map["accept"] = _accept;
    map["reject"] = _reject;
    map["delivered"] = _delivered;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}