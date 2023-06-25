// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
// import 'package:test_sample/features/students/cubit/students_cubit.dart';

// import '../../../widgets/buttons/button.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/progress_indicator/custom_progress_indicator.dart';
// import '../../../widgets/snackbar/custom_snackbar.dart';
// import '../../subjects/cubit/subjects_cubit.dart';
// import '../data/api/classrooms_api.dart';
// import 'detail_tile.dart';

// class AddStudentToClass extends StatelessWidget {
//   final String? subjectId;
//   final bool isSubjectAssignedToClass;
//   final String classId;
//   const AddStudentToClass(
//       {super.key,
//       this.subjectId,
//       required this.classId,
//       this.isSubjectAssignedToClass = false});

//   @override
//   Widget build(BuildContext context) {
//     ValueNotifier<String> _selectedStudent = ValueNotifier<String>("");

//     return BlocBuilder<StudentsCubit, StudentsState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(child: CustomProgressIndicator());
//         } else if (state.isError) {
//           return Center(
//             child: Text(state.errorMessage.toString()),
//           );
//         }

//         return Padding(
//           padding: EdgeInsets.only(top: 50.h),
//           child: Column(
//             children: [
//               ValueListenableBuilder(
//                   valueListenable: _selectedStudent,
//                   builder: (ctx, value, child) {
//                     return CustomSelectField(
//                       listOptions: state.dropDownItems,
//                       variant: Variant.filled,
//                       handleChange: (e) {
//                         _selectedStudent.value = e;
//                       },
//                       label: "Add Student",
//                       hintText: "",
//                     );
//                   }),
//               SizedBox(height: 12.h),
//               BlocListener<ClassroomCubit, ClassroomState>(
//                 listener: (context, state) {
//                   if (state.isRegistering) {
//                   } else if (state.isRegisteringError) {
//                     customSnackBar(
//                         context: context,
//                         snackBarType: SnackBarType.error,
//                         title: state.errorMessage);
//                   } else if (state.isRegisteringSucess) {
//                     customSnackBar(
//                         context: context,
//                         snackBarType: SnackBarType.success,
//                         title: "Successfully registered Student");
//                   }
//                 },
//                 listenWhen: (previous, current) =>
//                     previous.isRegistering != current.isRegistering,
//                 child: CustomButton(

//                     state:state.isRegistering? isSubjectAssignedToClass
//                         ? ButtonState.enabled
//                         : ButtonState.disabled,
//                     onTap: () {
//                       if (_selectedStudent.value == "") {
//                         customSnackBar(
//                             context: context,
//                             title: "Select a student to proceed",
//                             snackBarType: SnackBarType.error);
//                       } else {
//                         context.read<ClassroomCubit>().postStudentRegistration(
//                             studentId: _selectedStudent.value,
//                             classId: classId,
//                             subjectId: subjectId!);
//                       }
//                     },
//                     disabledMsg:
//                         "Subject needs to be assigned to the classroom",
//                     child: const Text("Add Student")),
//               ),
//               // InkWell(
//               //   child: const Text("\n\n\nnpost registration"),
//               //   onTap: () {
//               //     ClassroomsApi()
//               //         .postStudentRegistration(studentId: "1", subjectId: "6");
//               //   },
//               // ),
//               // InkWell(
//               //   child: const Text("\n\n\get registration"),
//               //   onTap: () {
//               //     ClassroomsApi().getStudentRegistrations();
//               //   },
//               // )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

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
    ValueNotifier<String> _selectedStudent = ValueNotifier<String>("");

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          BlocBuilder<StudentsCubit, StudentsState>(
            builder: (context, state) {
              return ValueListenableBuilder(
                  valueListenable: _selectedStudent,
                  builder: (ctx, value, child) {
                    return CustomSelectField(
                      listOptions: state.dropDownItems,
                      fillColor: ReplyColors.white,
                      variant: Variant.filled,
                      handleChange: (e) {
                        _selectedStudent.value = e;
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
                    if (_selectedStudent.value == "") {
                      customSnackBar(
                          context: context,
                          title: "Select a student to proceed",
                          snackBarType: SnackBarType.error);
                    } else {
                      context.read<ClassroomCubit>().postStudentRegistration(
                          studentId: _selectedStudent.value,
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
