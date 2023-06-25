import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/color_variables.dart';

class CustomAppDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? height;
  final double? rightSpacing;
  final double? leftSpacing;

  const CustomAppDivider({
    Key? key,
    this.color,
    this.thickness,
    this.height,
    this.rightSpacing,
    this.leftSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? ReplyColors.neutral100.withOpacity(0.2),
      thickness: thickness ?? 0.4.h,
      height: height ?? 0.sp,
      indent: rightSpacing,
      endIndent: leftSpacing,
    );
  }
}
