import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../home_screen/home_screen.dart';

class StudentsScreen extends StatelessWidget {
  static const routeName = '/students-screen';

  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (ctx, i) {
            return const CustomListTile(
              title: "studeden 1",
            );
          }),
    ));
  }
}
