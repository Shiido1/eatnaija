/// otp : "3510"

class OtpVerifyRequest {
  String _otp;

  String get otp => _otp;


  set otp(String value) {
    _otp = value;
  }

  OtpVerifyRequest({
      String otp}){
    _otp = otp;
}

  OtpVerifyRequest.fromJson(dynamic json) {
    _otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["otp"] = _otp;
    return map;
  }

}