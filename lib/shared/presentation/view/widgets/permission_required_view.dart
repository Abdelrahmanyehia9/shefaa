import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/extensions/widgets.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/utils/app_icons.dart';

class PermissionRequiredView extends StatelessWidget {
  final List<Widget> Function(BuildContext context)? actions;
  final AppPermission permission;

  const PermissionRequiredView({
    super.key,
    required this.permission,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.h12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppChip(
          shape: BoxShape.circle,
          paddingVr: UISizes.sp24,
          paddingHr: UISizes.sp24,
          monochromatic: true,
          child: Icon(
            permission.icon,
            size: UISizes.sp84,
            color: context.colors.primary,
          ),
        ),
        4.spaceVr,
        _buildTitleAndSubTitle(),
        if (actions != null) ...[4.spaceVr, ...actions!.call(context)],
      ],
    );
  }

  Widget _buildTitleAndSubTitle() => Builder(
    builder: (context) => Column(
      children: [
        AppText(
          textAlign: TextAlign.center,
          "نريد صلاحية ${permission.text}",
          style: context.textTheme.displaySmall,
        ),
        AppText(
          textAlign: TextAlign.center,
          permission.reason,
          style: context.textTheme.bodyLarge,
          color: context.colors.surfaceContainer,
        ),
      ],
    ),
  );
}
