import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/data/api/classrooms_api.dart';
import 'package:test_sample/features/classrooms/screens/classroom_details/widgets/remove_student.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../../../themes/color_variables.dart';
import '../../../../widgets/appbar/custom_appbar.dart';
import '../../../../widgets/progress_indicator/custom_progress_indicator.dart';
import '../../../students/cubit/students_cubit.dart';

import '../../../../widgets/listtile_builder.dart.dart';
import 'widgets/add_student.dart';
import 'widgets/add_subject.dart';

class ClassRoomDetail extends StatelessWidget {
  static const routeName = '/classrooms-detail';
  final String id;
  const ClassRoomDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ClassroomCubit>().getClassRoomDetail(id: id);
    context.read<SubjectsCubit>().getSubjectslist();
    context.read<StudentsCubit>().getStudentlist();
    context.read<ClassroomCubit>().getRegistrations();
    return LayoutScaffold(
        customAppBar: const CustomAppBar(title: "Classroom Detail"),
        backgroundColor: ReplyColors.neutralLight,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: BlocBuilder<ClassroomCubit, ClassroomState>(
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
                  ClassDetailsWidget(
                    state: state,
                  ),
                  AddSubjectToClass(
                    subjectId: state.classRoomDetail!.subject! == ""
                        ? ""
                        : state.classRoomDetail!.subject!,
                    classId: id,
                  ),
                  AddStudentToClass(
                    classId: id,
                    isSubjectAssignedToClass:
                        state.classRoomDetail!.subject == "" ? false : true,
                    subjectId: state.classRoomDetail!.subject == ""
                        ? null
                        : state.classRoomDetail!.subject,
                  ),
                  RemoveStudentFromClass(
                    classId: id,
                    isSubjectAssignedToClass:
                        state.classRoomDetail!.subject == "" ? false : true,
                    subjectId: state.classRoomDetail!.subject == ""
                        ? null
                        : state.classRoomDetail!.subject,
                  )
                ],
              );
            },
          ),
        ));
  }
}

class ClassDetailsWidget extends StatelessWidget {
  final ClassroomState state;

  const ClassDetailsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    List<SettingsTileModel> items = [
      SettingsTileModel(
        title: "ClassName",
        trailing: state.classRoomDetail!.name!,
      ),
      SettingsTileModel(
          title: "Layout", trailing: state.classRoomDetail!.layout!),
      SettingsTileModel(
        title: "Size",
        trailing: state.classRoomDetail!.size!.toString(),
      ),
    ];
    return SettingsListTileBuilder(
      items: items,
    );
  }
}
