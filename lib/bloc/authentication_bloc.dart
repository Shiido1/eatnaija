import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eatnaija/common/globals.dart' as globals;
import 'package:eatnaija/presentation/screens/login/models/login_response.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:eatnaija/repository/user_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {

      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      User user =  event.loginResponse.user;

      user.token = event.loginResponse.token;
      user.cart = event.loginResponse.cart;

      globals.cartCount = user.cart;

      await userRepository.persistToken(
        user: user
      );

      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userRepository.deleteUser();

      yield AuthenticationUnauthenticated();
    }

    if (event is SignedUp) {
      yield AuthenticationLoading();
      yield AuthenticationUnauthenticated();
    }
  }
}
