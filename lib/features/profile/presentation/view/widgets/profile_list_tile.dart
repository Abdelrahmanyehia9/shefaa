import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_list_tile.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class ProfileListTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? customTrailing;
  const ProfileListTile({
    super.key,
    this.customTrailing,
    required this.leading,
    required this.title,
    this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: leading,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minTileHeight: UISizes.h48,
      leadingIconSize: UISizes.sp28,
      customTrailing: customTrailing,
      titleStyle: context.textTheme.labelLarge,
      leadingIconColor: context.colors.primary,
      trailingIconColor: context.colors.primary,
      title: title,
    );
  }
}
