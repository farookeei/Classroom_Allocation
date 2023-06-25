import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/subjects/cubit/subjects_cubit.dart';
import 'package:test_sample/features/subjects/screens/subjectDetail.dart';

import '../../../layout/layout_scaffold.dart';
import '../../../widgets/listtile/custom_listtile.dart';
import '../../../widgets/progress_indicator/custom_progress_indicator.dart';

class SubejctsScreen extends StatelessWidget {
  static const routeName = '/subjects';

  const SubejctsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
        child: BlocProvider(
      create: (context) => SubjectsCubit()..getSubjectslist(),
      child: BlocBuilder<SubjectsCubit, SubjectsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CustomProgressIndicator());
          } else if (state.isError) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shrinkWrap: true,
              itemCount: state.subjectsList.length,
              itemBuilder: (ctx, i) {
                return CustomListTile(
                  onTap: () {
                    Navigator.pushNamed(context, SubjectDetail.routeName,
                        arguments: state.subjectsList[i].id.toString());
                  },
                  title: state.subjectsList[i].name!,
                  subtitle: state.subjectsList[i].teacher.toString(),
                );
              });
        },
      ),
    ));
  }
}
