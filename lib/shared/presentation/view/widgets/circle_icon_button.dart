import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_colors.dart';

class CircleIconButton extends AppButton {
  CircleIconButton(
    IconData? icon, {
    super.key,
    double? iconSize,
    Widget? customIcon,
    Color? iconColor,
    Color? backgroundColor,
    super.borderColor,
    super.isDisabled,
    super.onTap,
    double? borderWidth,
    double? padding,
  }) : super(
         shape: BoxShape.circle,
         alignment: null,
         color: backgroundColor,
         borderWidth: borderWidth ?? 0,
         padding: EdgeInsets.all(padding ?? UISizes.sp10),
         child:
             customIcon ??
             Icon(
               icon,
               size: iconSize ?? UISizes.sp24,
               color: iconColor ?? AppColors.white,
             ),
       );

  factory CircleIconButton.outLine(
    IconData? icon, {
    required BuildContext context,
    Color? color,
    Widget? customIcon,
    double borderWidth = 1,
    GestureTapCallback? onTap,
    Color? backgroundColor,
    bool isDisabled = false,
    double? iconSize,
    double? padding,
  }) => CircleIconButton(
    icon,
    backgroundColor: backgroundColor ?? Colors.transparent,
    iconColor: color ?? context.colors.surfaceContainerHighest,
    borderColor: color ?? context.colors.surfaceContainerLow,
    customIcon: customIcon,
    borderWidth: borderWidth,
    iconSize: iconSize,
    onTap: onTap,
    padding: padding,
    isDisabled: isDisabled,
  );
}
