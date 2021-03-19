import 'package:eatnaija/presentation/router/app_router.dart';
import 'package:eatnaija/presentation/screens/home/home_page.dart';
import 'package:eatnaija/presentation/screens/home/home_screen.dart';
import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/presentation/screens/splash/splash_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:eatnaija/common/globals.dart' as globals;

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/authentication_bloc.dart';
import 'common/app_state.dart';
import 'common/loading_indicator.dart';
import 'common/resources.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(ChangeNotifierProvider<AppState>(
    create: (_) => AppState(),
    child: BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final AppRouter _appRouter = AppRouter();

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
          accentColor: Resources.PRIMARY_COLOR),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            // return LoginScreen(userRepository: userRepository);
            return HomePage();
          }
          if (state is AuthenticationSignedup) {
            // return LoginScreen(userRepository: userRepository);
            return HomePage();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
