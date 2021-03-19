/// orderhistory : [{"id":21,"name":"Eze ThankGod","phone":"08163984463","address1":"Plot 707 sentinel crescent, durumi 2 abuja","address2":null,"city":"Abuja","state":"Fct","user_id":"18","price":"2500","product":"Pocho Soup","payment_status":"1","vendor_id":"135","cart_id":"13","product_id":"56","quantity":"1","image":"https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMGLZYqacP8?alt=media&token=96c6017a-d4c9-4e46-958f-bb0a1c25ea18","accept":"1","reject":"0","delivered":"0","order_no":"6BAFC5BD","total":"3688","created_at":"2020-11-26T11:12:29.000000Z","updated_at":"2020-11-27T17:12:55.000000Z"}]

class OrderHistoryResponse {
  List<Orderhistory> _orderhistory;

  List<Orderhistory> get orderhistory => _orderhistory;

  OrderHistoryResponse({
      List<Orderhistory> orderhistory}){
    _orderhistory = orderhistory;
}

  OrderHistoryResponse.fromJson(dynamic json) {
    if (json["orderhistory"] != null) {
      _orderhistory = [];
      json["orderhistory"].forEach((v) {
        _orderhistory.add(Orderhistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_orderhistory != null) {
      map["orderhistory"] = _orderhistory.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 21
/// name : "Eze ThankGod"
/// phone : "08163984463"
/// address1 : "Plot 707 sentinel crescent, durumi 2 abuja"
/// address2 : null
/// city : "Abuja"
/// state : "Fct"
/// user_id : "18"
/// price : "2500"
/// product : "Pocho Soup"
/// payment_status : "1"
/// vendor_id : "135"
/// cart_id : "13"
/// product_id : "56"
/// quantity : "1"
/// image : "https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMGLZYqacP8?alt=media&token=96c6017a-d4c9-4e46-958f-bb0a1c25ea18"
/// accept : "1"
/// reject : "0"
/// delivered : "0"
/// order_no : "6BAFC5BD"
/// total : "3688"
/// created_at : "2020-11-26T11:12:29.000000Z"
/// updated_at : "2020-11-27T17:12:55.000000Z"

class Orderhistory {
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
  String _orderNo;
  String _total;
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
  String get orderNo => _orderNo;
  String get total => _total;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Orderhistory({
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
      String orderNo, 
      String total, 
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
    _orderNo = orderNo;
    _total = total;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Orderhistory.fromJson(dynamic json) {
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
    _orderNo = json["order_no"];
    _total = json["total"];
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
    map["order_no"] = _orderNo;
    map["total"] = _total;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}