import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../themes/color_variables.dart';
import '../students/students.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
        child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      children: [
        CustomListTile(
          title: "Students",
          onTap: () {
            Navigator.pushNamed(context, StudentsScreen.routeName);
          },
        ),
        CustomListTile(
          title: "Subjects",
        ),
        CustomListTile(
          title: "Classrooms",
        )
      ],
    ));
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CustomListTile({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(width: 1, color: ReplyColors.neutral75),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
