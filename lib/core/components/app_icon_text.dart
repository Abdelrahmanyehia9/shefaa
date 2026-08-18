import 'package:flutter/material.dart';

import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppIconText extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Widget? customIcon, customText;
  final double? iconSize, gap;
  final TextStyle? textStyle;
  final Color? iconColor, textColor, color;
  final bool reverse;
  final MainAxisAlignment mainAxisAlignment;

  const AppIconText({
    super.key,
    this.color,
    this.customIcon,
    this.customText,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.reverse = false,
    this.gap,
    this.icon,
    this.iconColor,
    this.text,
    this.iconSize,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (customIcon != null)
        customIcon!
      else if (icon != null)
        Icon(icon, size: iconSize, color: iconColor ?? color),

      if (customText != null)
        customText!
      else if (text != null)
        Text(
          text!,
          style: (textStyle ?? context.textTheme.bodySmall)?.copyWith(
            color: textColor ?? color,
          ),
        ),
    ];

    return Row(
      spacing: gap ?? UISizes.w6,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: reverse ? children.reversed.toList() : children,
    );
  }
}
