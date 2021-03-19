class MyExceptions implements Exception {
  final _message;
  final _prefix;

  MyExceptions([this._message, this._prefix]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends MyExceptions {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends MyExceptions {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends MyExceptions {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends MyExceptions {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
