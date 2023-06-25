import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/features/students/screens/student_details.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../../themes/color_variables.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/listtile/custom_listtile.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class StudentsScreen extends StatelessWidget {
  static const routeName = '/students-screen';

  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
        backgroundColor: ReplyColors.neutralLight,
        customAppBar: const CustomAppBar(title: "Students"),
        child: BlocProvider(
          create: (context) => StudentsCubit()..getStudentlist(),
          child: BlocBuilder<StudentsCubit, StudentsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (state.isError) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              }
              return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  shrinkWrap: true,
                  itemCount: state.studentList.length,
                  itemBuilder: (ctx, i) {
                    return CustomListTile(
                      onTap: () {
                        Navigator.pushNamed(context, StudentDetail.routeName,
                            arguments: state.studentList[i].id.toString());
                      },
                      title: "Name: ${state.studentList[i].name!}",
                      subtitle:
                          "Age:    ${state.studentList[i].age.toString()}",
                    );
                  });
            },
          ),
        ));
  }
}
