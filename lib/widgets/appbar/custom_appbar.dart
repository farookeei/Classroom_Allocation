import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/color_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Key? key;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final double? elevation;
  final Widget? icon;
  final bool? automaticallyImplyLeading;
  final Function()? onBackapped;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final bool isLeadingEnabled;
  const CustomAppBar({
    this.key,
    this.title,
    this.backgroundColor,
    this.onBackapped,
    this.titleStyle,
    this.actions,
    this.elevation,
    this.icon,
    this.automaticallyImplyLeading,
    this.bottom,
    this.flexibleSpace,
    this.isLeadingEnabled = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      toolbarHeight: kToolbarHeight.h,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      scrolledUnderElevation: 0,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor,
      flexibleSpace: flexibleSpace,
      leading: isLeadingEnabled
          ? IconButton(
              onPressed: () {
                onBackapped == null
                    ? Navigator.canPop(context) == false
                        ? SystemNavigator.pop()
                        : Navigator.pop(context)
                    : onBackapped!();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ReplyColors.white,
                size: 22.sp,
              ),
            )
          : null,
      bottom: bottom,
      title: title != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                Flexible(
                  child: Text(
                    title!,
                    style: titleStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ReplyColors.white),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
              ],
            )
          : null,
      centerTitle: true,
      actions: actions,
    );
  }
}
