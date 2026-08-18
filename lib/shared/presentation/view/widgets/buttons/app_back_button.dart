import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton.outLine(
      context: context,
      onTap: () {
        if (context.canPop()) {
          context.pop();
        }
      },
      AppIcons.arrowBackward,
    );
  }
}
