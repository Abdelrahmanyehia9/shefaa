import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/core/components/app_text.dart';

class AppListTile extends StatelessWidget {
  final String? title, subtitle;
  final double? leadingIconSize,
      trailingIconSize,
      minTileHeight,
      minLeadingWidth;
  final TextStyle? titleStyle, subtitleStyle;
  final IconData? trailing, leading;
  final bool showTrailing;
  final bool showLeading;
  final Color? leadingIconColor, trailingIconColor;
  final GestureTapCallback? onTap;
  final EdgeInsets? contentPadding;
  final Widget? customLeading, customTitle, customSubtitle, customTrailing;

  const AppListTile({
    super.key,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.contentPadding,
    this.subtitleStyle,
    this.trailing,
    this.onTap,
    this.leading,
    this.showTrailing = true,
    this.customLeading,
    this.customTitle,
    this.customSubtitle,
    this.customTrailing,
    this.leadingIconSize,
    this.minTileHeight,
    this.minLeadingWidth,
    this.trailingIconSize,
    this.showLeading = true,
    this.leadingIconColor,
    this.trailingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: ListTile(
        onTap: onTap,

        contentPadding: contentPadding,
        minTileHeight: minTileHeight,
        minLeadingWidth: minLeadingWidth,
        leading: showLeading
            ? customLeading ??
                  Icon(
                    leading,
                    size: leadingIconSize ?? UISizes.sp40,
                    color: leadingIconColor,
                  )
            : null,
        trailing: showTrailing
            ? customTrailing ??
                  Icon(
                    trailing ?? AppIcons.arrowForward,
                    size: trailingIconSize ?? UISizes.sp18,
                    color: trailingIconColor,
                  )
            : null,
        title:
            customTitle ??
            AppText(
              title,
              style: titleStyle ?? context.textTheme.labelMedium,
              height: 0,
            ),
        subtitle:
            customSubtitle ??
            (subtitle == null
                ? null
                : AppText(
                    subtitle,
                    style: subtitleStyle ?? context.textTheme.bodySmall,
                    color: context.colors.surfaceContainer,
                    height: 0,
                  )),
      ),
    );
  }
}
