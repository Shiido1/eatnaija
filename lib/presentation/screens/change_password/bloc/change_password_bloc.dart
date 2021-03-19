import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/presentation/screens/change_password/model/change_password_response.dart';
import 'package:eatnaija/presentation/screens/change_password/repository/change_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository vendorRepository;

  ChangePasswordBloc({this.vendorRepository}) : super();

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {

    if (event is ChangePasswordButtonPressed) {
      yield ChangePasswordLoadingState();

      try {
        final loginResponse = await vendorRepository.changePasswordRepo(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );

        print("my vendor is");
        print(loginResponse);

         yield ChangePasswordSuccessState(changePasswordResponse: loginResponse);
      } catch (error) {
        yield ChangePasswordFailureState(error: error);
      }
    }

  }

  @override
  ChangePasswordState get initialState => ChangePasswordInitialState();
}
