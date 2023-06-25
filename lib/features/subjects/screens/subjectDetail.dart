import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class SubjectDetail extends StatelessWidget {
  static const routeName = '/subject-detail';
  final String id;
  const SubjectDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<SubjectsCubit>().getSubjectDetail(id: id);
    return LayoutScaffold(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: BlocBuilder<SubjectsCubit, SubjectsState>(
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
                state.subjectDetail!.name!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.subjectDetail!.credits.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.subjectDetail!.teacher!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          );
        },
      ),
    ));
  }
}
