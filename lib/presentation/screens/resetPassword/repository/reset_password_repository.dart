import 'dart:async';
import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/dao/user_dao.dart';

import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_request.dart';
import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_response.dart';

import 'package:eatnaija/presentation/screens/change_password/model/change_password_request.dart';
import 'package:eatnaija/presentation/screens/change_password/model/change_password_response.dart';
import 'package:meta/meta.dart';


class ResetPasswordRepository {

  Future<ResetPasswordResponse> resetPasswordRepo ({
    @required String email,
  }) async {

    ResetPasswordRequest resetPassword = ResetPasswordRequest(
        email: email
    );
    ResetPasswordResponse changePasswordResponse = await resetPasswordRequest(resetPassword);
    return changePasswordResponse;
  }
}