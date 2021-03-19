part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final LoginResponse loginResponse;

  const LoggedIn({@required this.loginResponse});

  @override
  List<Object> get props => [loginResponse];

  @override
  String toString() => 'LoggedIn { loginResponse: ${loginResponse.user.name}';
}

class LoggedOut extends AuthenticationEvent {}

class SignedUp extends AuthenticationEvent {}
