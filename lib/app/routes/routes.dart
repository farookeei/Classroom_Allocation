import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_sample/app/routes/splashscreen.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/screens/classrooms_detail.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/features/subjects/screens/subjectDetail.dart';
import 'package:test_sample/features/subjects/screens/subjects.dart';

import '../../features/classrooms/screens/classrooms.dart';
import '../../features/home_screen/home_screen.dart';
import '../../features/students/screens/student_details.dart';
import '../../features/students/screens/students.dart';

class AppRouter {
  AppRouter();

  final _subjectBloc = SubjectsCubit();
  final _classRoomCubit = ClassroomCubit();
  final _studentCubit = StudentsCubit();
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
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _classRoomCubit),
                    BlocProvider.value(value: _subjectBloc),
                    BlocProvider.value(value: _studentCubit)
                  ],
                  child: ClassRoomDetail(id: args as String? ?? ""),
                ));

      case StudentDetail.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _studentCubit,
                  child: StudentDetail(id: args as String? ?? ""),
                ));

      case ClassRoomsScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const ClassRoomsScreen());

      case SubejctsScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SubejctsScreen());

      case SubjectDetail.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _subjectBloc,
                  child: SubjectDetail(id: args as String? ?? ""),
                ));

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }

  void dispose() {
    _classRoomCubit.close();
    _subjectBloc.close();
  }
}
