import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/features/subjects/data/model/subjects_model.dart';
import 'package:test_sample/themes/color_variables.dart';

import '../../../../../widgets/buttons/button.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/progress_indicator/custom_progress_indicator.dart';
import '../../../../../widgets/snackbar/custom_snackbar.dart';
import '../../../../../widgets/listtile_builder.dart.dart';

class AddSubjectToClass extends StatelessWidget {
  final String subjectId;
  final String classId;
  const AddSubjectToClass(
      {super.key, required this.subjectId, required this.classId});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selectedSubject = ValueNotifier<String>("");

    return BlocListener<ClassroomCubit, ClassroomState>(
      listener: (context, state) {},
      child: BlocBuilder<SubjectsCubit, SubjectsState>(
        builder: (context, state) {
          if (state.isLoading) {
            //  return const Center(child: CustomProgressIndicator());
          } else if (state.isError) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          String currentsubjectName = subjectId == ""
              ? "No Subject added"
              : state.subjectsList.isEmpty
                  ? ""
                  :
                  // ignore: unrelated_type_equality_checks
                  state.subjectsList.firstWhere(
                      (e) => e.id.toString() == subjectId,
                      orElse: () {
                        return Subjects();
                      },
                    ).name!;
          return Column(
            children: [
              SettingsListTileBuilder(
                items: [
                  SettingsTileModel(
                      title: "Current Subject", trailing: currentsubjectName)
                ],
              ),
              // DetailTile(
              //   title: "Subject:",
              //   value: currentsubjectName,
              // ),

              SizedBox(
                height: 20.h,
              ),
              ValueListenableBuilder(
                  valueListenable: selectedSubject,
                  builder: (ctx, vale, child) {
                    return CustomSelectField(
                      fillColor: ReplyColors.white,
                      listOptions: state.dropDownItems,
                      variant: Variant.filled,
                      handleChange: (e) {
                        log(e);
                        selectedSubject.value = e.toString();
                      },
                      label: "",
                      hintText: "Assign a subject to class",
                    );
                  }),
              SizedBox(height: 12.h),
              CustomButton(
                  state: subjectId == ""
                      ? ButtonState.enabled
                      : ButtonState.enabled,
                  onTap: () {
                    if (selectedSubject.value == "") {
                      customSnackBar(
                          context: context,
                          title: "Select a subject to proceed",
                          snackBarType: SnackBarType.error);
                    } else {
                      context.read<ClassroomCubit>().addSubjectToClass(
                          classId: classId, subjectId: selectedSubject.value);
                    }
                  },
                  child: const Text("Update Subject"))
            ],
          );
        },
      ),
    );
  }
}
