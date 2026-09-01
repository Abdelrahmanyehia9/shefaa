import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/extensions/color.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';

class DefaultStickyFooter extends StatelessWidget {
  final Widget? customButton;

  final String? title;
  final VoidCallback? onTap;

  const DefaultStickyFooter({
    super.key,
    this.onTap,
    this.title,
    this.customButton,
  }) : assert(
         customButton != null || title != null,
         'Either title or customButton must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return AppChip(
      paddingVr: UISizes.sp16,
      paddingHr: UISizes.sp16,
      radius: UISizes.sp16,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAppOpacity(0.025),
          offset: Offset(0, -UISizes.h8),
          blurRadius: UISizes.r12,
        ),
      ],
      color: context.scaffoldBackgroundColor,
      child: Align(
        alignment: AlignmentGeometry.topCenter,
        child: customButton ?? AppButton.filled(title ?? "", onTap: onTap),
      ),
    );
  }
}
