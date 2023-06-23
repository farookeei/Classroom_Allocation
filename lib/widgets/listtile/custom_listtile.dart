import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/themes/color_variables.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onTap;
  const CustomListTile(
      {super.key, this.onTap, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(width: 1, color: ReplyColors.neutral75),
      ),
      child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}
