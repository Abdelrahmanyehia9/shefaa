import 'package:flutter/material.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppShareButton extends StatelessWidget {
  final bool isOutlined;
  final Color? bgColor, iconColor;
  const AppShareButton({
    super.key,
    this.iconColor,
    this.bgColor,
    this.isOutlined = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return CircleIconButton.outLine(AppIcons.share, context: context);
    }
    return CircleIconButton(
      AppIcons.share,
      iconColor: iconColor,
      backgroundColor: bgColor,
    );
  }
}
