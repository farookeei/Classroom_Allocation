import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';

import '../../../widgets/buttons/button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';
import '../../subjects/cubit/subjects_cubit.dart';
import 'detail_tile.dart';

class AddStudentToClass extends StatelessWidget {
  final String? subjectId;
  final bool isSubjectAssignedToClass;
  const AddStudentToClass(
      {super.key, this.subjectId, this.isSubjectAssignedToClass = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsCubit, StudentsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CustomProgressIndicator());
        } else if (state.isError) {
          return Center(
            child: Text(state.errorMessage.toString()),
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            children: [
              CustomSelectField(
                listOptions: state.dropDownItems,
                variant: Variant.filled,
                handleChange: (e) {
                  log(e);
                },
                label: "Add Student",
                hintText: "",
              ),
              SizedBox(height: 12.h),
              CustomButton(
                  state: isSubjectAssignedToClass
                      ? ButtonState.enabled
                      : ButtonState.disabled,
                  onTap: () {},
                  disabledMsg: "Subject needs to be assigned to the classroom",
                  child: const Text("Submit"))
            ],
          ),
        );
      },
    );
  }
}
