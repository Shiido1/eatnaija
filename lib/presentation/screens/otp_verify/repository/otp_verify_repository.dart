import 'dart:async';

import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/presentation/screens/otp_verify/model/otp_verify_response.dart';

import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/login/models/login_response.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';

class OtpVerifyRepository {
  final userDao = UserDao();

  Future<LoginResponse> verifyOtpRepo({String otp}) async {

    LoginResponse loginResponse = await verifyOtpRequest(otp);
    return loginResponse;
  }
}
