part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  final ChangePasswordResponse changePasswordResponse;

  ChangePasswordSuccessState({this.changePasswordResponse});

  @override
  List<Object> get props => [changePasswordResponse];
}

class ChangePasswordFailureState extends ChangePasswordState {
  final String error;

  ChangePasswordFailureState({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ChangePasswordFailureState{error: $error}';
  }
}
