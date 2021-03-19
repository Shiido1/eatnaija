part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String phone;
  final String state;
  final String city;
  final String address;
  final String image;
  final String name;
  final String password;

  RegisterButtonPressed(
      {@required this.email,
      @required this.phone,
      @required this.state,
      @required this.city,
      @required this.address,
      this.image,
      @required this.name,
      @required this.password});

  @override
  List<Object> get props =>
      [email, phone, state, city, address, image, name, password];

  @override
  String toString() {
    return 'RegisterButtonPressed{email: $email, phone: $phone, state: $state, city: $city, address: $address, image: $image, name: $name, password: $password}';
  }
}
