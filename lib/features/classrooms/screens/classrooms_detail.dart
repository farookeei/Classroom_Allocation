import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/layout/layout_scaffold.dart';

import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class ClassRoomDetail extends StatelessWidget {
  static const routeName = '/classrooms-detail';
  final String id;
  const ClassRoomDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ClassroomCubit>().getClassRoomDetail(id: id);
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
              Text(
                state.classRoomDetail!.name!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.classRoomDetail!.layout!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                state.classRoomDetail!.size.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          );
        },
      ),
    ));
  }
}
