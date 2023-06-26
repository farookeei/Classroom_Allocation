import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/data/registration/model/registration_model.dart';
import '../../../../../themes/color_variables.dart';
import '../../../../../widgets/buttons/button.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/snackbar/custom_snackbar.dart';

import '../../../cubit/classroom_cubit.dart';

class RemoveStudentFromClass extends StatelessWidget {
  final String? subjectId;
  final bool isSubjectAssignedToClass;
  final String classId;
  const RemoveStudentFromClass(
      {super.key,
      this.subjectId,
      required this.classId,
      this.isSubjectAssignedToClass = false});

  @override
  Widget build(BuildContext context) {
    String selectedRegistration = '';

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          BlocConsumer<ClassroomCubit, ClassroomState>(
            listener: (context, state) {
              if (state.isRemovingRegist) {
              } else if (state.isRemovingRegistError) {
                customSnackBar(
                    context: context,
                    snackBarType: SnackBarType.error,
                    title: state.errorMessage);
              } else if (state.isRemovingRegistSucess) {
                customSnackBar(
                    context: context,
                    snackBarType: SnackBarType.success,
                    title: "Successfully deleted Student");
              }
            },
            listenWhen: (previous, current) =>
                previous.isRemovingRegist != current.isRemovingRegist,
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomSelectField(
                    listOptions: state.registrationsSelections,
                    fillColor: ReplyColors.white,
                    variant: Variant.filled,
                    handleChange: (e) {
                      log(e);
                      selectedRegistration = e;
                    },
                    label: "Remove Student Registrations",
                    hintText: "Select Student registration",
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                      backgroundColor: ReplyColors.red100,
                      state: state.isRemovingRegist
                          ? ButtonState.loading
                          : isSubjectAssignedToClass
                              ? ButtonState.enabled
                              : ButtonState.disabled,
                      onTap: () {
                        if (selectedRegistration == "") {
                          customSnackBar(
                              context: context,
                              title:
                                  "Select a student's registration to proceed",
                              snackBarType: SnackBarType.error);
                        } else {
                          context
                              .read<ClassroomCubit>()
                              .deleteStudentRegistration(
                                  regId: selectedRegistration);
                        }
                      },
                      disabledMsg:
                          "Subject needs to be assigned to the classroom",
                      child: const Text("Remove Student registration")),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
