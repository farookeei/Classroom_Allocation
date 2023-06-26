import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';

import '../../../../../themes/color_variables.dart';
import '../../../../../widgets/buttons/button.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/snackbar/custom_snackbar.dart';

class AddStudentToClass extends StatelessWidget {
  final String? subjectId;
  final bool isSubjectAssignedToClass;
  final String classId;
  const AddStudentToClass(
      {super.key,
      this.subjectId,
      required this.classId,
      this.isSubjectAssignedToClass = false});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selectedStudent = ValueNotifier<String>("");

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          BlocBuilder<StudentsCubit, StudentsState>(
            builder: (context, state) {
              return ValueListenableBuilder(
                  valueListenable: selectedStudent,
                  builder: (ctx, value, child) {
                    return CustomSelectField(
                      listOptions: state.dropDownItems,
                      fillColor: ReplyColors.white,
                      variant: Variant.filled,
                      handleChange: (e) {
                        selectedStudent.value = e;
                      },
                      label: "",
                      hintText: "Add Student",
                    );
                  });
            },
          ),
          SizedBox(height: 12.h),
          BlocConsumer<ClassroomCubit, ClassroomState>(
            listener: (context, state) {
              if (state.isRegistering) {
              } else if (state.isRegisteringError) {
                customSnackBar(
                    context: context,
                    snackBarType: SnackBarType.error,
                    title: state.errorMessage);
              } else if (state.isRegisteringSucess) {
                customSnackBar(
                    context: context,
                    snackBarType: SnackBarType.success,
                    title: "Successfully registered Student");
              }
            },
            listenWhen: (previous, current) =>
                previous.isRegistering != current.isRegistering,
            builder: (context, state) {
              return CustomButton(
                  state: state.isRegistering
                      ? ButtonState.loading
                      : isSubjectAssignedToClass
                          ? ButtonState.enabled
                          : ButtonState.disabled,
                  onTap: () {
                    if (selectedStudent.value == "") {
                      customSnackBar(
                          context: context,
                          title: "Select a student to proceed",
                          snackBarType: SnackBarType.error);
                    } else {
                      context.read<ClassroomCubit>().postStudentRegistration(
                          studentId: selectedStudent.value,
                          classId: classId,
                          subjectId: subjectId!);
                    }
                  },
                  disabledMsg: "Subject needs to be assigned to the classroom",
                  child: const Text("Add Student"));
            },
          ),
        ],
      ),
    );
  }
}
