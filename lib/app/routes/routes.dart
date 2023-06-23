import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_sample/app/routes/splashscreen.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/screens/classrooms_detail.dart';

import '../../features/classrooms/screens/classrooms.dart';
import '../../features/home_screen/home_screen.dart';
import '../../features/students/screens/students.dart';

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case StudentsScreen.routeName:
        return MaterialPageRoute(builder: (context) => const StudentsScreen());

      case ClassRoomDetail.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ClassroomCubit(),
                  child: ClassRoomDetail(id: args as String? ?? ""),
                ));

      case ClassRoomsScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const ClassRoomsScreen());

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
