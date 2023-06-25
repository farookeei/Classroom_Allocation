import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/subjects/screens/subjects.dart';
import 'package:test_sample/layout/layout_scaffold.dart';
import 'package:test_sample/widgets/appbar/custom_appbar.dart';

import '../../themes/color_variables.dart';
import '../classrooms/screens/classrooms/classrooms.dart';
import '../students/screens/students.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
        backgroundColor: ReplyColors.neutralLight,
        customAppBar: const CustomAppBar(
            isLeadingEnabled: false,
            //automaticallyImplyLeading: false,
            title: "Dashboard"),
        child: GridView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in each row
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
          ),
          children: [
            MainGridTiles(
              title: "Students",
              bgColor: ReplyColors.orangeLight,
              onTap: () {
                Navigator.pushNamed(context, StudentsScreen.routeName);
              },
            ),
            MainGridTiles(
              title: "Subjects",
              bgColor: ReplyColors.redLight,
              onTap: () {
                Navigator.pushNamed(context, SubejctsScreen.routeName);
              },
            ),
            MainGridTiles(
              title: "Classrooms",
              bgColor: ReplyColors.greenLight,
              onTap: () {
                Navigator.pushNamed(context, ClassRoomsScreen.routeName);
              },
            )
          ],
        )

        //  ListView(
        //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        //   children: [
        //     MainListTiles(
        //       title: "Students",
        //       onTap: () {
        //         Navigator.pushNamed(context, StudentsScreen.routeName);
        //       },
        //     ),
        //     MainListTiles(
        //       title: "Subjects",
        //       onTap: () {
        //         Navigator.pushNamed(context, SubejctsScreen.routeName);
        //       },
        //     ),
        // MainListTiles(
        //   title: "Classrooms",
        //   onTap: () {
        //     Navigator.pushNamed(context, ClassRoomsScreen.routeName);
        //   },
        // )
        //   ],
        // )

        );
  }
}

class MainListTiles extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const MainListTiles({super.key, this.onTap, required this.title});

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

class MainGridTiles extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color bgColor;
  const MainGridTiles(
      {super.key, required this.bgColor, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return

        // Container(
        //   margin: EdgeInsets.only(bottom: 12.h),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.r),
        //     border: Border.all(width: 1, color: ReplyColors.neutral75),
        //   ),
        //   child: ListTile(
        //     onTap: onTap,
        //     title: Text(
        //       title,
        //       style: Theme.of(context).textTheme.labelLarge,
        //     ),
        //   ),
        // );

        InkWell(
      onTap: onTap,
      child: Card(
        color: bgColor,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
