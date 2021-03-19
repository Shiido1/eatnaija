part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class GoogleLoginButtonPressed extends LoginEvent {
  final String email;
  final String image;
  final String name;

  const GoogleLoginButtonPressed({@required this.email, this.image, @required this.name});

  @override
  List<Object> get props => [email, image, name];

  @override
  String toString() {
    return 'GoogleLoginButtonPressed{email: $email, image: $image, name: $name}';
  }
}
