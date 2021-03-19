part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent extends Equatable {
  const OtpVerifyEvent();
}

class OtpButtonPressed extends OtpVerifyEvent {
  final String otp;


  const OtpButtonPressed({
    @required this.otp,
  });

  @override
  List<Object> get props => [otp];

  @override
  String toString() => 'OtpButtonPressed { otp: $otp,}';
}
