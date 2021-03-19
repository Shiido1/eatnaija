import 'dart:async';

import 'dart:io';

import 'package:eatnaija/api_connection/myexceptions.dart';

class FailureException {
  final Exception _exception;

  FailureException(this._exception);

  String response() {
    switch (_exception.runtimeType) {
      case TimeoutException:
        return 'Network timeout! Please check Internet connection';
        break;
      case SocketException:
        return 'No internet connection 😑';
        break;
      case UnauthorisedException:
        return 'User already exists 😑';
        break;
      case FormatException:
        return 'Bad response format.';
        break;
      case HttpException:
        return 'Couldn\'t find the post 😱';
        break;
      case CustomException:
        return 'User already exists';
      case PasswordChangeException:
        return 'Unable to change password';
      default:
        return 'An unknown error has occurred!';
    }
  }
}

class CustomException implements Exception {
  String cause;

  CustomException(this.cause);
}

class PasswordChangeException implements Exception {
  String cause;

  PasswordChangeException(this.cause);
}
