import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/data/api/classrooms_api.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';
import 'package:test_sample/widgets/buttons/button.dart';

import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';
import '../../students/cubit/students_cubit.dart';
import '../widgets/add_student.dart';
import '../widgets/add_subject.dart';
import '../widgets/detail_tile.dart';

class ClassRoomDetail extends StatelessWidget {
  static const routeName = '/classrooms-detail';
  final String id;
  const ClassRoomDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ClassroomCubit>().getClassRoomDetail(id: id);
    context.read<SubjectsCubit>().getSubjectslist();
    context.read<StudentsCubit>().getStudentlist();
    return LayoutScaffold(
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
              DetailTile(
                title: "ClassName:",
                value: " ${state.classRoomDetail!.name!}",
              ),
              DetailTile(
                title: "id:",
                value: " ${state.classRoomDetail!.id!}",
              ),
              DetailTile(
                title: "Layout:",
                value: " ${state.classRoomDetail!.layout!}",
              ),
              DetailTile(
                title: "Size:",
                value: " ${state.classRoomDetail!.size!}",
              ),
              DetailTile(
                title: "Subject:",
                value: " ${state.classRoomDetail!.subject.toString()}",
              ),
              SizedBox(
                height: 20.h,
              ),
              AddSubjectToClass(
                subjectId: state.classRoomDetail!.subject! == ""
                    ? ""
                    : state.classRoomDetail!.subject!,
                classId: id,
              ),
              AddStudentToClass(
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
