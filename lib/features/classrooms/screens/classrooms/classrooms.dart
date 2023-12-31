import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/screens/classroom_details/classrooms_detail.dart';
import 'package:test_sample/layout/layout_scaffold.dart';
import 'package:test_sample/widgets/appbar/custom_appbar.dart';

import '../../../../themes/color_variables.dart';
import '../../../../widgets/listtile/custom_listtile.dart';
import '../../../../widgets/progress_indicator/custom_progress_indicator.dart';

class ClassRoomsScreen extends StatelessWidget {
  static const routeName = '/classrooms-screen';

  const ClassRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ClassroomCubit>().getClassRoomslist();
    return LayoutScaffold(
        backgroundColor: ReplyColors.neutralLight,
        customAppBar: const CustomAppBar(
          title: "Classrooms",
        ),
        child: RefreshIndicator(
          onRefresh: () => context.read<ClassroomCubit>().getClassRoomslist(),
          child: BlocBuilder<ClassroomCubit, ClassroomState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (state.isError) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount: state.classRoomsList.length,
                  itemBuilder: (ctx, i) {
                    //? we are not getting subject id while listing classrooms.so,cannot add that here
                    return CustomListTile(
                      title: "name: ${state.classRoomsList[i].name!}",
                      subtitle: "type: ${state.classRoomsList[i].layout!}",
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ClassRoomDetail.routeName,
                            arguments: state.classRoomsList[i].id.toString());
                      },
                    );
                  });
            },
          ),
        ));
  }
}
