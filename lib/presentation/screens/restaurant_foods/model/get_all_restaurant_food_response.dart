/// menu : [{"id":28,"name":"Sea Food Pasta","category":"Lunch/Dinner","description":"Jumbo prawns Vegetable","location":"Gwarimpa","vendor_id":"143","vendor_name":"D-vine Cuisine & Lounge","image":"https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMGECDv6tNZ?alt=media&token=7e400a7d-d919-4ba9-9651-23f73c0c3a31","price":"3000","promo_price":null,"main_category":"Restaurants","created_at":"2020-11-14T18:44:14.000000Z","updated_at":"2020-11-14T18:44:14.000000Z"}]

class GetAllRestaurantFoodResponse {
  List<Menu> _menu;

  List<Menu> get menu => _menu;

  GetAllRestaurantFoodResponse({
      List<Menu> menu}){
    _menu = menu;
}

  GetAllRestaurantFoodResponse.fromJson(dynamic json) {
    if (json["menu"] != null) {
      _menu = [];
      json["menu"].forEach((v) {
        _menu.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_menu != null) {
      map["menu"] = _menu.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 28
/// name : "Sea Food Pasta"
/// category : "Lunch/Dinner"
/// description : "Jumbo prawns Vegetable"
/// location : "Gwarimpa"
/// vendor_id : "143"
/// vendor_name : "D-vine Cuisine & Lounge"
/// image : "https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/UploadedFoods%2FIMGECDv6tNZ?alt=media&token=7e400a7d-d919-4ba9-9651-23f73c0c3a31"
/// price : "3000"
/// promo_price : null
/// main_category : "Restaurants"
/// created_at : "2020-11-14T18:44:14.000000Z"
/// updated_at : "2020-11-14T18:44:14.000000Z"

class Menu {
  int _id;
  String _name;
  String _category;
  String _description;
  String _location;
  String _vendorId;
  String _vendorName;
  String _image;
  String _price;
  dynamic _promoPrice;
  String _mainCategory;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get category => _category;
  String get description => _description;
  String get location => _location;
  String get vendorId => _vendorId;
  String get vendorName => _vendorName;
  String get image => _image;
  String get price => _price;
  dynamic get promoPrice => _promoPrice;
  String get mainCategory => _mainCategory;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Menu({
      int id, 
      String name, 
      String category, 
      String description, 
      String location, 
      String vendorId, 
      String vendorName, 
      String image, 
      String price, 
      dynamic promoPrice, 
      String mainCategory, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _category = category;
    _description = description;
    _location = location;
    _vendorId = vendorId;
    _vendorName = vendorName;
    _image = image;
    _price = price;
    _promoPrice = promoPrice;
    _mainCategory = mainCategory;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Menu.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _category = json["category"];
    _description = json["description"];
    _location = json["location"];
    _vendorId = json["vendor_id"];
    _vendorName = json["vendor_name"];
    _image = json["image"];
    _price = json["price"];
    _promoPrice = json["promo_price"];
    _mainCategory = json["main_category"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["category"] = _category;
    map["description"] = _description;
    map["location"] = _location;
    map["vendor_id"] = _vendorId;
    map["vendor_name"] = _vendorName;
    map["image"] = _image;
    map["price"] = _price;
    map["promo_price"] = _promoPrice;
    map["main_category"] = _mainCategory;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}