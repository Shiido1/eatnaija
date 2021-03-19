/// cart : [{"id":18,"user_id":"18","product_id":"8","parent_id":"13","product_name":"Semo with Egusi soup","image":"https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMG-wTMv8dD?alt=media&token=8f3fc02b-8011-4034-a4ff-4a148350d2b3","description":"Semovita with Melon soup","quantity":"1","category":"AFrican food","vendor_id":"2","vendor_name":"Aakenus Restaurant","price":"2100","total":null,"created_at":"2020-11-23T23:02:02.000000Z","updated_at":"2020-11-23T23:02:02.000000Z"}]

class CartItemsResponse {
  List<AllCart> _cart;

  List<AllCart> get cart => _cart;

  CartItemsResponse({
      List<AllCart> cart}){
    _cart = cart;
}

  CartItemsResponse.fromJson(dynamic json) {
    if (json["cart"] != null) {
      _cart = [];
      json["cart"].forEach((v) {
        _cart.add(AllCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_cart != null) {
      map["cart"] = _cart.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// user_id : "18"
/// product_id : "8"
/// parent_id : "13"
/// product_name : "Semo with Egusi soup"
/// image : "https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMG-wTMv8dD?alt=media&token=8f3fc02b-8011-4034-a4ff-4a148350d2b3"
/// description : "Semovita with Melon soup"
/// quantity : "1"
/// category : "AFrican food"
/// vendor_id : "2"
/// vendor_name : "Aakenus Restaurant"
/// price : "2100"
/// total : null
/// created_at : "2020-11-23T23:02:02.000000Z"
/// updated_at : "2020-11-23T23:02:02.000000Z"

class AllCart {
  int _id;
  String _userId;
  String _productId;
  String _parentId;
  String _productName;
  String _image;
  String _description;
  String _quantity;
  String _category;
  String _vendorId;
  String _vendorName;
  String _price;
  dynamic _total;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get userId => _userId;
  String get productId => _productId;
  String get parentId => _parentId;
  String get productName => _productName;
  String get image => _image;
  String get description => _description;
  String get quantity => _quantity;
  String get category => _category;
  String get vendorId => _vendorId;
  String get vendorName => _vendorName;
  String get price => _price;
  dynamic get total => _total;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;


  set quantity(String value) {
    _quantity = value;
  }


  set price(String value) {
    _price = value;
  }

  AllCart({
      int id, 
      String userId, 
      String productId, 
      String parentId, 
      String productName, 
      String image, 
      String description, 
      String quantity, 
      String category, 
      String vendorId, 
      String vendorName, 
      String price, 
      dynamic total, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _parentId = parentId;
    _productName = productName;
    _image = image;
    _description = description;
    _quantity = quantity;
    _category = category;
    _vendorId = vendorId;
    _vendorName = vendorName;
    _price = price;
    _total = total;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AllCart.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _productId = json["product_id"];
    _parentId = json["parent_id"];
    _productName = json["product_name"];
    _image = json["image"];
    _description = json["description"];
    _quantity = json["quantity"];
    _category = json["category"];
    _vendorId = json["vendor_id"];
    _vendorName = json["vendor_name"];
    _price = json["price"];
    _total = json["total"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["product_id"] = _productId;
    map["parent_id"] = _parentId;
    map["product_name"] = _productName;
    map["image"] = _image;
    map["description"] = _description;
    map["quantity"] = _quantity;
    map["category"] = _category;
    map["vendor_id"] = _vendorId;
    map["vendor_name"] = _vendorName;
    map["price"] = _price;
    map["total"] = _total;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}