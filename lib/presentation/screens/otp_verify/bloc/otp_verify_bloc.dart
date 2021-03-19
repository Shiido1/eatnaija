import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/presentation/screens/otp_verify/repository/otp_verify_repository.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  OtpVerifyBloc({this.userRepository, this.authenticationBloc}) : super();

  @override
  Stream<OtpVerifyState> mapEventToState(
    OtpVerifyEvent event,
  ) async* {

    if (event is OtpButtonPressed) {

      yield OtpVerifyLoadingState();

      try {
        final loginResponse = await userRepository.verifyOtpRepo(
          otp: event.otp,
        );

        print("my vendor is");
        print(loginResponse);

        // authenticationBloc.add(LoggedIn(loginResponse: loginResponse));
        yield OtpVerifySuccessState(user: loginResponse.user);
      } catch (error) {
        yield OtpVerifyFaliureState(error: error.toString());
      }
    }
  }

  @override
  // TODO: implement initialState
  OtpVerifyState get initialState => OtpVerifyInitialState();
}
