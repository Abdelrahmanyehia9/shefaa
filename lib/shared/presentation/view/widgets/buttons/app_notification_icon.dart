import 'package:flutter/material.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class AppNotificationIcon extends StatelessWidget {
  const AppNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Badge(
      smallSize: UISizes.sp10,
      child: CircleIconButton(
        onTap: ()=>context.pushNamed(Routes.notifications),
        AppIcons.notification,
        iconSize: UISizes.sp24,
        padding: UISizes.sp6,
      ),
    );
  }
}
