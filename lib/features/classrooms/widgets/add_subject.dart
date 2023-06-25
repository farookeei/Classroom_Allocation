import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';

import '../../../widgets/buttons/button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';
import '../../subjects/cubit/subjects_cubit.dart';
import 'detail_tile.dart';

class AddSubjectToClass extends StatelessWidget {
  final String subjectId;
  final String classId;
  const AddSubjectToClass(
      {super.key, required this.subjectId, required this.classId});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> _selectedSubject = ValueNotifier<String>("");

    return BlocListener<ClassroomCubit, ClassroomState>(
      listener: (context, state) {},
      child: BlocBuilder<SubjectsCubit, SubjectsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CustomProgressIndicator());
          } else if (state.isError) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          String currentsubjectName = subjectId == ""
              ? "No Subject added"
              :
              // ignore: unrelated_type_equality_checks
              state.subjectsList
                  .where((e) => e.id.toString() == subjectId)
                  .first
                  .name!;
          return Column(
            children: [
              DetailTile(
                title: "Subject:",
                value: currentsubjectName,
              ),
              ValueListenableBuilder(
                  valueListenable: _selectedSubject,
                  builder: (ctx, vale, child) {
                    return CustomSelectField(
                      listOptions: state.dropDownItems,
                      variant: Variant.filled,
                      handleChange: (e) {
                        log(e);
                        _selectedSubject.value = e.toString();
                      },
                      label: "Assign a subject to class",
                      hintText: "",
                    );
                  }),
              SizedBox(height: 12.h),
              CustomButton(
                  state: subjectId == ""
                      ? ButtonState.enabled
                      : ButtonState.enabled,
                  onTap: () {
                    context.read<ClassroomCubit>().addSubjectToClass(
                        classId: classId, subjectId: _selectedSubject.value);
                  },
                  child: const Text("Submit"))
            ],
          );
        },
      ),
    );
  }
}
