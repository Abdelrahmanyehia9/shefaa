import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppBackButton extends StatelessWidget {
  final bool isOutlined;
  final Color? bgColor, iconColor;
  final VoidCallback? onBack;
  const AppBackButton({
    super.key,
    this.bgColor,
    this.iconColor,
    this.onBack,
    this.isOutlined = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return CircleIconButton.outLine(
        context: context,
        onTap:
            onBack ??
            () {
              if (context.canPop()) {
                context.pop();
              }
            },
        AppIcons.arrowBackward,
      );
    }
    return CircleIconButton(
      backgroundColor: bgColor,
      iconColor: iconColor,
      onTap:
          onBack ??
          () {
            if (context.canPop()) {
              context.pop();
            }
          },
      AppIcons.arrowBackward,
    );
  }
}
