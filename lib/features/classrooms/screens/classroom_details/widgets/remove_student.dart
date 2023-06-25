import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/data/registration/model/registration_model.dart';
import '../../../../../themes/color_variables.dart';
import '../../../../../widgets/buttons/button.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/snackbar/custom_snackbar.dart';
import '../../../../students/cubit/students_cubit.dart';
import '../../../../students/data/model/students_model.dart';
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
    // ValueNotifier<String> _selectedRegistration = ValueNotifier<String>("");
    String _selectedRegistration = '';

    ValueNotifier<List<SelectFieldType>> listOptions =
        ValueNotifier<List<SelectFieldType>>([]);

    // List<SelectFieldType> listOptions = [];
    List<Registrations> currentsubjectregistrations = [];
    List<Students> studentList = [];
    // List<Registrations> registrations =
    //     context.read<ClassroomState>().registrations;
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          BlocBuilder<StudentsCubit, StudentsState>(
            builder: (context, state) {
              return ValueListenableBuilder(
                  valueListenable: listOptions,
                  builder: (ctx, value, child) {
                    return CustomSelectField(
                      // listOptions: state.dropDownItems,

                      listOptions: listOptions.value,
                      fillColor: ReplyColors.white,
                      variant: Variant.filled,
                      handleChange: (e) {
                        log(e);
                        _selectedRegistration = e;
                      },
                      label: "",
                      hintText: "Add Student",
                    );
                  });
            },
          ),
          SizedBox(height: 12.h),
          //!
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
              List<Students> studentList =
                  context.read<StudentsCubit>().returnStudentList();
              // listOptions.value = [];
              for (int i = 0; i < state.registrations.length; i++) {
                if (state.registrations[i].subject.toString() == subjectId) {
                  currentsubjectregistrations.add(state.registrations[i]);

                  listOptions.value.add(SelectFieldType(
                      label: state.registrations[i].student.toString(),
                      value: state.registrations[i].id.toString()));
                  // for (int j = 0; j < studentList.length; j++) {
                  //   if (state.registrations[i].student.toString() ==
                  //       studentList[j].id.toString()) {
                  //     listOptions.value.add(SelectFieldType(
                  //         label: studentList[j].name!,
                  //         value: state.registrations[i].id.toString()));
                  //     break;
                  //   }
                  // }
                }
              }
              return Column(
                children: [
                  CustomButton(
                      backgroundColor: ReplyColors.red100,
                      state: state.isRemovingRegist
                          ? ButtonState.loading
                          : isSubjectAssignedToClass
                              ? ButtonState.enabled
                              : ButtonState.disabled,
                      onTap: () {
                        if (_selectedRegistration == "") {
                          customSnackBar(
                              context: context,
                              title: "Select a student to proceed",
                              snackBarType: SnackBarType.error);
                        } else {
                          //!!!!!
                          context
                              .read<ClassroomCubit>()
                              .deleteStudentRegistration(
                                  regId: _selectedRegistration);
                        }
                      },
                      disabledMsg:
                          "Subject needs to be assigned to the classroom",
                      child: const Text("Remove Student")),
                  Text(
                      "total registration count:${state.registrations.length}"),
                  Text(
                      "this sub registration count:${currentsubjectregistrations.length}")
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
