/// status : "true"
/// message : "Product added to cart successfully!"
/// cart : {"parent_id":"13","product_id":8,"user_id":18,"vendor_id":"2","vendor_name":"Aakenus Restaurant","product_name":"Semo with Egusi soup","category":"AFrican food","quantity":2,"price":4200,"description":"Semovita with Melon soup","image":"https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMG-wTMv8dD?alt=media&token=8f3fc02b-8011-4034-a4ff-4a148350d2b3"}

class ManageCartResponse {
  String _status;
  String _message;
  int _items;
  Cart _cart;

  String get status => _status;
  String get message => _message;
  Cart get cart => _cart;

  int get items => _items;

  set items(int value) {
    _items = value;
  }

  ManageCartResponse({
      String status, 
      String message, 
      Cart cart, int items}){
    _status = status;
    _message = message;
    _cart = cart;
    _items = items;
}

  ManageCartResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _items = json["items"];
    _cart = json["cart"] != null ? Cart.fromJson(json["cart"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["items"] = _items;
    if (_cart != null) {
      map["cart"] = _cart.toJson();
    }
    return map;
  }

}

/// parent_id : "13"
/// product_id : 8
/// user_id : 18
/// vendor_id : "2"
/// vendor_name : "Aakenus Restaurant"
/// product_name : "Semo with Egusi soup"
/// category : "AFrican food"
/// quantity : 2
/// price : 4200
/// description : "Semovita with Melon soup"
/// image : "https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMG-wTMv8dD?alt=media&token=8f3fc02b-8011-4034-a4ff-4a148350d2b3"

class Cart {
  String _parentId;
  int _productId;
  int _userId;
  String _vendorId;
  String _vendorName;
  String _productName;
  String _category;
  int _quantity;
  int _price;
  String _description;
  String _image;

  String get parentId => _parentId;
  int get productId => _productId;
  int get userId => _userId;
  String get vendorId => _vendorId;
  String get vendorName => _vendorName;
  String get productName => _productName;
  String get category => _category;
  int get quantity => _quantity;
  int get price => _price;
  String get description => _description;
  String get image => _image;

  Cart({
      String parentId, 
      int productId, 
      int userId, 
      String vendorId, 
      String vendorName, 
      String productName, 
      String category, 
      int quantity, 
      int price, 
      String description, 
      String image}){
    _parentId = parentId;
    _productId = productId;
    _userId = userId;
    _vendorId = vendorId;
    _vendorName = vendorName;
    _productName = productName;
    _category = category;
    _quantity = quantity;
    _price = price;
    _description = description;
    _image = image;
}

  Cart.fromJson(dynamic json) {
    _parentId = json["parent_id"];
    _productId = json["product_id"];
    _userId = json["user_id"];
    _vendorId = json["vendor_id"];
    _vendorName = json["vendor_name"];
    _productName = json["product_name"];
    _category = json["category"];
    _quantity = json["quantity"];
    _price = json["price"];
    _description = json["description"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["parent_id"] = _parentId;
    map["product_id"] = _productId;
    map["user_id"] = _userId;
    map["vendor_id"] = _vendorId;
    map["vendor_name"] = _vendorName;
    map["product_name"] = _productName;
    map["category"] = _category;
    map["quantity"] = _quantity;
    map["price"] = _price;
    map["description"] = _description;
    map["image"] = _image;
    return map;
  }

}