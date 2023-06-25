import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class StudentDetail extends StatelessWidget {
  static const routeName = '/student-detail';
  final String id;
  const StudentDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<StudentsCubit>().getStudentDetail(id: id);
    return LayoutScaffold(
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
              Text(
                state.studentDetail!.name!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.studentDetail!.age.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.studentDetail!.email!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          );
        },
      ),
    ));
  }
}
