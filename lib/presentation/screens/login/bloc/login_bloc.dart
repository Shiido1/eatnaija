import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {

      yield LoginLoading();

      try {
        final loginResponse = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        print("my vendor is");
        print(loginResponse);

        // yield LoginInitial();
        authenticationBloc.add(LoggedIn(loginResponse: loginResponse));
        yield LoginSuccess();

      } catch (error) {
        yield LoginFaliure(error: error.toString());
      }
    }

    if (event is GoogleLoginButtonPressed) {

      yield LoginLoading();

      try {
        final loginResponse = await userRepository.googleLoginRepo(
          email: event.email,
          image: event.image,
          name: event.name
        );

        print("my vendor is");
        print(loginResponse);

        // yield LoginInitial();
        authenticationBloc.add(LoggedIn(loginResponse: loginResponse));
        yield LoginSuccess();
      } catch (error) {
        yield LoginFaliure(error: error.toString());
      }
    }
  }
}
