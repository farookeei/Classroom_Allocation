import 'package:flutter/material.dart';
import 'package:test_sample/app/routes/splashscreen.dart';
import 'package:test_sample/screens/home_screen/home_screen.dart';

import '../../screens/students/students.dart';

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    // var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case StudentsScreen.routeName:
        return MaterialPageRoute(builder: (context) => const StudentsScreen());

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
