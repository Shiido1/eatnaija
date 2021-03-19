/// status : "true"
/// message : "Product Removed from cart!"

class DeleteCartItemResponse {
  String _status;
  String _message;
  int _items;

  String get status => _status;
  String get message => _message;
  int get items => _items;

  DeleteCartItemResponse({
      String status, 
      String message, int items}){
    _status = status;
    _message = message;
    _items = items;
}

  DeleteCartItemResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _items = json["items"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["items"] = _items;
    return map;
  }

}