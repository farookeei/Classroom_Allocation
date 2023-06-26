import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';
import 'package:test_sample/themes/color_variables.dart';
import 'package:test_sample/widgets/listtile_builder.dart.dart';

import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class StudentDetail extends StatelessWidget {
  static const routeName = '/student-detail';
  final String id;
  const StudentDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<StudentsCubit>().getStudentDetail(id: id);
    return LayoutScaffold(
        backgroundColor: ReplyColors.neutralLight,
        customAppBar: const CustomAppBar(title: "Students Details"),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: BlocBuilder<StudentsCubit, StudentsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (state.isError) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              }
              return Column(
                children: [
                  SettingsListTileBuilder(items: [
                    SettingsTileModel(
                        title: "Name", trailing: state.studentDetail!.name!),
                    SettingsTileModel(
                      title: "Email",
                      trailing: state.studentDetail!.email!,
                    ),
                    SettingsTileModel(
                        title: "Age",
                        trailing: state.studentDetail!.age.toString()),
                  ])
                ],
              );
            },
          ),
        ));
  }
}
