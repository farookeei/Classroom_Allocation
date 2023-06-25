import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sample/features/classrooms/cubit/classroom_cubit.dart';
import 'package:test_sample/features/classrooms/widgets/detail_tile.dart';

import '../themes/color_variables.dart';
import 'custom_divider.dart';

class SettingsTileModel {
  final String title;
  final Function()? onTap;
  final String? subtitle;
  final String? trailing;
  final Widget? leading;

  final Key? key;

  final Color? titleColor;

  const SettingsTileModel({
    required this.title,
    this.onTap,
    this.key,
    this.subtitle,
    this.trailing,
    this.titleColor,
    this.leading,
  });
}

class SettingsListTileBuilder extends StatelessWidget {
  const SettingsListTileBuilder({
    Key? key,
    required this.items,
    this.background,
  }) : super(key: key);

  final List<SettingsTileModel> items;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background ?? ReplyColors.white,
          borderRadius: BorderRadius.circular(5.r)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return SettingsListTile(
            titleColor: items[index].titleColor,
            leading: items[index].leading,
            title: items[index].title,
            subtitle: items[index].subtitle,
            onTap: items[index].onTap,
            trailing: items[index].trailing,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return CustomAppDivider();
        },
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function()? onTap;
  final String? trailing;
  final Widget? leading;

  final bool isDisabled;
  final Color? titleColor;
  //final Key? key;

  const SettingsListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.onTap,
    this.isDisabled = false,
    this.trailing,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log("KEY CHECK ${key.toString()}  ${key.hashCode.toString()}");
    return ListTile(
      //  key: key,
      leading: leading != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading!,
              ],
            )
          : null,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
      title: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: isDisabled
                    ? ReplyColors.neutral25
                    : titleColor ?? ReplyColors.neutral100),
          ),
        ],
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isDisabled
                        ? ReplyColors.neutral25
                        : ReplyColors.neutral75,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          : null,
      trailing: Text(
        trailing ?? "",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
