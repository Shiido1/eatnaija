import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:eatnaija/presentation/screens/register/models/register_response.dart';
import 'package:flutter/cupertino.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({this.userRepository, this.authenticationBloc}) : super();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoadingState();

      try {
        final user = await userRepository.register(
          name: event.name,
            email: event.email,
            phone: event.phone,
            password: event.password,
            state: event.state,
            city: event.city,
            address: event.address,
            image: event.address);
        authenticationBloc.add(LoggedOut());
        yield RegisterCompleteState(user);
      } catch (error) {
        print(error);
        yield RegisterFailureState(error: error.toString());
      }
    }
  }

  @override
  RegisterState get initialState => RegisterInitialState();
}
