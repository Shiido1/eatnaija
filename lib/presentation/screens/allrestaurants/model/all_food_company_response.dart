/// foodCompany : [{"id":143,"rating":null,"email":"demy7275@gmail.com","email_verified_at":null,"phone":"07046700190","company_name":"D-vine Cuisine & Lounge","category":"FoodCompany","image":"https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/VendorLogos%2FIMGrutgBJcC?alt=media&token=71ea890e-07bc-44ed-80e1-1448691be909","address":"No.15 ,Road 45,1st Avenue, Gwarimpa","city":"Abuja","state":"FCT","verified":"1","suspend":null,"created_at":"2020-11-14T18:30:36.000000Z","updated_at":"2020-11-14T18:30:36.000000Z"},{"id":137,"rating":null,"email":"nkoyoabuja@gmail.com","email_verified_at":null,"phone":"092914917","company_name":"nkoyo","category":"FoodCompany","image":"Screenshot 2020-11-13 at 11.54.02 PM_1605308526.png","address":"Ceddi Plaza Central Business District Cenral Abuja","city":"Abuja","state":"FCT","verified":"1","suspend":null,"created_at":"2020-11-13T23:02:06.000000Z","updated_at":"2020-11-13T23:39:20.000000Z"}]

class AllFoodCompanyResponse {
  List<FoodCompany> _foodCompany;

  List<FoodCompany> get foodCompany => _foodCompany;

  AllFoodCompanyResponse({
    List<FoodCompany> foodCompany}){
    _foodCompany = foodCompany;
  }

  AllFoodCompanyResponse.fromJson(dynamic json) {
    if (json["FoodCompany"] != null) {
      _foodCompany = [];
      json["FoodCompany"].forEach((v) {
        _foodCompany.add(FoodCompany.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_foodCompany != null) {
      map["FoodCompany"] = _foodCompany.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 143
/// rating : null
/// email : "demy7275@gmail.com"
/// email_verified_at : null
/// phone : "07046700190"
/// company_name : "D-vine Cuisine & Lounge"
/// category : "FoodCompany"
/// image : "https://firebasestorage.googleapis.com/v0/b/fireapp-f9104.appspot.com/o/VendorLogos%2FIMGrutgBJcC?alt=media&token=71ea890e-07bc-44ed-80e1-1448691be909"
/// address : "No.15 ,Road 45,1st Avenue, Gwarimpa"
/// city : "Abuja"
/// state : "FCT"
/// verified : "1"
/// suspend : null
/// created_at : "2020-11-14T18:30:36.000000Z"
/// updated_at : "2020-11-14T18:30:36.000000Z"

class FoodCompany {
  int _id;
  dynamic _rating;
  String _email;
  dynamic _emailVerifiedAt;
  String _phone;
  String _companyName;
  String _category;
  String _image;
  String _address;
  String _city;
  String _state;
  String _verified;
  dynamic _suspend;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  dynamic get rating => _rating;
  String get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String get phone => _phone;
  String get companyName => _companyName;
  String get category => _category;
  String get image => _image;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get verified => _verified;
  dynamic get suspend => _suspend;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  FoodCompany({
    int id,
    dynamic rating,
    String email,
    dynamic emailVerifiedAt,
    String phone,
    String companyName,
    String category,
    String image,
    String address,
    String city,
    String state,
    String verified,
    dynamic suspend,
    String createdAt,
    String updatedAt}){
    _id = id;
    _rating = rating;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _phone = phone;
    _companyName = companyName;
    _category = category;
    _image = image;
    _address = address;
    _city = city;
    _state = state;
    _verified = verified;
    _suspend = suspend;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  FoodCompany.fromJson(dynamic json) {
    _id = json["id"];
    _rating = json["rating"];
    _email = json["email"];
    _emailVerifiedAt = json["email_verified_at"];
    _phone = json["phone"];
    _companyName = json["company_name"];
    _category = json["category"];
    _image = json["image"];
    _address = json["address"];
    _city = json["city"];
    _state = json["state"];
    _verified = json["verified"];
    _suspend = json["suspend"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["rating"] = _rating;
    map["email"] = _email;
    map["email_verified_at"] = _emailVerifiedAt;
    map["phone"] = _phone;
    map["company_name"] = _companyName;
    map["category"] = _category;
    map["image"] = _image;
    map["address"] = _address;
    map["city"] = _city;
    map["state"] = _state;
    map["verified"] = _verified;
    map["suspend"] = _suspend;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}