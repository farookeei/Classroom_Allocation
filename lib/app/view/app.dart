import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/data/network_client/dio_client.dart';
import '../routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: const [],
    //   child: AppView(),
    // );

    return AppView();
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppView extends StatefulWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final _router;
  final DioClient _dio = DioClient();

  @override
  void initState() {
    _router = AppRouter();

    super.initState();
  }

  @override
  void dispose() {
    _router.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        designSize: const Size(360, 800),
        builder: (ctx, _) {
          return MaterialApp(
            navigatorObservers: [routeObserver],
            //navigatorKey: GlobalVariable.navState,
            debugShowCheckedModeBanner: false,
            //theme: AppTheme.light,
            // darkTheme: AppTheme.dark,
            title: 'test',
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            onGenerateRoute: _router.onGenerateRoute,
          );
        });
  }
}
