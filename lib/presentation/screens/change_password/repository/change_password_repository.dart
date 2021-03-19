import 'dart:async';
import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/dao/user_dao.dart';

import 'package:eatnaija/presentation/screens/change_password/model/change_password_request.dart';
import 'package:eatnaija/presentation/screens/change_password/model/change_password_response.dart';
import 'package:meta/meta.dart';


class ChangePasswordRepository {
  final userDao = UserDao();

  Future<ChangePasswordResponse> changePasswordRepo ({
    @required String currentPassword,
    @required String newPassword
  }) async {

    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];

    ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword
    );
    ChangePasswordResponse changePasswordResponse = await changePassword(changePasswordRequest, token);
    return changePasswordResponse;
  }

}