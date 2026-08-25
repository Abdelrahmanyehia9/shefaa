import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class AppIconText extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Widget? customIcon, customText;
  final double? iconSize, gap, textSize;
  final TextStyle? textStyle;
  final Color? iconColor, textColor, color;
  final bool reverse, expandedText;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final MainAxisAlignment mainAxisAlignment;

  const AppIconText({
    super.key,
    this.color,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.customIcon,
    this.reverse = false,
    this.gap,
    this.textOverflow,
    this.icon,
    this.iconColor,
    this.text,
    this.iconSize,
    this.textColor,
    this.textStyle,
    this.textSize,
    this.customText,
    this.maxLines,
    this.expandedText = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = this.iconColor ?? color;
    final textColor = this.textColor ?? color;
    final style = textStyle ?? context.textTheme.bodySmall;

    final children = <Widget>[
      if (customIcon != null)
        customIcon!
      else if (icon != null)
        Icon(icon, size: iconSize, color: iconColor),

      if (customText != null)
        expandedText ? Expanded(child: customText!) : customText!
      else if (text != null)
        expandedText
            ? Expanded(
                child: AppText(
                  text!,
                  overflow: textOverflow,
                  maxLines: maxLines,
                  style: style?.copyWith(color: textColor, fontSize: textSize),
                ),
              )
            : AppText(
                text!,
                style: style?.copyWith(color: textColor, fontSize: textSize),
              ),
    ];

    return Row(
      spacing: gap ?? UISizes.w6,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: expandedText ? MainAxisSize.max : MainAxisSize.min,
      children: reverse ? children.reversed.toList() : children,
    );
  }
}
