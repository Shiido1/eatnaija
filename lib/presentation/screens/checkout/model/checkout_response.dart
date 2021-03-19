/// status : "true"
/// message : "You have successfully checked out"
/// order_no : "F6AEAC6A"

class CheckoutResponse {
  String _status;
  String _message;
  String _orderNo;

  String get status => _status;
  String get message => _message;
  String get orderNo => _orderNo;

  CheckoutResponse({
      String status, 
      String message, 
      String orderNo}){
    _status = status;
    _message = message;
    _orderNo = orderNo;
}

  CheckoutResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _orderNo = json["order_no"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["order_no"] = _orderNo;
    return map;
  }

}