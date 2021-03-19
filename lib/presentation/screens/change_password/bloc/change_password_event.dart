part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordButtonPressed({this.currentPassword, this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];

  @override
  String toString() {
    return 'ChangePasswordButtonPressed{currentPassword: $currentPassword, newPassword: $newPassword}';
  }
}
