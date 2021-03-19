import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/third':
    }
  }
}
