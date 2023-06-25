import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/color_variables.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
  custom,
}

void customSnackBar({
  required final BuildContext context,
  final Color? bgColor,
  final Color? foregroundColor,
  required final SnackBarType snackBarType,
  required final String title,
  final String? text,
  final IconData? icon,
  final Widget? iconWidget,
  final int duration = 3,
}) {
  print('Snackbar used');
  showFlash(
    context: context,
    duration: Duration(seconds: duration),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        boxShadows: kElevationToShadow[5],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        backgroundColor: returnColorBg(snackBarType, bgColor),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: FlashBar(
          icon: iconWidget ?? returnIcon(snackBarType, foregroundColor, icon),
          title: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: returnColorFg(snackBarType, foregroundColor)),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.close,
                      color: ReplyColors.neutralBold,
                      size: 20.r,
                    ),
                    onTap: () {
                      controller.dismiss();
                    },
                  )
                ],
              )),
          content: text == null
              ? const SizedBox()
              : Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: returnColorFg(snackBarType, foregroundColor)),
                ),
        ),
      );
    },
  );
}

Color returnColorBg(snackBarType, backgroundColor) {
  switch (snackBarType) {
    case SnackBarType.success:
      return ReplyColors.greenLight;

    case SnackBarType.error:
      return ReplyColors.redLight;

    case SnackBarType.warning:
      return ReplyColors.yellowLight;

    case SnackBarType.info:
      return ReplyColors.blueLight;

    case SnackBarType.custom:
      return backgroundColor;

    default:
      return ReplyColors.redLight;
  }
}

Color returnColorFg(snackBarType, foregroundColor) {
  switch (snackBarType) {
    case SnackBarType.success:
      return ReplyColors.green100;

    case SnackBarType.error:
      return ReplyColors.red100;

    case SnackBarType.warning:
      return ReplyColors.yellowBold;

    case SnackBarType.info:
      return ReplyColors.blue100;

    case SnackBarType.custom:
      return foregroundColor;

    default:
      return ReplyColors.red100;
  }
}

Widget returnIcon(snackBarType, foregroundColor, icon) {
  switch (snackBarType) {
    case SnackBarType.success:
      return const Icon(
        Icons.check,
        color: ReplyColors.green100,
      );
    case SnackBarType.error:
      return const Icon(
        Icons.error,
        color: ReplyColors.red100,
      );
    case SnackBarType.warning:
      return const Icon(
        Icons.warning,
        color: ReplyColors.yellowBold,
      );
    case SnackBarType.info:
      return const Icon(
        Icons.info,
        color: ReplyColors.blue100,
      );
    default:
      return Icon(
        icon,
        color: foregroundColor,
      );
  }
}
