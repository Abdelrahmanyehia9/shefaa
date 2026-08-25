import 'package:flutter/material.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton.outLine(AppIcons.search, context: context);
  }
}
