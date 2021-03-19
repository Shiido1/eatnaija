part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  final ResetPasswordResponse resetPasswordResponse;

  ResetPasswordSuccessState({this.resetPasswordResponse});

  @override
  List<Object> get props => [resetPasswordResponse];
}

class ResetPasswordFailureState extends ResetPasswordState {
  final String error;

  ResetPasswordFailureState({this.error});

  @override
  List<Object> get props => [error];
}
