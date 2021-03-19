part of 'otp_verify_bloc.dart';

abstract class OtpVerifyState extends Equatable {
  const OtpVerifyState();

  @override
  List<Object> get props => [];
}

class OtpVerifyInitialState extends OtpVerifyState {}

class OtpVerifyLoadingState extends OtpVerifyState {}

class OtpVerifyFaliureState extends OtpVerifyState {
  final String error;

  const OtpVerifyFaliureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' OtpVerifyFaliureState { error: $error }';
}
class OtpVerifySuccessState extends OtpVerifyState {
  final User user;

  const OtpVerifySuccessState({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => ' OtpVerifySuccessState { user: $user }';
}